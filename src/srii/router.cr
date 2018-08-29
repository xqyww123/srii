require "protobuf"
require "./base.cr"
require "./tools/link_lst.cr"

module SRII
  class Router
    struct Address
      include Protobuf::Message
      enum Protocal
        UNIXP = 1
        TCP   = 2
        QUIC  = 3
        ZMQ   = 4
      end

      contract_of "proto2" do
        required :location, :string, 1
        required :family, Socket::Family, 2
        required :protocal, Address::Protocal, 3
      end
      def_equals_and_hash @location, @family, @protocal
    end

    # belongs to one graph!
    class Edge
      include Protobuf::Message
      # include Graph::LinkLstForward::Node(Edge)
      include Graph::LinkLstReverse::Node(Edge)
      contract_of "proto2" do
        required :from, Host, 1
        required :toto, Host, 2
        required :address, Address, 3
        required :capacity, :uint64, 4
      end

      # unit : 0.001 ns/byte
      def latency : UInt64
        1E12 / @capacity + 1
      end
    end

    class Graph
      struct Sub
        include Protobuf::Message

        contract_of "proto2" do
          repeated :edges, Edge, 1
        end
        def_equals_and_hash @edges
      end

      getter source : Host

      # link_list Forward
      link_list Reverse
      @subs = Set(Sub).new
      # @host_edges = {} of Host => LinkLstForward(Edge)
      @host_edges_reverse = {} of Host => LinkLstReverse(Edge)
      @key_edge = Path::Set
      @host_path = {} of Host => Path
      @reshort_edges = {} of Host => Array(Edge)

      def subs : Iterator(Sub)
        @subs.each
      end

      def remove_sub(sub : Sub)
        @subs.remove sub
        sub.edges.each { |a|
          a.remove_lst_forward
          a.remove_lst_reverse
          path = @key_edge[a]?
          path.invalid do |host|
            @host_edges_reverse[host].try &.each { |b|
              (@reshort_edges[b.from] ||= [] of Edge) << b
            }
          end if path
        }
      end

      private def _add_sub(sub : Sub)
        sub.edges.each { |a|
          # (@host_edges[a.from] ||= LinkLstForward(Edge).new) << a
          (@host_edges_reverse[a.toto] ||= LinkLstReverse(Edge).new) << a
          (@reshort_edges[a.from] ||= [] of Edge) << a
        }
      end

      def add_sub(sub : Sub)
        @sub.add sub
        _add_sub sub
      end

      def update_shortest
        return unless @reshort_edges.empty?
        SHORTEST_ALG.update_shortest
        @reshort_edges.clear
      end

      def initialize(@source)
      end

      def initialize(@source, @subs)
        _add_sub @subs
      end

      class Path
        property first : Edge?
        property last : Edge?
        property latency : UInt64 = UInt64::MAX
        property successor : Path?
        property brother : Path?

        def successors
          SuccessorIterator.new @append
        end

        def append(path : Path)
          @successor.try &.brother = @successor
          @successor = path
          path.first = @first
          path.last = self
          self
        end

        def invalid?
          @latency == UInt64::MAX
        end

        def invalid(&block)
          return if invalid?
          @latency = UInt64::MAX
          yield self
          successors.each &.invalid &block
          @successor = @first = @last = nil
        end

        def invalid
          invalid { }
        end

        class Set < Hash(Host, Path)
          def fetch(host : Host) : Path
            fetch(host) { |key| self[key] = Path.new }
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
