module SRII
  module Crypto
    extend self

    @[Link(ldflags: "-l:libsrii-crypto.a -l:libsrii-relic.a -lgmp")]
    lib LibBLS
      fun core_init
      fun core_clean
      fun set_parm = ep_param_set_any_pairf
      fun pubkey_write = ep2_write_bin(bin : UInt8*, len : LibC::Int, ep : Void*, pack : LibC::Int)
      fun pubkey_size = ep2_size_bin(ep : Void*, pack : LibC::Int) : LibC::Int
      fun pubkey_read = ep2_read_bin(ep : Void*, bin : UInt8*, len : LibC::Int)
      fun bls_gen = cp_bls_gen(pri : Void*, pub : Void*) : LibC::Int
      fun bls_sign = cp_bls_sig(sig : Void*, msg : UInt8*, len : LibC::Int, pri : Void*) : LibC::Int
      fun bls_ver = cp_bls_ver(sig : Void*, msg : UInt8*, len : LibC::Int, pub : Void*) : LibC::Int
      fun make_pub = make_ep2 : Void*
      fun make_pri = make_bn : Void*
      fun make_bn : Void*
      fun make_bn1(num : LibC::Int) : Void*
      fun make_sig = make_ep : Void*
      $size_sig : LibC::SizeT
      $size_pub : LibC::SizeT
      $size_pri : LibC::SizeT

      fun pub_get_gen = ep2_curve_get_gen(pub : Void*)
      fun pub_mul_gen = ep2_mul_gen(re : Void*, bn_k : Void*)
      fun pub_print = ep2_print(pub : Void*)
    end

    LibBLS.core_init
    LibBLS.set_parm

    SIZE_PUB = LibBLS.size_pub

    struct PubKey
      getter to_unsafe : Void*
      getter to_bytes : Bytes

      def initialize(@to_unsafe)
        @to_bytes = Bytes.new LibBLS.pubkey_size @to_unsafe, 1
        LibBLS.pubkey_write @to_bytes, @to_bytes.size, @to_unsafe, 1
      end

      def initialize(@to_unsafe, @to_bytes)
      end

      def initialize(@to_bytes)
        @to_unsafe = LibBLS.make_pub
        LibBLS.pubkey_read @to_unsafe, @to_bytes, @to_bytes.size
      end

      def initialize(ind : Int)
        @to_unsafe = LibBLS.make_pub
        LibBLS.pub_mul_gen @to_unsafe, LibBLS.make_bn1 ind
        @to_bytes = Bytes.new LibBLS.pubkey_size @to_unsafe, 1
        LibBLS.pubkey_write @to_bytes, @to_bytes.size, @to_unsafe, 1
      end

      def free
        LibC.free @to_unsafe
      end

      delegate hash, size, to: @to_bytes

      def ==(o : PubKey)
        @to_bytes == o.to_bytes
      end

      def inspect(io : IO)
        io << @to_bytes.hexstring
      end
    end

    struct PrivateKey
      getter pubkey : PubKey
      getter to_unsafe : Void*

      def initialize
        @to_unsafe = LibBLS.make_pri
        pub = LibBLS.make_pub
        LibBLS.bls_gen @to_unsafe, pub
        @pubkey = PubKey.new pub
      end

      def free
        LibC.free @to_unsafe
        @pubkey.free
      end
    end

    struct Bignum
      getter to_unsafe : Void*

      def initialize(@to_unsafe)
      end

      def initialize
        @to_unsafe = LibBLS.make_bn
      end

      def initialize(num : Int)
        @to_unsafe = LibBLS.make_bn1 num
      end

      def free
        LibC.free @to_unsafe
      end
    end
  end
end
