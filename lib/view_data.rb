require 'rails'
require 'view_data/engine'
require 'view_data/rails/railtie'

require 'view_data/data'
require 'view_data/data/node'

require 'view_data/dsl'
require 'view_data/dsl/chain_context'
require 'view_data/dsl/context'
require 'view_data/dsl/inside_context'
require 'view_data/dsl/sequences'

require 'view_data/file'
require 'view_data/layout'
require 'view_data/partial'
require 'view_data/render_options'
require 'view_data/template'

module ViewData
  class << self
    def inject(render_options, view_data)
      ViewData::Data.load_data(render_options.layout)
      ViewData::Data.load_data(render_options.template)
      view_data.merge!(ViewData.to_assigns)
      view_data
    end

    def define(&block)
      dsl = ViewData::DSL.new
      dsl.instance_eval(&block) if block_given?
      data_nodes.merge!(dsl.data_nodes)
    end

    def data_nodes
      @data_nodes ||= {}
    end

    def to_assigns
      data_nodes.inject({}){ |res, (k, v)|
        res[k.split(':').last] = v
        res
      }
    end
  end
end
