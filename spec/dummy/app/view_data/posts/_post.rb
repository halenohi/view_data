ViewData.define do
  data :post do
    title 'Sample Title'
    body 'Sample Body'
  end

  data :long_title_post do
    title 'Long' * 20 + ' Title'
    body 'Sample Body'
  end
end
