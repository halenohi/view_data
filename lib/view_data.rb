require 'rails'

require 'view_data/data'
require 'view_data/data/node'
require 'view_data/dsl'
require 'view_data/dsl/context'
require 'view_data/dsl/sequences'
require 'view_data/engine'
require 'view_data/injecter'
require 'view_data/null_data'
require 'view_data/render_options'
require 'view_data/rails/railtie'

module ViewData
  def define(&block)
  end
end
