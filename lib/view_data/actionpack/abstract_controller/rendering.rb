module AbstractController
  module Rendering
    def inject_view_assigns
      original_view_data = original_view_assigns
      injected_view_data = original_view_data.dup
      injected_view_data
    end

    alias original_view_assigns view_assigns
    alias view_assigns inject_view_assigns
  end
end
