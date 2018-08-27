module SRII
    class Error < Exception
    end
    class HostNotRegistered < Error
        getter identity : Host::Identity
        def initialize(@identity)
            super "Host #{@identity} not registered"
        end
    end
end
