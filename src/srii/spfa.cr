module SRII
  class Router::Graph
    alias SHORTEST_ALG = SPFA

    module SPFA
      def self.update_shortest(source : Host,
                               pathes : Path::Set,
                               edges : Hash(Host, Array(Edge)))
        pathes[source].latency = 0
        queue = Deque(Host).new
        in_que = Set(Host).new
        nodes.each { |a|
          queue.push a.from
          in_que.add a.from
        }
        until queue.empty?
          now = queue.pop
          edges[now]?.try &.each { |e|
            len = pathes[now].latency + e.latency
            # prevent overflow
            if len < pathes[e.now].latency && len < pathes[e.toto]
              unless in_que.includes? e.toto
                queue.push e.toto
                in_que.add e.toto
              end
              pathes[e.toto].latency = len
            end
          }
          in_que.delete now
        end
      end
    end
  end
end
