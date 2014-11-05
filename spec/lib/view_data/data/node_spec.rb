require 'spec_helper'

describe ViewData::Data::Node do
  let(:node) do
    ViewData::Data::Node.new(
      value: 'sample value',
      name: :sample_name,
      args: [:sample],
      nodes: [child_node]
    )
  end

  let(:child_node) do
    ViewData::Data::Node.new(
      value: 'sample child value',
      name: :sample_child_name,
      args: [:sample_child]
    )
  end

  let(:child_node_2) do
    ViewData::Data::Node.new(
      value: 'sample child value 2',
      name: :sample_child_name_2,
      args: [:sample_child_2]
    )
  end

  describe '#to_s' do
    subject do
      node.to_s
    end

    it 'send to @value.to_s' do
      expect(subject).to eq('sample value')
    end
  end

  describe '#to_value' do
    subject do
      node.to_value
    end

    it 'return @value' do
      expect(subject).to eq('sample value')
    end
  end

  describe '#is_called?' do
    context 'same @name and @args' do
      subject do
        node.is_called?(:sample_name, [:sample])
      end

      it 'return true' do
        expect(subject).to be
      end
    end
  end

  describe '#add_node' do
    before do
      node.add_node(child_node_2)
    end

    subject do
      node.instance_variable_get(:@nodes)
    end

    it 'concat to @nodes' do
      expect(subject).to eq([child_node, child_node_2])
    end
  end

  describe '#method_missing' do
    context 'found node' do
      subject do
        node.sample_child_name(:sample_child)
      end

      it 'return node' do
        expect(subject).to eq(child_node)
      end
    end

    context 'not found node' do
      subject do
        node.length
      end

      it 'send to @value' do
        expect(subject).to eq(12)
      end
    end
  end

  describe '#find_node' do
    context 'contain target node' do
      subject do
        node.find_node(:sample_child_name, [:sample_child])
      end

      it 'return target node' do
        expect(subject).to eq(child_node)
      end
    end

    context 'not contain target node' do
      subject do
        node.find_node(:sample_child_name_2, [:sample_child_2])
      end

      it 'return nil' do
        expect(subject).to be_nil
      end
    end
  end
end
