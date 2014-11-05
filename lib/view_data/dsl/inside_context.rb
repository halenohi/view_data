class ViewData::DSL::InsideContext < BasicObject
  def initialize(parent_context)
    @parent_context = parent_context
    @buffer_nodes = []
  end

  def method_missing(method, *args, &block)
    @parent_context.root_node.send(method, *args, &block)
  end

  def collection(name, options = {})
    @buffer_nodes += @parent_context.get_collection(name, options)
  end

  def instance_eval(&block)
    result = super
    if @buffer_nodes.length.zero?
      result
    else
      @buffer_nodes
    end
  end
end
