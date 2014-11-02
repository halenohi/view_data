require 'spec_helper'

describe ViewData::DSL do
  let(:dsl) do
    ViewData::DSL.new
  end

  let(:context_class) do
    double 'ViewData::DSL::Context'
  end

  let(:context_instance) do
    double 'ViewData::DSL::Context instance'
  end

  before do
    allow(context_class).to receive(:new).and_return(context_instance)
    stub_const('ViewData::DSL::Context', context_class)
  end

  describe '#data' do
    context 'without block' do
      before do
        dsl.data(:post)
      end

      subject do
        dsl.contexts
      end

      it 'define new ViewData::DSL::Context to contexts' do
        expect(subject).to eq(post: context_instance)
      end
    end

    context 'with block' do
      before do
        expect(context_instance).to receive(:instance_eval)
      end

      it 'assigns context\'s instance_eval return value to context' do
        dsl.data(:post) do
          title 'sample title'
        end
      end
    end
  end
end
