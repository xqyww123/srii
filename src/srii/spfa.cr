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
        # TODO : replace by BitArray of size of all registered hosts
        in_que = Set(Host).new
        reshort_nodes.each { |node|
          next if pathes[node].invalid?
          queue.push node
          in_que.add node
        }
        # p "aaaaaaa"
        until queue.empty?
          now = queue.shift
          now_path = pathes[now]
          puts "on #{now}"
          edges[now]?.try &.each { |e|
            len = now_path.latency + e.latency
            # p pathes[now]
            # puts "-> #{e.toto} : #{pathes[e.toto].latency}"
            # prevent overflow
            if len >= now_path.latency && len < pathes[e.toto].latency
              # puts "shorten #{e}"
              unless in_que.includes? e.toto
                queue.push e.toto
                in_que.add e.toto
              end
              now_path.append pathes[e.toto], e
              # p pathes[e.toto]
            end
          }
          in_que.delete now
        end
      end
    end
  end
end
