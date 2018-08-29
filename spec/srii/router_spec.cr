require "../spec_helper.cr"

alias Address = Router::Address
alias Edge = Router::Edge
describe Router do
  describe Router::Address do
    it "serialized by protobuf" do
      ad = Address.new "localhost", Socket::Family::INET, Address::Protocal::UNIXP
      io = ad.to_protobuf
      io.to_slice.hexstring.should eq "0a096c6f63616c686f737410021801"
      io.rewind
      ad2 = Address.from_protobuf io
      ad2.should eq ad
    end
  end
  describe Graph do
  end
end
