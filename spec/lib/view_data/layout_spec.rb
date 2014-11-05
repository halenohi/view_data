require 'spec_helper'

describe ViewData::Layout do
  let(:layout) do
    ViewData::Layout.new('application')
  end

  let(:support_path) do
    Pathname.new(File.dirname(File.dirname(__FILE__)))
  end

  let(:application_layout_path) do
    support_path.to_s + '/layouts/application.rb'
  end

  describe '#data_files' do
    before do
      allow(layout).to receive(:data_paths).and_return([support_path])
    end

    subject do
      layout.data_files.first.to_s
    end

    it 'return layouts/application.rb path' do
      expect(subject).to eq(application_layout_path)
    end
  end
end
