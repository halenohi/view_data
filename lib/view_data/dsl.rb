class ViewData::DSL
  def data(name, nodes = [], options = {}, &block)
    if nodes.is_a?(Hash) && options.keys.length.zero?
      options = nodes
    end
    options = { disable: false }.merge(options)
    return if options[:disable]

    data_node = ViewData::Data::Node.new(name: name)
    if block_given?
      context = ViewData::DSL::Context.new(name, data_node, self)
      context.instance_eval(&block)
    end
    unless nodes.length.zero?
      data_node.add_value(nodes)
    end
    data_nodes[data_node_name(name, caller[0])] = data_node
  end

  def data_nodes
    @data_nodes ||= {}
  end

  def collection(name, options = {})
    length = options[:length] || 1
    full_name = make_full_name(name)
    unless ViewData.data_nodes[full_name].present?
      ViewData::Data.load_data(ViewData::Partial.new(full_name.sub(/\:.+$/, '')))
    end
    length.times.map{ ViewData.data_nodes[full_name] }
  end

  private
    def data_node_name(name, _caller)
      splited_path = _caller.split(':').first.split('/')[-2, 2]
      [
        splited_path[-2],
        splited_path[-1].sub(/\..+$/, '').sub(/^_/, '')
      ].join('/') +
      ":#{ name }"
    end

    def make_full_name(name)
      name = name.to_s
      if !name.include?('/')
        "#{ name.pluralize }/#{ name }:#{ name }"
      elsif !name.include?(':')
        "#{ name }:#{ name.split('/').last }"
      else
        name
      end
    end
end
