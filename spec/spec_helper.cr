require "spec"
require "../src/srii"

include SRII
alias Bignum = OpenSSL::Bignum
include OpenSSL::EC
alias Host = SRII::Host

def make_host(i : Int)
  Host.new Point.mul_generator Bignum.new i
end
