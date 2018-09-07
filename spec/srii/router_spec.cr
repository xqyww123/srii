require "../spec_helper.cr"

alias Address = Router::Address
alias Edge = Router::Edge
alias Graph = Router::Graph
describe Router do
  describe Router::Address do
    it "serialized by msgpack" do
      ad = Address.new "localhost", Socket::Family::INET, Address::Protocal::UNIXP
      bytes = ad.to_msgpack
      bytes.hexstring.should eq "83a16ca96c6f63616c686f7374a16602a17001"
      ad2 = Address.from_msgpack bytes
      ad2.should eq ad
    end
  end
  describe Graph do
    describe Graph::Sub do
      it "serializable" do
        sub = make_subgraph
        bytes = sub.to_msgpack
        bytes.should eq File.read_bytes "./spec/msgpacks/sub.msgpack"
        sub2 = Graph::Sub.from_msgpack bytes
        sub2.should eq sub
      end
    end
    it "computes shortest path" do
      graph = Graph.new get_host(1)
      graph.add_sub make_subgraph
      graph.update_shortest
      (1..5).each.map { |i|
        host = get_host i
        path = graph.path host
        path.invalid?.should be_false
        path.latency
      }.to_a.should eq [0u64, 4583333335_u64, 5000000001_u64, 3333333334_u64, 4444444446_u64]
      graph = Graph.new get_host(5)
      graph.add_sub make_subgraph
      graph.update_shortest
      (1..5).each.map { |i|
        host = get_host i
        path = graph.path host
        path.invalid?.should be_false
        path.latency
      }.to_a.should eq [500000001_u64, 5083333336_u64, 5500000002_u64, 3833333335_u64, 0_u64]
    end
  end
end
