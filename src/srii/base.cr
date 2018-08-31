require "./ec.cr"

module SRII
  class Host
    struct Identity
      getter pubkey : OpenSSL::EC::Point

      def initialize(@pubkey)
      end

      def to_bytes
        @pubkey.to_bytes ::SRII::Config::EC::GROUP,
          OpenSSL::EC::Point::ConversionForm::Compressed
      end

      GROUP = Config::EC::GROUP

      def ==(o : OpenSSL::EC::Point)
        @pubkey.equal GROUP, o
      end

      def ==(o : Identity)
        self == o.pubkey
      end

      def initialize(pull : MessagePack::Unpacker)
        @pubkey = OpenSSL::EC::Point.from_bytes GROUP, pull.read_binary
      end

      def to_msgpack(packer : MessagePack::Packer)
        packer.write to_bytes
      end
    end

    delegate pubkey, to: @identity
    getter identity : Identity
    MessagePack.mapping({identity: {key: "i", type: Identity}},
      strict: true, emit_nulls: false)

    @@host_cnt : Int32 = 0

    def self.assign_id
      @@host_cnt += 1
    end

    getter ref_id : Int32 = assign_id

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
      include MessagePack::Serializable

      getter hosts : Array(Host)
      def_equals_and_hash @hosts
    end
  end
end
