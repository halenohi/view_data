module ViewData
  class File
    def initialize(name)
      @name = name
    end

    def data_files
      _dir_and_name = dir_and_name.sub(/\..+$/, '')
      data_paths.map{ |path| path.join(_dir_and_name + '.rb') }
    end

    def data_paths
      ['app/view_data'].map{ |path| ::Rails.root.join(path) }
    end
  end
end
