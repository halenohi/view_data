require 'spec_helper'

describe ViewData::DSL::Context do
  let(:data_node) do
    ViewData::Data::Node.new(value: nil, name: :data_node)
  end

  let(:data_node_2) do
    ViewData::Data::Node.new(value: nil, name: :data_node_2)
  end

  let(:context) do
    ViewData::DSL::Context.new(:sample_1, data_node)
  end

  let(:context_2) do
    ViewData::DSL::Context.new(:sample_2, data_node_2)
  end

  let(:now) do
    Time.now
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
    end
  end

  describe 'define posts data' do
    before do
      collection :post, length: 3
    end

    xit 'build nodes' do
      
    end
  end
end
