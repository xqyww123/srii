require "./ec.cr"

module SRII
  class Host
    struct Identity
      getter pubkey : OpenSSL::EC::Point

      def initialize(buf : Protobuf::Buffer)
        @pubkey = OpenSSL::EC::Point.from_bytes GROUP, buf.read_bytes.not_nil!
      end

      def initialize(@pubkey)
      end

      def to_bytes
        @pubkey.to_bytes ::SRII::Config::EC::GROUP,
          OpenSSL::EC::Point::ConversionForm::Compressed
      end

      def to_protobuf(io : IO)
        buf = Protobuf::Buffer.new(io)
        buf.write_message self
      end

      class ::Protobuf::Buffer
        def write_message(id : ::SRII::Host::Identity)
          write_bytes id.to_bytes
        end
      end

      def self.from_protobuf(io : IO)
        new Protobuf::Buffer.new io
      end

      GROUP = Config::EC::GROUP

      def ==(o : OpenSSL::EC::Point)
        @pubkey.equal GROUP, o
      end

      def ==(o : Identity)
        self == o.pubkey
      end
    end

    getter identity : Identity
    delegate pubkey, to: @identity

    include Protobuf::Message

    def initialize(buf : Protobuf::Buffer)
      buf.read_info
      @identity = Identity.new buf
    end

    def to_protobuf(io : IO)
      buf = Protobuf::Buffer.new(io)
      buf.write_message self
    end

    class ::Protobuf::Buffer
      def write_message(host : ::SRII::Host)
        write_info 1, 2
        write_message host.identity
      end
    end

    def self.from_protobuf(io : IO)
      new Protobuf::Buffer.new io
    end

    def initialize(@identity)
    end

    delegate pubkey, to: @identity
    def_equals_and_hash @identity

    @@hosts = {} of Identity => Host

    def self.host(id : Identity)
      @@hosts.fetch id do
        raise HostNotRegistered.new id
      end
    end

    def self.register_host(id : Identity)
      @@hosts[id] ||= Host.new id
      # TODO : verification & info
    end

    struct Group
      include Protobuf::Message

      contract_of "proto2" do
        repeated :hosts, Host, 1
      end
    end
  end
end
