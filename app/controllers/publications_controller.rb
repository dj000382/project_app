class PublicationsController < ApplicationController
  before_filter :signed_in_user

  def create
    @publication = current_user.publications.build(params[:publication])
    if @publication.save
      flash[:success] = "Publication created!"
      redirect_to root_url
    else
			@feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
		@publication = current_user.publications.find_by_id(params[:id])
		redirect_to root_url if @publication.nil?
    @publication.destroy
    redirect_to root_url
  end

  private

    def correct_user
      @publication = current_user.publications.find_by_id(params[:id])
      redirect_to root_url if @publication.nil?
    end
end

