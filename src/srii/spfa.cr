module SRII
  class Router::Graph
    alias SHORTEST_ALG = SPFA

    module SPFA
      def self.update_shortest(graph : Graph, nodes : Iterator(Host))
        queue = Deque(Host).new
        in_que = Set(Host).new
        nodes.each { |a|
          queue.push a
          in_que.add a
        }
      end
    end
  end
end
