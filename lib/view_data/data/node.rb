class ViewData::Data::Node
  attr_accessor :value

  def initialize(value: nil, name: '', args: [], nodes: nodes = [])
    @value = value
    @name = name
    @args = args
    @nodes = nodes
  end

  def to_s
    @value.to_s
  end

  def to_value
    @value
  end

  def is_called?(name, args)
    @name == name && @args == args
  end

  def add_node(*children)
    @nodes += children
  end

  def method_missing(method, *args, &block)
    node = find_node(method, args)
    node || @value.send(method, *args, &block)
  end

  def find_node(method, args)
    @nodes.detect{ |node|
      node.is_called?(method, args)
    }
  end
end
