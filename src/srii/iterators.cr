require "./router.cr"

module SRII
  class Router::Graph::Path
    struct SuccessorIterator
      include Iterator(Path)
      getter start : Path | Stop
      getter current : Path | Stop

      def initialize(start)
        @current = @start = start || stop
      end

      def next
        ret = p @current
        @current = ret.brother || stop if ret.is_a? Path
        ret
      end

      def rewind
        @current = @start
      end
    end
  end
end
