require 'spec_helper'

describe ViewData::DSL::Context do
 let(:context) do
   ViewData::DSL::Context.new(:sample_data)
 end

  let(:now) do
    Time.now
  end

  describe '#method_missing' do
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
      context.image(:hoge) { 'hoge' }
      # context.image.url(:thumb) { image.url.tr('default', 'thumb') }
    end

    subject do
      context.values
    end

    it 'set to values' do
      expect(subject[:id]).to eq(1)
      expect(subject[:title]).to eq('sample title')
      expect(subject[:body]).to eq('sample body')
      expect(subject[:created_at]).to eq(now)
      expect(subject[:updated_at]).to eq(now)
      expect(subject[:published_at]).to eq(now + 1.day)
      expect(subject[:image][:url]).to eq('http://sample.com/example-default.jpg')
      # expect(subject[:image][:url][:thumb].call).to eq('http://sample.com/example-thumb.jpg')
    end
  end
end
