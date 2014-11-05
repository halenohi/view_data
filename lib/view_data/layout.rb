module ViewData
  class Layout < File
    def dir_and_name
      'layouts/' + @name
    end
  end
end
