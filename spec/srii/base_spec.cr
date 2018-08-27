require "../spec_helper.cr"

describe SRII::Host do
  describe SRII::Host::Identity do
    it "be created by EC Point" do
      pubk = Config::EC::GROUP.generator
      pub2 = OpenSSL::EC::Point.new Config::EC::GROUP
      id = SRII::Host::Identity.new pubk
      id.should eq pubk
      id.should_not eq pub2
    end
    it "serialized by protobuf" do
      pubk = Config::EC::GROUP.generator
      id = SRII::Host::Identity.new pubk
      io = IO::Memory.new
      id.to_protobuf io
      io.to_slice.hexstring.should eq "210279be667ef9dcbbac55a06295ce870b07029bfcdb2dce28d959f2815b16f81798"
      io.rewind
      id2 = SRII::Host::Identity.from_protobuf io
      id.should eq id2
    end
  end
  it "be created by identity" do
    pubk = Config::EC::GROUP.generator
    id = SRII::Host::Identity.new pubk
    host = SRII::Host.new id
    host.pubkey.should eq pubk
  end
  it "serialized by protobuf" do
    pubk = Config::EC::GROUP.generator
    id = SRII::Host::Identity.new pubk
    host = SRII::Host.new id
    io = IO::Memory.new
    host.to_protobuf io
    io.to_slice.hexstring.should eq "0a210279be667ef9dcbbac55a06295ce870b07029bfcdb2dce28d959f2815b16f81798"
    io.rewind
    hos2 = SRII::Host.from_protobuf io
    host.should eq hos2
  end
end
