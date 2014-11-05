require 'spec_helper'

describe ViewData::DSL::Context do
  let(:data_node) do
    ViewData::Data::Node.new(value: nil, name: :data_node)
  end

  let(:dsl) do
    ViewData::DSL.new
  end

  let(:context) do
    ViewData::DSL::Context.new(:sample_1, data_node, dsl)
  end

  let(:comment_node) do
    ViewData::Data::Node.new(value: nil, name: :comment_node)
  end

  let(:now) do
    Time.now
  end

  before do
    dsl.data_nodes['comments/comment:comment'] = comment_node
  end

  describe 'define post data' do
    before do
      context.sequence(:id)
      context.title 'sample title'
      context.body 'sample body'

      context.created_at now
      context.updated_at now
      context.published_at do
        created_at + 1.day
      end

      context.image.url 'http://sample.com/example-default.jpg'
      context.image.url(:thumb) { image.url.sub(/default/, 'thumb') }

      context.attr name: :extract, args: [:hoge], value: 'sample extract'

      context.comments do
        collection :comment, length: 2
      end

      context.collection :comment
    end

    subject do
      context.root_node
    end

    it 'build nodes' do
      expect(subject.id.to_value).to eq(1)
      expect(subject.title.to_value).to eq('sample title')
      expect(subject.body.to_value).to eq('sample body')

      expect(subject.created_at.to_value).to eq(now)
      expect(subject.updated_at.to_value).to eq(now)
      expect(subject.published_at.to_value).to eq(now + 1.day)

      expect(subject.image.to_value).to eq(nil)
      expect(subject.image.url.to_value).to eq('http://sample.com/example-default.jpg')
      expect(subject.image.url(:thumb).to_value).to eq('http://sample.com/example-thumb.jpg')

      expect(subject.extract(:hoge).to_value).to eq('sample extract')

      expect(subject.comments.to_value).to eq([comment_node, comment_node])

      expect(subject.to_value).to eq([comment_node])
    end
  end
end
