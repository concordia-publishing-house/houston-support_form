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



  add_project_feature :support_form do
    name "Support"
    path { |project| Houston::SupportForm::Engine.routes.url_helpers.project_support_path(project) }
  end

end
