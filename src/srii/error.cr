module SRII
  class Error < Exception
  end

  class HostNotRegistered < Error
    getter identity : Host::Identity

    def initialize(@identity)
      super "Host #{@identity} not registered"
    end
  end

  class BadMsgPack < Exception
    getter what : String

    def initialize(@what)
      super "Invalid message pack, #{@what}"
    end

    class NotSupport < BadMsgPack
      getter feature : String

      def initialize(@feature)
        super "not supported feature #{@feature}"
      end
    end
  end
end
