module ViewData
  class Partial < File
    def dir_and_name
      splited = @name.split('/')
      [splited.first, "_#{ splited[1] }"].join('/')
    end
  end
end
