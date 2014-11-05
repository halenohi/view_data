module ViewData
  class Partial < File
    def dir_and_name
      splited = @name.split('/')
      [splited.first, "_#{ splited.second }"].join('/')
    end
  end
end
