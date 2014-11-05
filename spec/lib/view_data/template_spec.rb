require 'spec_helper'

describe ViewData::Template do
  let(:template) do
    ViewData::Template.new('posts/index')
  end

  let(:support_path) do
    Pathname.new(File.dirname(File.dirname(__FILE__)))
  end

  let(:posts_index_path) do
    support_path.to_s + '/posts/index.rb'
  end

  describe '#data_files' do
    before do
      allow(template).to receive(:data_paths).and_return([support_path])
    end

    subject do
      template.data_files.first.to_s
    end

    it 'return posts/index path' do
      expect(subject).to eq(posts_index_path)
    end
  end
end
