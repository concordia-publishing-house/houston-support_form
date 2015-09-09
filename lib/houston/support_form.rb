require "houston/support_form/engine"
require "houston/support_form/configuration"

module Houston
  module SupportForm
    extend self

    def config(&block)
      @configuration ||= SupportForm::Configuration.new
      @configuration.instance_eval(&block) if block_given?
      @configuration
    end

  end
end
