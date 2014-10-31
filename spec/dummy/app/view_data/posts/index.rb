ViewData.define do
  data :posts do
    collection 'post', length: 3
    collection 'post:long_title_post', length: 1
  end
end
