module SRII
  class Router::Graph
    alias SHORTEST_ALG = SPFA

    module SPFA
      def self.update_shortest(source : Host,
                               pathes : Path::Set,
                               reshort_nodes : Iterable(Host),
                               edges : Hash(Host, IterableEdge)) forall IterableEdge
        pathes[source].latency = 0
        queue = Deque(Host).new
        in_que = Set(Host).new
        reshort_nodes.each { |node|
          next if pathes[node].invalid?
          queue.push node
          in_que.add node
        }
        # p "aaaaaaa"
        until queue.empty?
          now = queue.pop
          # puts "on #{now}"
          edges[now]?.try &.each { |e|
            len = pathes[now].latency + e.latency
            # p pathes[now]
            # puts "-> #{e.toto} : #{pathes[e.toto].latency}"
            # prevent overflow
            if len >= pathes[now].latency && len < pathes[e.toto].latency
              # puts "shorten #{e}"
              unless in_que.includes? e.toto
                queue.push e.toto
                in_que.add e.toto
              end
              pathes[e.toto].latency = len
              # p pathes[e.toto]
            end
          }
          in_que.delete now
        end
      end
    end
  end
end
