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
require 'view_data/render_options'
require 'view_data/template'

module ViewData
  class << self
    def inject(render_options, view_data)
      layout_data = ViewData::Data.find(render_options.layout)
      template_data = ViewData::Data.find(render_options.template)
      view_data.merge!(layout_data || {})
      view_data.merge!(template_data || {})
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
  end
end
