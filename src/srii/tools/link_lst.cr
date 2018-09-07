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
        node.following{{name_subfix.id}} = @following{{name_subfix.id}}.tap &.try &.previous{{name_subfix.id}} = node
        @following{{name_subfix.id}} = node
      end

      def insert_lst{{name_subfix.id}}(node : Node(T))
        node.not_in_lst{{name_subfix.id}}!
        node.previous{{name_subfix.id}} = @previous{{name_subfix.id}}.tap &.try &.following{{name_subfix.id}} = node
        node.following{{name_subfix.id}} = self
        @previous{{name_subfix.id}} = node
      end

      def remove_lst{{name_subfix.id}}
        @previous{{name_subfix.id}}.try &.following{{name_subfix.id}} = @following{{name_subfix.id}}
        @following{{name_subfix.id}}.try &.previous{{name_subfix.id}} = @previous{{name_subfix.id}}
        @previous{{name_subfix.id}} = @following{{name_subfix.id}} = nil
        self
      end

      def not_in_lst{{name_subfix.id}}!
        raise AlreadyInList(T).new self if in_list{{name_subfix.id}}?
      end

      def in_list{{name_subfix.id}}?
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
    class Head(T)
      include Node(T)
      def as_element : T
        raise "Head cannot as a element"
      end
    end

    @head : Head(T)

    def initialize
      @head = Head(T).new
      @head.following{{name_subfix.id}} = @head
      @head.previous{{name_subfix.id}} = @head
    end

    def push(ele : Node(T) | T)
      ele = Wrapper(T).new ele unless ele.is_a? Node(T)
      @head.insert_lst{{name_subfix.id}} ele
    end

    def <<(ele : Node(T) | T)
      push ele
    end

    def shift(ele : Node(T) | T)
      ele = Wrapper(T).new ele unless ele.is_a? Node(T)
      @head.append_lst{{name_subfix.id}} ele
    end
    def pop
      ret = @head.following{{name_subfix.id}}.not_nil!
      return nil if ret.same? @head
      ret.remove_lst{{name_subfix.id}}
      ret.as_element
    end
    def unshift
      pop
    end
    def unpush
      ret = @head.previous{{name_subfix.id}}.not_nil!
      return nil if ret.same? @head
      ret.remove_lst{{name_subfix.id}}
    end

    include Iterable(T)
    include Enumerable(T)
    def each
      FollowingIterator(T).new @head
    end
    def each(&block : T -> _)
      each.each &block
    end

    def reverse_each
      PreviousIterator(T).new @head
    end

    macro def_iterator(forward)
      struct \{{forward.id.capitalize}}Iterator(T)
        include Iterator(T)
        getter head : Node(T) | Stop
        getter current : Node(T) | Stop

        def initialize(head)
          @current = @head = head || stop
        end

        def next : T | Stop
          return Stop::INSTANCE if (c = @current).is_a? Stop
          t = c.\{{forward.id}}{{name_subfix.id}}.not_nil!
          t = Stop::INSTANCE if t.is_a? Head
          @current = t
          t.is_a?(Stop) ? t : t.as_element
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
