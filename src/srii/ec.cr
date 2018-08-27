require "./ec/*"

module OpenSSL::EC
  alias Curves = LibCryptoEC::Curves

  struct Method
    getter to_unsafe : LibCryptoEC::Method

    def initialize(@to_unsafe)
    end

    SIMPLE   = new LibCryptoEC.GFp_simple_method
    MONT     = new LibCryptoEC.GFp_mont_method
    NIST     = new LibCryptoEC.GFp_nist_method
    NISTp256 = new LibCryptoEC.GFp_nistp256_method
    NISTp521 = new LibCryptoEC.GFp_nistp521_method

    def field_type : LibC::Int
      LibCryptoEC.method_get_field_type self
    end
  end

  class Group
    getter to_unsafe : LibCryptoEC::Group

    def initialize(method : Method)
      @to_unsafe = LibCryptoEC.group_new method
    end

    def initialize(nid : Curves)
      @to_unsafe = LibCryptoEC.group_new_by_curve_name nid
    end

    def finalize
      LibCryptoEC.group_free self
    end

    def clone
      LibCryptoEC.group_dup self
    end

    def method
      Method.new LibCryptoEC.group_method_of self
    end

    private def check(i : LibC::Int)
      Error.check if i != 1
      self
    end

    def set_generator(generator : Point, order : Bignum, cofact : Bignum?)
      check LibCryptoEC.group_set_generator self, generator, order, cofact
    end

    def generator? : Point?
      Point.new LibCryptoEC.group_get0_generator self
    end

    def generator
      generator?.not_nil!
    end

    def name : Int
      LibCryptoEC.group_get_curve_name self
    end

    def name=(nid : LibC::Int) : Int
      LibCryptoEC.group_set_curve_name self, nid
      nid
    end
  end

  struct Point
    alias ConversionForm = LibCryptoEC::PointConversionFormT
    getter to_unsafe : LibCryptoEC::Point
    @finalizer : Finalizer?

    class Finalizer
      def initialize(@pointer : LibCryptoEC::Point)
      end

      def finalize
        LibCryptoEC.point_clear_free @pointer
      end
    end

    def self.new(pointer : LibCryptoEC::Point)
      return nil if pointer.null?
      ret = allocate
      ret.initialize pointer
      ret
    end

    def self.new(*args)
      ret = allocate
      ret.initialize *args
      ret
    end

    def initialize(@to_unsafe)
    end

    def initialize(group : Group)
      @to_unsafe = LibCryptoEC.point_new group
      @finalizer = Finalizer.new @to_unsafe
    end

    def initialize(group : Group, x : Bignum, y : Bignum, ctx : Bignum::Context? = nil)
      initialize group
      coordinate_set group, x, y, ctx
    end

    def initialize(group : Group, x : Bignum, y_bit : Int8, ctx : Bignum::Context? = nil)
      initialize group
      check LibCryptoEC.point_set_compressed_coordinates_GFp group, self, x, y_bit, ctx
    end

    private def self.check(i : LibC::Int)
      Error.check if i != 1
      self
    end

    private def check(i : LibC::Int)
      Error.check if i != 1
      self
    end

    def self.from_bytes(group : Group, data : Bytes, ctx : Bignum::Context? = nil)
      ret = new group
      check LibCryptoEC.point_oct2point group, ret, data, data.size, ctx
      ret
    end

    def to_bytes(group : Group, conversion_form : LibCryptoEC::PointConversionFormT, ctx : Bignum::Context? = nil)
      size = LibCryptoEC.point_point2oct group, self, conversion_form, nil, 0, ctx
      Error.check if size == 0
      ret = Bytes.new size
      size = LibCryptoEC.point_point2oct group, self, conversion_form, ret, size, ctx
      Error.check if size == 0
      ret
    end

    def equal(group : Group, other : Point, ctx : Bignum::Context? = nil)
      0 == LibCryptoEC.point_cmp group, self, other, ctx
    end

    def coordinate(group : Group, ctx : Bignum::Context? = nil) : {Bignum, Bignum}
      x, y = Bignum.new, Bignum.new
      check LibCryptoEC.point_get_affine_coordinates_GFp group, self, x, y, ctx
      return x, y
    end

    def set_coordinate(group : Group, x : Bignum, y : Bignum, ctx : Bignum::Context? = nil) : {Bignum, Bignum}
      check LibCryptoEC.point_set_affine_coordinates_GFp group, self, x, y, ctx
      return x, y
    end
  end
end
