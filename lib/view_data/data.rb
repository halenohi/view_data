module ViewData
  class Data
    class << self
      def load_data(layout_or_template)
        layout_or_template.data_files.each do |data_file|
          load data_file if ::File.exists?(data_file)
        end
      end
    end
  end
end
