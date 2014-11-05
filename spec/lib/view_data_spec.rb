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

  before do
    allow(render_options).to receive(:layout).and_return(:layout)
    allow(render_options).to receive(:template).and_return(:template)

    allow(data_class).to receive(:find).with(:layout).and_return(layout_data)
    allow(data_class).to receive(:find).with(:template).and_return(template_data)
    stub_const('ViewData::Data', data_class)
  end

  describe '.inject' do
    subject do
      injector.inject(render_options, {})
    end

    it 'find data and merge to view_data' do
      expect(subject).to eq(layout: 'layout value', template: 'template value')
    end
  end
end
