require 'spec_helper'

describe ViewData::DSL do
  let(:dsl) do
    ViewData::DSL.new
  end

  describe '#data' do
    before do
      dsl.data :post
    end

    it 'append data_node to data_nodes' do
      expect(dsl.data_nodes.keys).to eq(['view_data/dsl:post'])
    end
  end

  describe '#collection' do
    before do
      dsl.data_nodes['posts/post:post'] = 'sample post'
    end

    subject do
      dsl.collection name
    end

    context 'name is only :post' do
      let(:name) do
        :post
      end

      it 'lookup data_node' do
        expect(subject).to eq(['sample post'])
      end
    end

    context 'name is include slash' do
      let(:name) do
        'posts/post'
      end

      it 'lookup data_node' do
        expect(subject).to eq(['sample post'])
      end
    end

    context 'name is include slash and collon' do
      let(:name) do
        'posts/post:post'
      end

      it 'lookup data_node' do
        expect(subject).to eq(['sample post'])
      end
    end

    context 'passing length: 3' do
      subject do
        dsl.collection :post, length: 3
      end

      it 'return 3 length result' do
        expect(subject).to eq(['sample post', 'sample post', 'sample post'])
      end
    end
  end
end
