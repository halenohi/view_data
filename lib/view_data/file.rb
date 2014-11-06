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
      ['app/view_data'].map{ |path| rails_root.join(path) }
    end

    def rails_root
      (::Rails.root || ViewData.root)
    end
  end
end
