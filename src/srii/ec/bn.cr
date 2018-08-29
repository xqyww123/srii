module OpenSSL
  class Bignum
    class Context
      getter to_unsafe : LibCryptoBN::Ctx

      def initialize(@to_unsafe)
      end

      def initialize
        @to_unsafe = LibCryptoBN.ctx_new
      end

      def finalize
        LibCryptoBN.ctx_free self
      end

      def start
        LibCryptoBN.ctx_start self
      end

      def end
        LibCryptoBN.ctx_end self
      end

      def enter(&block)
        begin
          start
          yield
        ensure
          self.end
        end
      end
    end

    getter to_unsafe : LibCryptoBN::Bignum*

    def initialize(@to_unsafe)
    end

    def initialize
      @to_unsafe = LibCryptoBN.new
    end

    def initialize(number : Int)
      @to_unsafe = LibCryptoBN.new
      check LibCryptoBN.set_word number
    end

    ONE     = new LibCryptoBN.value_one
    OPTIONS = String.new LibCryptoBN.options

    private def check(i : LibC::Int)
      Error.check if i != 1
      self
    end

    def rand(bits : Int, top : Int, bottom : Int)
      check LibCryptoBN.rand self, bits, top, bottom
    end

    def pseudo_rand(bits : Int, top : Int, bottom : Int)
      check LibCryptoBN.pseudo_rand self, bits, top, bottom
    end

    def rand_range(range : Bignum)
      check LibCryptoBN.rand_range self, range
    end

    def pseudo_rand_range(range : Bignum)
      check LibCryptoBN.pseudo_rand_range self, range
    end

    module ClassMethods
      delegate rand_range, pseudo_rand_range, rand, pseudo_rand, to: new
    end

    extend ClassMethods

    def num_bits : Int
      LibCryptoBN.num_bits self
    end

    def finalize
      LibCryptoBN.free self
    end

    def clear
      LibCryptoBN.clear self
      self
    end

    def swap(other : Bignum)
      LibCryptoBN.swap self, other
      self
    end

    def from_bin(bin : Bytes)
      new LibCryptoBN.bin2bn bin, bin.size, self
    end

    def num_bytes
      (num_bits + 7) / 8
    end

    def to_bin
      bin = Bytes.new num_bytes
      LibCryptoBN.bn2bin self, bin
      bin
    end

    def from_mpi(mpi : Bytes)
      new LibCryptoBN.mpi2bn mpi, mpi.size, self
    end

    def to_mpi
      mpi = Bytes.new LibCryptoBN.bn2mpi self, Pointer(Void).null
      LibCryptoBN.bn2mpi self, mpi
      mpi
    end

    module ClassMethods
      delegate from_bin, from_mpi, to: new
    end

    macro arithmetic_binary(name, sym = nil, *, operand_type = Bignum, in_place = true, mod = nil)
            def {{name}}(o : {{operand_type}}) : Bignum
                ret = new
                check LibCryptoBN.{{name}} ret, self, o
                ret
            end
            {% if in_place %}
            def {{name}}!(o : {{operand_type}}) : Bignum
                check LibCryptoBN.{{name}}, self, self, o
                self
            end
            {% end %}
            {% if sym != nil %}
            def {{sym.id}}(o : {{operand_type}}) : Bignum
                {{name}} o
            end
            {% end %}
            {% if mod %}
            def mod_{{name}}(operand : Bignum, modulo : Bignum, ctx : Context? = nil)
                ret = new
                check LibCryptoBN.mod_{{name}} ret, self, operand, modulo, ctx
                ret
            end
            {% if in_place %}
                def mod_{{name}}!(operand : Bignum, modulo : Bignum, ctx : Context? = nil)
                    check LibCryptoBN.mod_{{name}} ret, self, operand, modulo, ctx
                    self
                end
            {% end %}
            {% if mod == :quick %}
                def mod_{{name}}_quick(operand : Bignum, modulo : Bignum, ctx : Context? = nil)
                    ret = new
                    check LibCryptoBN.mod_{{name}}_quick ret, self, operand, modulo, ctx
                    ret
                end
                {% if in_place %}
                def mod_{{name}}_quick!(operand : Bignum, modulo : Bignum, ctx : Context? = nil)
                    check LibCryptoBN.mod_{{name}}_quick self, self, operand, modulo, ctx
                    self
                end
                {% end %}
            {% end %}
            {% end %}
        end

    macro arithmetic_unary(name, *, mod = nil, in_place = true, ctx = false)
        {% ctxparm = ctx ? "ctx : Context? = nil".id : "".id %}
        {% ctxarg = ctx ? ", ctx".id : "".id %}
        def {{name}}({{ctxparm.id}}) : Bignum
            ret = new
            check LibCryptoBN.{{name}} ret, self{{ctxarg}}
            ret
        end
        {% if in_place %}
            def {{name}}!({{ctxparm}}) : Bignum
                check LibCryptoBN.{{name}} self, self{{ctxarg}}
                self
            end
        {% end %}
        {% if mod %}
            arithmetic_unary mod_{{name}}, mod: nil, in_place: {{in_place}}, ctx: true
        {% end %}
        end

    # todo : sub! may invalid
    arithmetic_binary sub, :-, mod: :quick, in_place: false
    arithmetic_binary abs_sub, nil
    arithmetic_binary add, :+, mod: :quick
    arithmetic_binary abs_add, nil
    arithmetic_binary mul, :*, mod: true
    arithmetic_binary lshift1, :<<, mod: :quick
    arithmetic_binary lshift, :<<, operand_type: Int, mod: true
    arithmetic_unary sqr, ctx: true, mod: true

    def negative : Bool
      @to_unsafe.value.neg != 0
    end

    def negative=(v : Bool)
      check LibCryptoBN.set_negative self, (v ? 1 : 0)
    end

    def div(o : Bignum, ctx : Context? = nil)
      ret = new
      check LibCryptoBN.div ret, nil, self, o, ctx
      ret
    end

    def div_mod(o : Bignum, ctx : Context? = nil)
      ret, rem = new, new
      check LibCryptoBN.div ret, rem, self, o, ctx
      return ret, rem
    end

    def /(o : Bignum)
      div o
    end

    def mod(o : Bignum, ctx : Context? = nil)
      rem = new
      check LibCryptoBN.div nil, rem, self, o, ctx
      rem
    end

    # TODO mod_word, div_word
    def nnmod(o : Bignum, ctx : Context? = nil)
      rem = new
      check LibCryptoBN.nnmod rem, self, o, ctx
      rem
    end
  end
end
