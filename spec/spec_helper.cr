require "spec"
require "../src/srii"

include SRII
alias Bignum = OpenSSL::Bignum
include OpenSSL::EC
alias Host = SRII::Host

def make_identity(i : Int)
  Host::Identity.new Point.mul_generator Config::EC::GROUP, Bignum.new i
end

10.times { |i| Host.register_host make_identity i + 1 }

def get_host(i : Int)
  Host.host make_identity i
end

alias Address = Router::Address

def make_subgraph
  h1 = get_host 1
  h2 = get_host 2
  h3 = get_host 3
  h4 = get_host 4
  h5 = get_host 5
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
  Graph::Sub.new es
end

def link(a, b, latency)
  Edge.new a, b, Address.new("link:#{a.ref_id}->#{b.ref_id}", Socket::Family::INET, Address::Protocal::TCP), latency.to_u64
end

def make_subgraph_isolated
  h6 = get_host 6
  h7 = get_host 7
  h8 = get_host 8
  h9 = get_host 9
  es = [
    link(h6, h7, 10000_u64),
    link(h7, h8, 3000_u64),
    link(h7, h9, 5000_u64),
    link(h6, h8, 2500_u64),
    link(h6, h9, 2500_u64),
    link(h8, h9, 250000_u64),
  ]
  Graph::Sub.new es
end

def make_subgraph_bridge
  h5 = get_host 5
  h6 = get_host 6
  h9 = get_host 9
  h1 = get_host 1
  Graph::Sub.new [
    link(h5, h6, 20000_u64),
    link(h9, h1, 20000_u64),
  ]
end

class File
  def self.read_bytes(filename)
    open(filename, "r") do |f|
      ret = Bytes.new f.size
      f.read_fully ret
      ret
    end
  end
end
