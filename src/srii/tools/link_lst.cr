module SRII
  struct LinkLst(T)
    module Node(T)
      class AlreadyInList(T) < Exception
        getter node : Node(T)

        def initialize(@node)
          super "the node #{@node} is alread in list"
        end
      end

      property previos : Node(T)?
      property following : Node(T)?

      def append(node : Node(T))
        node.not_in_lst!
        node.previos = self
        node.following = @following.try &.previos = node
        @following = node
      end

      def insert(node : Node(T))
        node.not_in_lst!
        node.previos = @previos.try &.following = node
        node.following = self
        @previos = node
      end

      def remove
        @previos.try &.following = @following
        @following.try &.previos = @previos
        @previos = @following = nil
        self
      end

      def not_in_lst!
        raise AlreadyInList(T).new if in_list?
      end

      def in_list? : Bool
        @previos || @following
      end

      def as_element : T
        self
      end
    end

    class Wrapper(T)
      include Node(T)
      getter ele : T

      def initialize(@ele)
      end

      def as_element
        @ele
      end
    end

    property first : Node(T)?
    property last : Node(T)?

    def initialize
    end

    def push(ele : Node(T) | T)
      ele = Wrapper(T).new ele unless ele.is_a? Node(T)
      if last = @last
        last.append ele
      else
        @last = ele
      end
    end

    def <<(ele : Node(T) | T)
      push ele
    end

    def unshift(ele : Node(T) | T)
      ele = Wrapper(T).new ele unless ele.is_a? Node(T)
      if first = @first
        first.insert ele
      else
        @first = Node.new ele
      end
    end

    def each
      FollowingIterator.new @first
    end

    def reverse_each
      PreviousIterator.new @last
    end

    macro def_iterator(forward)
      struct {{forward.id.capitalize}}Iterator(T)
        include Iterator(T)
        getter head : Node(T)
        getter current : Node(T) | Stop

        def initialize(@head)
          @current = @head
        end

        def next : T | Stop
          return Stop::INSTANCE if (c = @current).is_a? Stop
          t = c.{{forward.id}} || Stop::INSTANCE
          @current = (t.same? @head) ? Stop::INSTANCE : t
          c.as_element
        end

        def rewind
          @current = @head
        end
      end
    end

    def_iterator following
    def_iterator previos
  end
end
