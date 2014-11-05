require 'spec_helper'

describe ViewData::Data::Node do
  let(:base) do
    ViewData::Data::Node.new(
      value: 'sample',
      name: 'sample'
    )
  end

  let(:child) do
    ViewData::Data::Node.new(
      value: 'sample child',
      name: :child_method,
      args: []
    )
  end

  let(:child_2) do
    ViewData::Data::Node.new(
      value: 'sample child 2',
      name: :child_method_2,
      args: [:hoge]
    )
  end

  let(:grandchild) do
    ViewData::Data::Node.new(
      value: 'sample grandchild',
      name: :grandchild_method,
      args: []
    )
  end

  let(:grandchild_2) do
    ViewData::Data::Node.new(
      value: 'sample grandchild 2',
      name: :grandchild_method,
      args: [:foo, { bar: 'woo' }]
    )
  end

  describe '#method_missing' do
    before do
      base.add_node(child, child_2)
      child.add_node(grandchild)
      child_2.add_node(grandchild_2)
    end

    it 'can find child node' do
      expect(base.child_method).to eq(child)
      expect(base.child_method_2(:hoge)).to eq(child_2)
      expect(base.child_method.grandchild_method).to eq(grandchild)
      expect(base.child_method_2(:hoge).grandchild_method(:foo, { bar: 'woo' })).to eq(grandchild_2)
    end

    it 'can pass native method' do
      expect(base.length).to eq(6)
    end
  end
end
