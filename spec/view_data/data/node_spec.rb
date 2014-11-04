require 'spec_helper'

describe ViewData::Data::Node do
  let(:base) do
    ViewData::Data::Node.create_node('sample string', :base, [])
  end

  let(:child) do
    ViewData::Data::Node.create_node('sample child', :test_method, [])
  end

  let(:child2) do
    ViewData::Data::Node.create_node('sample child 2', :test_method, [:hoge])
  end

  before do
    ViewData::Data::Node.add_node(base, child, child2)
  end

  it 'add method missing to value' do
    expect(base).to eq('sample string')
    expect(base.test_method).to eq('sample child')
    expect(base.test_method(:hoge)).to eq('sample child 2')
  end
end
