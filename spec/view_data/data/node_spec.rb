require 'spec_helper'

describe ViewData::Data::Node do
  let(:base) do
    'sample string'.tap do |b|
      b.extend(ViewData::Data::Node)
      b.__view_data_struct = {
        nodes: [child, child2]
      }
    end
  end

  let(:child) do
    'sample child'.tap do |c|
      c.extend(ViewData::Data::Node)
      c.__view_data_struct = {
        args: [],
        name: :test_method
      }
    end
  end

  let(:child2) do
    'sample child 2'.tap do |c|
      c.extend(ViewData::Data::Node)
      c.__view_data_struct = {
        args: [:hoge],
        name: :test_method
      }
    end
  end

  it 'add method missing to value' do
    expect(base).to eq('sample string')
    expect(base.test_method).to eq('sample child')
    expect(base.test_method(:hoge)).to eq('sample child 2')
  end
end
