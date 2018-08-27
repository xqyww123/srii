require "./router.cr"

module SRII
  class Router::Graph::Path
    struct SuccessorIterator
      include Iterator(Edge)
      getter start : Path
      getter current : Path | Stop

      def initialize(start)
        @current = @start = start || Stop::INSTANCE
      end

      def next
        ret = @current
        @current = ret.brother || Stop::INSTANCE if ret.is_a Path
        ret
      end

      def rewind
        @current = @start
      end
    end
  end
end
