ViewData.define do
  data :post do
    title 'Sample Title aa'
    body 'Sample Body'

    created_at Time.now
    posted_at { created_at + 1.day }

    image.url 'http://sample.com/example-default.jpg'
    image.url(:thumb) do
      image.url.sub(/default/, 'thumb')
    end

    comments do
      collection :comment, length: 3
    end
  end
end
