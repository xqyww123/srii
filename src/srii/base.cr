require "./ec.cr"

module SRII
  class Host
    struct Identity
      getter pubkey : OpenSSL::EC::Point
      getter hash : UInt64

      def initialize(@pubkey)
        @hash = to_bytes.hash
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
        @hash = to_bytes.hash
      end

      def to_msgpack(packer : MessagePack::Packer)
        packer.write to_bytes
      end

      def inspect(io : IO)
        io << to_bytes.hexstring
      end

      def to_s(io : IO)
        io << to_bytes.hexstring
      end
    end

    delegate pubkey, to: @identity
    getter identity : Identity
    MessagePack.mapping({identity: {key: "i", type: Identity}},
      strict: true, emit_nulls: false)

    private def initialize(@identity)
    end

    @@host_cnt : Int32 = 0

    def self.assign_id
      @@host_cnt += 1
    end

    alias Ref = Int32
    getter ref_id : Ref = assign_id

    delegate pubkey, to: @identity
    def_equals_and_hash @identity

    def to_s(io : IO)
      io << "Host#"
      @ref_id.to_s io
      io << '('
      @identity.to_s io
      io << ')'
    end

    def inspect(io : IO)
      to_s io
    end

    @@hosts = {} of Identity => Host | Group
    @@hosts_index = {} of Int32 => Host | Group

    {% for element in [:host, :group] %}
    def self.{{element.id}}(id : Identity) : {{element.id.camelcase}}
      @@hosts.fetch id do
        raise HostNotRegistered.new id
      end.as {{element.id.camelcase}}
    end

    def self.{{element.id}}(i : Int32) : {{element.id.camelcase}}
      @@hosts_index.fetch i do
        raise HostIndNotRegistered.new i
      end.as {{element.id.camelcase}}
    end
    {% end %}

    def self.register_host(id : Identity)
      if @@hosts[id]?
        raise HostHasRegistered.new id
      else
        @@hosts[id] = host = new id
        @@hosts_index[host.ref_id] = host
      end
      # TODO : verification & info
    end

    struct Group
      include MessagePack::Serializable

      getter hosts : Array(Host)

      # getter identity : Identity

      def initialize(@hosts)
      end

      def_equals_and_hash @hosts
    end
  end
end
