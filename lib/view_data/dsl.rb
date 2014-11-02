module ViewData
  class DSL
    def data(name, &block)
      contexts[name] ||= ViewData::DSL::Context.new(name)
      contexts[name].instance_eval(&block) if block_given?
    end

    def contexts
      @contexts ||= {}
    end
  end
end
