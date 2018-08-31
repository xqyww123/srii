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
      id = make_identity 2
      bytes = id.to_msgpack
      bytes.hexstring.should eq "c42102c6047f9441ed7d6d3045406e95c07cd85c778e4b8cef3ca7abac09b95c709ee5"
      id2 = SRII::Host::Identity.from_msgpack bytes
      id.should eq id2
    end
  end
  # it "be created by identity" do
  #  pubk = Config::EC::GROUP.generator
  #  id = SRII::Host::Identity.new pubk
  #  host = SRII::Host.new id
  #  host.pubkey.should eq pubk
  # end
  # it "serialized by protobuf" do
  #  pubk = Config::EC::GROUP.generator
  #  id = SRII::Host::Identity.new pubk
  #  host = SRII::Host.new id
  #  io = IO::Memory.new
  #  host.to_protobuf io
  #  io.to_slice.hexstring.should eq "0a230a210279be667ef9dcbbac55a06295ce870b07029bfcdb2dce28d959f2815b16f81798"
  #  io.rewind
  #  hos2 = SRII::Host.from_protobuf io
  #  host.should eq hos2
  # end
  # describe SRII::Host::Group do
  #  pubk = Config::EC::GROUP.generator
  #  id = SRII::Host::Identity.new pubk
  #  host1 = SRII::Host.new id
  #  pubk.add! Config::EC::GROUP, pubk
  #  id = SRII::Host::Identity.new pubk
  #  host2 = SRII::Host.new id
  #  group = SRII::Host::Group.new [host1, host2]
  #  io = group.to_protobuf
  #  io.to_slice.hexstring.should eq "0a250a230a2102c6047f9441ed7d6d3045406e95c07cd85c778e4b8cef3ca7abac09b95c709ee50a250a230a2102c6047f9441ed7d6d3045406e95c07cd85c778e4b8cef3ca7abac09b95c709ee5"
  #  io.rewind
  #  group2 = SRII::Host::Group.from_protobuf io
  #  group2.should eq group
  # end
end
