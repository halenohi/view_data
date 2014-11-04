module ViewData::Data::Node
  STRUCT_NAME = :__view_data_struct

  class << self
    def create_node(val, name, args)
      val.extend(Delegate)
      val.send "#{ STRUCT_NAME }=", {
        name: name,
        args: args,
        nodes: []
      }
      val
    end

    def add_node(node, *children)
      node.send(STRUCT_NAME)[:nodes] += children
    end
  end

  module Delegate
    attr_accessor STRUCT_NAME

    def method_missing(method, *args, &block)
      node = send(STRUCT_NAME)[:nodes].select{ |node|
        struct = node.send(STRUCT_NAME)
        struct[:name] == method && struct[:args] == args
      }.first

      node.presence || super
    end
  end
end
