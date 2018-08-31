require "spec"
require "../src/srii"

include SRII
alias Bignum = OpenSSL::Bignum
include OpenSSL::EC
alias Host = SRII::Host

def make_host(i : Int)
  Host.new make_identity i
end

def make_identity(i : Int)
  Host::Identity.new Point.mul_generator Config::EC::GROUP, Bignum.new i
end
