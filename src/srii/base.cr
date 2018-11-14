require "./crypto.cr"

module SRII
  class Host
    struct Identity
      getter pubkey : Crypto::PubKey

      # getter digest : Bytes

      def initialize(@pubkey)
        # @digest = Config.digest @pubkey.to_bytes
      end

      delegate to_bytes, hash, free, to: @pubkey

      GROUP = Config::EC::GROUP

      def initialize(pull : MessagePack::Unpacker)
        @pubkey = Crypto::PubKey.new pull.read_binary
      end

      def to_msgpack(packer : MessagePack::Packer)
        packer.write to_bytes
      end

      def ==(o : Crypto::PubKey)
        @pubkey == o
      end

      def ==(o : Identity)
        self == o.pubkey
      end

      def inspect(io : IO)
        to_s io
      end

      def to_s(io : IO)
        # io << @digest.hexstring
        hash.to_s 16, io
      end
    end

    delegate pubkey, to: @identity
    getter identity : Identity
    MessagePack.mapping({identity: {key: "i", type: Identity}},
      strict: true, emit_nulls: false)

    private def initialize(@identity)
    end

    def finalize
      @identity.free
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
