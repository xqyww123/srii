module SRII
  macro link_list(name)
    {% name_subfix = name ? "_#{name.id.downcase}" : "" %}
    struct LinkLst{{name.id.capitalize if name}}(T)
    module Node(T)
      class AlreadyInList(T) < Exception
        getter node : Node(T)

        def initialize(@node)
          super "the node #{@node} is alread in list"
        end
      end

      property previous{{name_subfix.id}} : Node(T)?
      property following{{name_subfix.id}} : Node(T)?

      def append_lst{{name_subfix.id}}(node : Node(T))
        node.not_in_lst{{name_subfix.id}}!
        node.previous{{name_subfix.id}} = self
        node.following{{name_subfix.id}} = @following.try &.previous{{name_subfix.id}} = node
        @following{{name_subfix.id}} = node
      end

      def insert_lst{{name_subfix.id}}(node : Node(T))
        node.not_in_lst{{name_subfix.id}}!
        node.previous{{name_subfix.id}} = @previous{{name_subfix.id}}.try &.following{{name_subfix.id}} = node
        node.following{{name_subfix.id}} = self
        @previous{{name_subfix.id}} = node
      end

      def remove_lst{{name_subfix.id}}
        @previous{{name_subfix.id}}.try &.following{{name_subfix.id}} = @following
        @following{{name_subfix.id}}.try &.previous{{name_subfix.id}} = @previous{{name_subfix.id}}
        @previous{{name_subfix.id}} = @following{{name_subfix.id}} = nil
        self
      end

      def not_in_lst{{name_subfix.id}}!
        raise AlreadyInList(T).new if in_list{{name_subfix.id}}?
      end

      def in_list{{name_subfix.id}}? : Bool
        @previous{{name_subfix.id}} || @following{{name_subfix.id}}
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
        last.append_lst{{name_subfix.id}} ele
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
        first.insert_lst{{name_subfix.id}} ele
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
      struct \{{forward.id.capitalize}}Iterator(T)
        include Iterator(T)
        getter head : Node(T)
        getter current : Node(T) | Stop

        def initialize(@head)
          @current = @head
        end

        def next : T | Stop
          return Stop::INSTANCE if (c = @current).is_a? Stop
          t = c.\{{forward.id}} || Stop::INSTANCE
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
