module ViewData
  class File
    def initialize(name)
      @name = name
    end

    def data_files
      data_paths.map{ |path| path.join(dir_and_name + '.rb') }
    end

    def data_paths
      ['app/view_data'].map{ |path| Rails.root.join(path) }
    end
  end
end
