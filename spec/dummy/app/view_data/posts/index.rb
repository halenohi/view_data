ViewData.define do
  data :posts do
    collection(:post)
    collection('posts/post:long_title')
    collection(:post)
  end
end
