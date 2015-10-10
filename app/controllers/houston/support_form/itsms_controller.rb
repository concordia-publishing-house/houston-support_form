module Houston
  module SupportForm
    class ItsmsController < Houston::SupportForm::ApplicationController

      def create
        issue_url = ITSM::Issue.create(
          username: current_user.username,
          summary: params[:summary],
          notes: params[:text])
        render json: {url: issue_url}
      end

    end
  end
end
