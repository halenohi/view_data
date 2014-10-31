module ViewData
  class Injecter < Struct(:layout_data, :template_data, :view_data)

    class << self
      def inject(render_options, view_data)
        layout_data = ViewData::Data.find(render_options.layout)
        template_data = ViewData::Data.find(render_options.template)

        if layout_data.present? || template_data.present?
          new(layout_data, template_data, view_data).inject
        else
          view_data
        end
      end
    end

    def inject
      view_data
    end
  end
end
