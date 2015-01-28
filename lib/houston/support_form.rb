require "houston/support_form/engine"
require "houston/support_form/configuration"

module Houston
  module SupportForm
    extend self
    
    attr_reader :config
    
  end
  
  SupportForm.instance_variable_set :@config, SupportForm::Configuration.new
end
