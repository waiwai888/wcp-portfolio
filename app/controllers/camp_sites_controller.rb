class CampSitesController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @camp_site = CampSite.new
  end
  
  def create
    @camp_site = CampSite.new(camp_site_params)
    @camp_site.save
    redirect_to camp_site_path(@camp_site)
  end
  
  def index
    @camp_sites = CampSite.page(params[:page]).per(5)
  end
  
  def show
    @camp_site = CampSite.find(params[:id])
    @reviews = @camp_site.reviews.page(params[:page]).per(5)
    @review = Review.new
    @posts = Post.where(camp_site_id: @camp_site.id)
  end
  
  private
  
  def camp_site_params
    params.require(:camp_site).permit(:site_name)
  end
  
end
