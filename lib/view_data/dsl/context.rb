class ViewData::DSL::Context
  attr_reader :root_node

  def initialize(data_name, data_node, dsl = nil)
    @data_name = data_name
    @root_node = data_node
    @dsl = dsl
  end

  def method_missing(method, *args, &block)
    args, val = extract(method, args, block)
    attr(name: method, value: val, args: args, &block)
  end

  def sequence(attr)
    value = ViewData::DSL::Sequences.find("#{ @data_name }:#{ attr }").next
    root_node.add_node(create_node(value, attr))
  end

  def extract(method, args, block = nil)
    if block.present?
      [args, ViewData::DSL::InsideContext.new(self).instance_eval(&block)]
    elsif args.any? && !block.present?
      [[], args.first]
    else
      [[], nil]
    end
  end

  def create_node(value = nil, name = '', args = [], nodes = [])
    ViewData::Data::Node.new(value: value, name: name, args: args, nodes: nodes)
  end

  def extract_and_create_node(method, args, block)
    args, val = extract(method, args, block)
    create_node(val, method, args)
  end

  def attr(name: '', value: nil, args: [], &block)
    exist_node = root_node.find_node(name, args)
    if exist_node.present?
      node = exist_node
    else
      node = create_node(value, name, args)
      root_node.add_node(node)
    end
    ViewData::DSL::ChainContext.new(self, node)
  end

  def collection(name, options = {})
    nodes = get_collection(name, options)
    root_node.value ||= []
    root_node.value += nodes
  end

  def get_collection(name, options = {})
    @dsl.collection(name, options)
  end
end
