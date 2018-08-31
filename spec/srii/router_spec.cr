require "../spec_helper.cr"

alias Address = Router::Address
alias Edge = Router::Edge
alias Graph = Router::Graph
describe Router do
  describe Router::Address do
    it "serialized by msgpack" do
      ad = Address.new "localhost", Socket::Family::INET, Address::Protocal::UNIXP
      bytes = ad.to_msgpack
      p String.new bytes
      bytes.hexstring.should eq "83a16ca96c6f63616c686f7374a16602a17001"
      ad2 = Address.from_msgpack bytes
      ad2.should eq ad
    end
  end
  describe Graph do
    describe Graph::Sub do
      it "serializable" do
        h1 = make_host 1
        h2 = make_host 2
        h3 = make_host 3
        h4 = make_host 4
        h5 = make_host 5
        e12 = Edge.new h1, h2, Address.new("link:1->2", Socket::Family::INET, Address::Protocal::TCP), 100_u64
        e13 = Edge.new h1, h3, Address.new("link:1->3", Socket::Family::INET, Address::Protocal::TCP), 200_u64
        e14 = Edge.new h1, h4, Address.new("link:1->4", Socket::Family::INET, Address::Protocal::TCP), 300_u64
        e25 = Edge.new h2, h5, Address.new("link:2->5", Socket::Family::INET, Address::Protocal::TCP), 400_u64
        e21 = Edge.new h2, h1, Address.new("link:2->1", Socket::Family::INET, Address::Protocal::TCP), 500_u64
        e34 = Edge.new h3, h4, Address.new("link:3->4", Socket::Family::INET, Address::Protocal::TCP), 600_u64
        e32 = Edge.new h3, h2, Address.new("link:3->2", Socket::Family::INET, Address::Protocal::TCP), 700_u64
        e42 = Edge.new h4, h2, Address.new("link:4->2", Socket::Family::INET, Address::Protocal::TCP), 800_u64
        e45 = Edge.new h4, h5, Address.new("link:4->5", Socket::Family::INET, Address::Protocal::TCP), 900_u64
        e51 = Edge.new h5, h1, Address.new("link:5->1", Socket::Family::INET, Address::Protocal::TCP), 2000_u64
        es = [e12, e13, e14, e25, e21, e34, e32, e42, e45, e51]
        sub = Graph::Sub.new es
        bytes = sub.to_msgpack
        bytes.hexstring.should eq "929581a169c42102c6047f9441ed7d6d3045406e95c07cd85c778e4b8cef3ca7abac09b95c709ee581a169c42102e493dbf1c10d80f3581e4904930b1404cc6c13900ee0758474fa94abe8c4cd1381a169c42103fff97bd5755eeea420453a14355235d382f6472f8568a18b2f057a146029755681a169c421022f01e5e15cca351daff3843fb70f3c2f0a1bdd05e5af888a67784ef3e10a2a0181a169c42103a0434d9e47f3c86235477c7b1ae6ae5d3442d49b1943c2b752a68e2a47e247c79a94000183a16ca96c696e6b3a312d3e32a16602a170026494000283a16ca96c696e6b3a312d3e33a16602a17002ccc894000383a16ca96c696e6b3a312d3e34a16602a17002cd012c94010483a16ca96c696e6b3a322d3e35a16602a17002cd019094010083a16ca96c696e6b3a322d3e31a16602a17002cd01f494020383a16ca96c696e6b3a332d3e34a16602a17002cd025894020183a16ca96c696e6b3a332d3e32a16602a17002cd02bc94030183a16ca96c696e6b3a342d3e32a16602a17002cd032094030483a16ca96c696e6b3a342d3e35a16602a17002cd038494040083a16ca96c696e6b3a352d3e31a16602a17002cd07d0"
        sub2 = Graph::Sub.from_msgpack bytes
        sub2.should eq sub
      end
    end
  end
end
