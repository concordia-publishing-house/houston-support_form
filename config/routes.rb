Houston::SupportForm::Engine.routes.draw do

  scope "support_form" do
    get "" => "requests#index"
    get "/:project" => "requests#new", as: :project_support

    post "/itsm" => "itsms#create"
  end

end
