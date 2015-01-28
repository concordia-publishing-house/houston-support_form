module Houston::SupportForm
  class Configuration
    
    def initialize
      config = Houston.config.module(:support_form).config
      instance_eval(&config) if config
    end
    
    # Define configuration DSL here
    
  end
end
