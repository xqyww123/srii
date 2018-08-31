module SRII
  class Router
    class Graph
      struct Sub
        # [[host, ...], [edge, ...]]
        def to_msgpack(packer : MessagePack::Packer)
          packer.write_array_start 2
          hosts = {} of Host => UInt16
          host_lst = [] of Host
          @edges.each { |e|
            {e.from, e.toto}.each { |h|
              hosts[h] ||= begin
                host_lst << h
                hosts.size.to_u16
              end
            }
          }
          packer.write_array_start host_lst.size
          host_lst.each &.to_msgpack packer
          packer.write_array_start @edges.size
          @edges.each { |e|
            packer.write_array_start 4
            packer.write hosts[e.from]
            packer.write hosts[e.toto]
            e.address.to_msgpack packer
            packer.write e.capacity
          }
        end

        def initialize(pull : MessagePack::Unpacker)
          raise BadMsgPack.new "array size of Graph::Sub must be 2" if pull.read_array_size != 2
          hosts_size = p pull.read_array_size
          hosts = Array(Host).new hosts_size
          hosts_size.times {
            hosts << Host.new pull
          }
          p hosts
          edge_size = p pull.read_array_size
          @edges = Array(Edge).new edge_size
          edge_size.times {
            raise BadMsgPack.new "array size of Edge should be 4" unless pull.read_array_size == 4
            @edges << p Edge.new hosts[pull.read_uint], hosts[pull.read_uint],
              Address.new(pull), pull.read_uint.to_u64
          }
        end
      end
    end
  end
end
