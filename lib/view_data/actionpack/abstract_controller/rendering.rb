module AbstractController
  module Rendering
    def view_data_render(*args, &block)
      options = _normalize_render(*args, &block)
      @_render_options = ViewData::RenderOptions.new(options)
      original_render(*args, &block)
    end

    alias original_render render
    alias render view_data_render

    def inject_view_assigns
      ViewData::Injecter.inject(@_render_options, original_view_assigns)
    end

    alias original_view_assigns view_assigns
    alias view_assigns inject_view_assigns
  end
end
