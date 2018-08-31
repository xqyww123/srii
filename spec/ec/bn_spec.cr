require "../spec_helper.cr"

include OpenSSL
describe OpenSSL::Bignum do
  describe Bignum::Context do
    it "can be created, start, end, enter" do
      Bignum::Context.new.enter { }
    end
  end
  it "rand" do
    Bignum.rand 3, 2, 3
  end
end
