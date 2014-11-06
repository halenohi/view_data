## Usage

__app/views/posts/index.html.erb__
```
<div class="post-list">
  <% @posts.each do |post| %>

    <article class="post">
      <%= image_tag post.image.url(:thumb) %>
      <h1><%= post.tite %></h1>
      <div><%= post.body %></div>
    </article>

    <div class="post-comment-list">
      <%= @post.comments.each do |comment| %>
        <div class="post-comment">
          <%= comment.body %>
        </div>
      <% end %>
    </div>

  <% end %>
</div>
```

__app/view_data/posts/index.rb__
```
ViewData.define do
  data :posts, disable: false do
    collection 'post', length: 3
    collection 'posts/post', length: 3
    collection 'posts/post:long_title_post'
    collection 'posts/post', length: 3
  end
end
```

__app/view_data/posts/show.rb__
```
ViewData.define do
  data :post
end

# -- or --

ViewData.define do
  data :post, :long_title_post
end

# -- or --

ViewData.define do
  data :post, 'shared/long_title_post'
end
```

__app/view_data/posts/_post.rb__
```
ViewData.define do
  data :post do
    sequence(:id)

    title { 'Awesome post' + id.to_s }
    body 'example body text...'

    image.url 'http://sample.com/default.jpg'
    image.url(:thumb) do
      image.url.tr('default', 'thumb')
    end

    created_at 2.days.ago
    published_at { created_at + 1.day }

    comments do
      collection 'comment',
        created_at: (published_at + 1.day),
        length: 3
    end
  end

  data :long_title_post do
    title 'long ' * 50
    body 'example body text...'
  end
end
```

```
def collection(path, options = {})
  # todo
end
```

__config/initializers/view_data.rb__
```
ViewData.configure do
  environments :development, :test
  data_paths += %w(app/view_data)
end
```
__view_data/layouts/application.rb__
```
ViewData.define do
  data :categories do
    cache expires_in: 1.hour do
      Category.arrange
    end
  end
end
```

```
DataNode
{
  args: [],
  name: :posts,
  value: [
    {
      args: [],
      name: :post,
      value: nil,
      nodes: [
        {
          args: [],
          name: :title,
          value: 'sample title',
          nodes: []
        },
        {
          args: [],
          name: :image,
          value: nil,
          nodes: [
            {
              args: [],
              name: :url,
              value: 'http://sample.com/example-default.jpg',
              nodes: []
            },
            {
              args: [:thumb],
              name: :url,
              value: 'http://sample.com/example-thumb.jpg',
              nodes: []
            },
            {
              args: [],
              name: :file,
              value: '/hoge/fuga.jpg',
              nodes: []
            }
          ]
        },
      ]
    }
  ]
  nodes: []
}
```
