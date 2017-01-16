module Houston
  module SupportForm
    class RequestsController < Houston::SupportForm::ApplicationController
      attr_reader :project
      before_filter :authenticate_user!

      def index
        @projects = followed_projects
      end

      def new
        @project = Project.find_by_slug params[:project]
        return render file: "public/404.html" unless @project

        # BEGIN COPIED FROM project_tickets_controller#new
        unless @project.has_ticket_tracker?
          render template: "houston/tickets/project_tickets/no_ticket_tracker"
          return
        end

        Houston.benchmark "Load tickets" do
          @tickets = @project.tickets
            .where(type: "Bug")
            .pluck(:id, :summary, :number, :closed_at)
            .map do |id, summary, number, closed_at|
            { id: id,
              summary: summary,
              closed: closed_at.present?,
              ticketUrl: @project.ticket_tracker_ticket_url(number),
              number: number }
          end
        end
        # END COPIED FROM project_tickets_controller#new

        # BEGIN COPIED FROM project_feedback_controller#index
        @tags = Houston::Feedback::Conversation.for_project(project).tags
        # END COPIED FROM project_feedback_controller#index
      end

    end
  end
end
