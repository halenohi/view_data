require 'rails'

require 'view_data/data'
require 'view_data/data/node'

require 'view_data/dsl'
require 'view_data/dsl/chain_context'
require 'view_data/dsl/context'
require 'view_data/dsl/inside_context'
require 'view_data/dsl/sequences'

require 'view_data/engine'

require 'view_data/injecter'
require 'view_data/layout'
require 'view_data/null_data'
require 'view_data/render_options'
require 'view_data/template'
require 'view_data/rails/railtie'

module ViewData
  def define(&block)
    dsl = ViewData::DSL.new
    dsl.instance_eval(&block) if block_given?

    data_nodes.merge!(dsl.data_nodes)
  end

  def data_nodes
    @data_nodes ||= {}
  end
end
