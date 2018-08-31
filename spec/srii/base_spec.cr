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
    it "serialized by msgpack" do
      id = make_identity 2
      bytes = id.to_msgpack
      bytes.hexstring.should eq "c42102c6047f9441ed7d6d3045406e95c07cd85c778e4b8cef3ca7abac09b95c709ee5"
      id2 = SRII::Host::Identity.from_msgpack bytes
      id.should eq id2
    end
  end
  it "be created by identity" do
    pubk = Config::EC::GROUP.generator
    id = SRII::Host::Identity.new pubk
    host = SRII::Host.new id
    host.pubkey.should eq pubk
  end
  it "serialized by msgpack" do
    host = make_host 5
    bytes = host.to_msgpack
    bytes.hexstring.should eq "81a169c421022f8bde4d1a07209355b4a7250a5c5128e88b84bddc619ab7cba8d569b240efe4"
    hos2 = SRII::Host.from_msgpack bytes
    host.should eq hos2
  end
  describe SRII::Host::Group do
    pubk = Config::EC::GROUP.generator
    id = SRII::Host::Identity.new pubk
    host1 = SRII::Host.new id
    pubk.add! Config::EC::GROUP, pubk
    id = SRII::Host::Identity.new pubk
    host2 = SRII::Host.new id
    group = SRII::Host::Group.new [host1, host2]
    bytes = group.to_msgpack
    bytes.hexstring.should eq "81a5686f7374739281a169c42102c6047f9441ed7d6d3045406e95c07cd85c778e4b8cef3ca7abac09b95c709ee581a169c42102c6047f9441ed7d6d3045406e95c07cd85c778e4b8cef3ca7abac09b95c709ee5"
    group2 = SRII::Host::Group.from_msgpack bytes
    group2.should eq group
  end
end
