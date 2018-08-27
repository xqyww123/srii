
module SRII
    class Network
        struct Address

        end

        abstract class Driver
            getter network : Network
            def initialize(@network)
            end
            abstract def send(to : Address, &block : IO -> _)
            abstract def send(to : Iterator(Address), &block : IO -> _)
            private def recv(from : Address, data : Bytes)
            end
        end

        getter driver : Driver
        def initialize(@driver)
        end

        enum Head : UInt8
            SEND = 1
            PROXY = 2
        end
        
        def send(to : Iterator(Address) | Address, data : Bytes)
            @driver.send to do |io|
                io.write_byte Head::SEND
                io.write_bytes data.size, Config::Endian
                io.write data
            end
        end
        def proxy(to : Iterator(Address) | Address, dest : Indexable(Address), data : Bytes)
            @driver.send to do |io|
                io.write_byte Head::PROXY
                io.write_bytes dest.size, Config::Endian
                io.write_bytes data.size, Config::Endian
            end
        end
        def recv(from : Address, data : Bytes)
        end
    end
end
