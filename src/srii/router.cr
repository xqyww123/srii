require "protobuf"
require "./base.cr"
require "./tools/link_lst.cr"

module SRII
  class Router
    struct Address
      enum Protocal
        UNIXP = 1
        TCP   = 2
        QUIC  = 3
        ZMQ   = 4
      end

      include MessagePack::Serializable

      @[MessagePack::Field(key: "l")]
      getter location : String
      @[MessagePack::Field(key: "f")]
      getter family : Socket::Family
      @[MessagePack::Field(key: "p")]
      getter protocal : Protocal

      def initialize(@location, @family, @protocal)
      end

      def_equals_and_hash @location, @family, @protocal
    end

    # belongs to one graph!
    class Edge
      getter from : Host
      getter toto : Host
      getter address : Address
      getter capacity : UInt64
      def_equals_and_hash from, toto, address, capacity

      def initialize(@from, @toto, @address, @capacity)
      end

      # unit : 0.001 ns/byte
      def latency : UInt64
        1_000_000_000_000_u64 / @capacity + 1u64
      end

      def to_s(io : IO)
        from.to_s io
        io << "--"
        latency.to_s io
        io << "->"
        toto.to_s io
      end

      def inspect(io : IO)
        to_s io
      end
    end

    class Graph
      struct Sub
        getter edges : Array(Edge)

        def initialize(@edges)
        end

        def_equals_and_hash @edges
      end

      getter source : Host

      SRII.link_list Forward
      SRII.link_list Reverse

      class SRII::Router::Edge
        include Graph::LinkLstReverse::Node(Edge)
        include Graph::LinkLstForward::Node(Edge)
      end

      @subs = Set(Sub).new
      @host_edges = {} of Host => LinkLstForward(Edge)
      @host_edges_reverse = {} of Host => LinkLstReverse(Edge)
      @pathes = Path::Set.new
      # brink of not changed nodes, yet the start point to
      # shorten modified nodes.
      @reshort_nodes = Set(Host).new

      def subs : Iterator(Sub)
        @subs.each
      end

      def path(host : Host)
        update_shortest
        @pathes[host]
      end

      def remove_sub(sub : Sub)
        @subs.delete sub
        sub.edges.each { |a|
          a.remove_lst_forward
          a.remove_lst_reverse
          path = @pathes[a.toto]
          next unless path.edge == a
          path.invalid do |path|
            host = path.host.not_nil!
            puts "invalid #{host}"
            @host_edges_reverse[host].try &.each { |b|
              puts "reshort #{b.from}"
              @reshort_nodes.add b.from
            }
          end if path
        }
      end

      private def _add_sub(sub : Sub)
        sub.edges.each { |a|
          (@host_edges[a.from] ||= LinkLstForward(Edge).new) << a
          (@host_edges_reverse[a.toto] ||= LinkLstReverse(Edge).new) << a
          @reshort_nodes.add a.from
        }
      end

      def add_sub(sub : Sub)
        @subs.add sub
        _add_sub sub
      end

      def update_shortest
        return if @reshort_nodes.empty?
        SHORTEST_ALG.update_shortest @source, @pathes, @reshort_nodes, @host_edges
        @reshort_nodes.clear
      end

      def initialize(@source)
      end

      def initialize(@source, @subs)
        _add_sub @subs
      end

      class Path
        SRII.link_list path
        include LinkLstPath::Node(Path)
        getter successors = LinkLstPath(Path).new
        property first_jump : Edge?
        property edge : Edge?
        property latency : UInt64 = UInt64::MAX
        getter host : Host

        def initialize(@host)
        end

        def append(path : Path, edge : Edge)
          path.remove_lst_path
          path.first_jump = @first_jump || edge
          path.edge = edge
          path.latency = @latency + edge.latency
          @successors << path
          self
        end

        def invalid?
          @latency == UInt64::MAX
        end

        def _fast_invalid(&block : Path -> _)
          return if invalid?
          @latency = UInt64::MAX
          yield self
          successors.each &._fast_invalid &block
          @first_jump = @edge = nil
        end

        def invalid(&block : Path -> _)
          return if invalid?
          _fast_invalid &block
          successors.clean
          remove_lst_path
          self
        end

        def invalid
          invalid { }
        end

        delegate inspect, to_s, to: @edge

        class Set < Hash(Host, Path)
          def initialize
            super(->(h : Hash(Host, Path), k : Host) {
              h[k] = Path.new k
            })
          end
        end
      end

      struct Sourced
        getter graph : Graph
        getter src : Host
        getter shortests = {} of Host => Path

        def initialize(@graph, @src)
        end
      end
    end

    struct Peice
      include Protobuf::Message
      contract_of "proto2" do
        required :graph, Graph::Sub, 1
        required :host, Host, 2
        required :version, :uint32, 3
      end
    end
  end
end
