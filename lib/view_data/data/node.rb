module ViewData::Data::Node
  attr_accessor :__view_data_struct

  class << self
    def create_node(val, name, args)
      val.extend(Delegate)
      val.__view_data_struct = {
        name: name,
        args: args,
        nodes: []
      }
      val
    end
  end

  module Delegate
    def method_missing(method, *args, &block)
      node = __view_data_find_node(method, args)
      node.presence || super
    end

    def __view_data_find_node(method, args)
      @__view_data_struct[:nodes].select{ |node|
        struct = node.__view_data_struct
        struct[:name] == method && struct[:args] == args
      }.first
    end
  end
end
