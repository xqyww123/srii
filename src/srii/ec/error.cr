@[Link(ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs --silence-errors libcrypto || printf %s '-lcrypto'`")]
lib LibCrypto
  alias ULong = LibC::ULong
  alias Char = LibC::Char
  fun err_get_error = ERR_get_error : ULong
  fun err_error_string = ERR_error_string(e : ULong, buf : Char*) : Char*
end

module OpenSSL
  class Error < Exception
    getter code : LibC::ULong

    def initialize(@code, cause = nil)
      msg = Bytes.new 120
      msg = String.new LibCrypto.err_error_string(@code, msg)
      super msg, cause
    end

    def self.check
      code = LibCrypto.err_get_error
      raise Error.new code if code != 0
    end

    def self.check(return_val : LibC::Int)
      check if return_val != 0
    end
  end
end
