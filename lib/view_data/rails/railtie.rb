module ViewData
  module Rails
    class Railtie < ::Rails::Railtie
      config.after_initialize do
        require 'view_data/actionpack/abstract_controller/rendering'
      end
    end
  end
end
