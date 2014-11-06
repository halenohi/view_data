ViewData.define do
  data :posts, disable: true do
    collection('post', length: 3)
  end
end
