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
    end

    # belongs to one graph!
    class Edge
      include Protobuf::Message
      include LinkLst::Node(Edge)
      contract_of "proto2" do
        required :from, Host, 1
        required :toto, Host, 2
        required :address, Address, 3
        required :capacity, :uint64, 4
      end

      # nanoseconds for 1byte
      def latency : UInt64
        1E9 / @capacity + 1
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

      @subs = Set(Sub).new
      @host_edges = {} of Host => LinkLst(Edge)
      @key_edge = {} of Edge => Path
      @host_path = {} of Host => Path

      def path(host : Host) : Path?
        ret = @host_path[host]
        ret && (ret.invalid? ? nil : ret)
      end

      def path?(host : Host) : Path
        @host_path[host] ||= Path.new
      end

      def subs : Iterator(Sub)
        @subs.each
      end

      def remove_sub(sub : Sub)
        @subs.remove sub
        sub.edges.each { |a|
          a.remove
          path = @key_edge[a]?
          path.invalid if path
        }
      end

      private def _add_sub(sub : Sub)
        sub.edges.each { |a|
          (@host_edges[a.from] ||= LinkLst(Edge).new) << a
        }
      end

      def add_sub(sub : Sub)
        @sub.add sub
        _add_sub sub
      end

      def initialize
      end

      def initialize(@subs)
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

        def invalid
          return if invalid?
          @latency = UInt64::MAX
          successors.each &.invalid
          @successor = @first = @last = nil
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
