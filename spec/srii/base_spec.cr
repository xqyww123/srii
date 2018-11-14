require "../spec_helper.cr"

describe SRII::Host do
  describe SRII::Host::Identity do
    it "be created by EC Point" do
      id = make_identity 1
      id1 = make_identity 1
      id2 = make_identity 2
      id.should eq id1
      id.should_not eq id2
    end
    it "serialized by msgpack" do
      id = make_identity 2
      bytes = id.to_msgpack
      id2 = SRII::Host::Identity.from_msgpack bytes
      id.should eq id2
    end
  end
  it "serialized by msgpack" do
    host = get_host 5
    bytes = host.to_msgpack
    hos2 = SRII::Host.from_msgpack bytes
    host.should eq hos2
  end
  it "could be registered and fetch by ref_id" do
    host = Host.register_host make_identity 101
    Host.host(make_identity 101).should be host
    Host.host(host.ref_id).should be host
  end
  describe SRII::Host::Group do
    group = SRII::Host::Group.new [get_host(1), get_host(2)]
    bytes = group.to_msgpack
    group2 = SRII::Host::Group.from_msgpack bytes
    group2.should eq group
  end
end
