class ViewData::DSL::ChainContext < BasicObject
  def initialize(parent_context, parent_node)
    @parent_context = parent_context
    @parent_node = parent_node
  end

  def method_missing(method, *args, &block)
    node = @parent_context.extract_and_create_node(method, args, block)
    @parent_node.add_node(node)
    ::ViewData::DSL::ChainContext.new(@parent_context, node)
  end
end
