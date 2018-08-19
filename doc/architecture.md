SRII
===

Router based flood send.

## Architecure Design

- Network layer
    basically based on TCP/UDP, as the connection manager
    interface:
    - module Network
        - send(to : Address, &block : IO -> _)
            Exception : NetworkFail:
            - Timeout / Refused
- Router layer
    - C Host
        - pubkey : PubKey
        - S Group
            - hosts : Array(Host)
    - C Eplase
        - INF = ...
    - C Edge
        - from, to : Host
        - address : Address
        - eplase : Eplase
        - capacity : Int64 in bytes/s
    - S SourcedGraph
        Alogrithm : SPFA
        dynamic update : SPFA again.
        - path : Host => Path
            it's shortest path, distance and others could be extract from this structure
        - source : Host
        - update(edges : Iterator(Edge))
        - S Path
            - first : Host
            - last : Edge
            - eplase : Eplase
    - C Router
        forward_missing to self.current as a global
        - S Peice
            - graph : [] of Edge
            - host : Host
            - version : Int32
        - graph : SourcedGraph
        - peices : Host => Peice
        - update_peice(peice : Peice)
            version must greater
        - send(host, data : Bytes)
        - broadcast(data) # alias of multicast(ALL, data)
        - multicast(hosts : Group, data)
        - next_hop(Host) : Address
            extract from result of SourcedGraph
        - next_hop(Group) : Iterator(Address)
            extract from result of SourcedGraph

- Interface layer
    An isolate proto-ipc lib
    protobuf via pipe
    - C ProtoIPC
        - usage:
            IPC = ProtoIPC.new thread: single do
                {{block.body}}
            end
            IPC.listen base_dir
        - interface(name, &block)
        - directory(name, &block)
        - @current_interface_directory

- Others
    - M Crypto
        - C PubKey
        - C Signature
            - verify(pubkey : PubKey)
            - verify(pubkeys : Iterable(PubKey))
                Ring signature!

