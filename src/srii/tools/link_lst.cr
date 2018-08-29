module SRII
  macro link_list(name)
    {% name_subfix = name ? "_#{name.downcase}" : "" %}
  struct LinkLst{{name.capitalize}}(T)
    module Node(T)
      class AlreadyInList(T) < Exception
        getter node : Node(T)

        def initialize(@node)
          super "the node #{@node} is alread in list"
        end
      end

      property previous{{name_subfix}} : Node(T)?
      property following{{name_subfix}} : Node(T)?

      def append_lst{{name_subfix}}(node : Node(T))
        node.not_in_lst{{name_subfix}}!
        node.previous{{name_subfix}} = self
        node.following{{name_subfix}} = @following.try &.previous{{name_subfix}} = node
        @following{{name_subfix}} = node
      end

      def insert_lst{{name_subfix}}(node : Node(T))
        node.not_in_lst{{name_subfix}}!
        node.previous{{name_subfix}} = @previous{{name_subfix}}.try &.following{{name_subfix}} = node
        node.following{{name_subfix}} = self
        @previous{{name_subfix}} = node
      end

      def remove_lst{{name_subfix}}
        @previous{{name_subfix}}.try &.following{{name_subfix}} = @following
        @following{{name_subfix}}.try &.previous{{name_subfix}} = @previous{{name_subfix}}
        @previous{{name_subfix}} = @following{{name_subfix}} = nil
        self
      end

      def not_in_lst{{name_subfix}}!
        raise AlreadyInList(T).new if in_list{{name_subfix}}?
      end

      def in_list{{name_subfix}}? : Bool
        @previous{{name_subfix}} || @following{{name_subfix}}
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
        last.append_lst{{name_subfix}} ele
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
        first.insert_lst{{name_subfix}} ele
      else
        @first = Node.new ele
      end
    end
    def pop(ele)
        unshift ele
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
    def_iterator previous
  end
    end

  link_list nil
end
