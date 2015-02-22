Houston.config.add_project_feature :support_form do
  name "Support"
  icon "fa-bullhorn"
  path { |project| Houston::SupportForm::Engine.routes.url_helpers.project_support_path(project) }
end
