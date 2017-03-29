# Load Houston
require "houston/application"

# Configure Houston
Houston.config do

  # Houston should load config/database.yml from this module
  # rather than from Houston Core.
  root Pathname.new File.expand_path("../../..",  __FILE__)

  # Give dummy values to these required fields.
  host "houston.test.com"
  secret_key_base "c72f10fdfe7fcfc227bc6e63599d85"
  mailer_sender "houston@test.com"

  # Houston still hard-codes knowledge of these Roles.
  # This will eventually be refactored away.
  roles "Developer", "Tester"
  project_roles "Maintainer"

  # Mount this module on the dummy Houston application.
  use :support_form

end
