class Project::BaseProjectController < ApplicationController
  layout "project"

  before_filter :preload_project
  before_filter :preload_participant, :preload_organizer
  before_filter :load_menu_pages
  helper_method :conference_site_url, :service_url

  private

    def service_url
      request.domain
    end

    def preload_project
      @conference = Conference.find_by_domain(request.subdomain)
    end

    def authorize_project_management
      authorize! :moderate, @conference
    end

    def check_if_organizer
      redirect_to conference_site_url(@conference), notice: t('projects.news.notices.become_organizer') if @current_organizer.nil?
    end

    def conference_site_url(conference)
      root_url(subdomain: conference.domain)
    end

    def preload_participant
      @current_participant = @conference.participants.where(user_id: current_user.id).last if signed_in?
    end

    def preload_organizer
      @current_organizer = @conference.organizers.where(user_id: current_user.id).last if signed_in?
    end

    def load_menu_pages
      @menu_pages = @conference.pages.in_menu
    end

end
