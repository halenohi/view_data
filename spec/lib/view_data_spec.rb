require 'spec_helper'

describe ViewData do
  let(:injector) do
    ViewData
  end

  let(:render_options) do
    double('render_options')
  end

  let(:data_class) do
    double('data_class')
  end

  let(:layout_data) do
    { layout: 'layout value' }
  end

  let(:template_data) do
    { template: 'template value' }
  end

  describe '.inject' do
    before do
      allow(render_options).to receive(:layout).and_return(:layout)
      allow(render_options).to receive(:template).and_return(:template)

      allow(data_class).to receive(:find).with(:layout).and_return(layout_data)
      allow(data_class).to receive(:find).with(:template).and_return(template_data)
      stub_const('ViewData::Data', data_class)
    end

    subject do
      injector.inject(render_options, {})
    end

    it 'find data and merge to view_data' do
      expect(subject).to eq(layout: 'layout value', template: 'template value')
    end
  end

  describe '.define' do
    before do
      allow_any_instance_of(ViewData::DSL).to receive(:instance_eval)
      allow_any_instance_of(ViewData::DSL).to receive(:data_nodes).and_return(
        test_key: 'test val'
      )

      ViewData.define do
        'test block'
      end
    end

    subject do
      ViewData.data_nodes
    end

    it 'run DSL and extract data_nodes' do
      expect(subject).to eq(test_key: 'test val')
    end
  end
end
