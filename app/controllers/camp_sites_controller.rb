class CampSitesController < ApplicationController
  
  def new
    @camp_site = CampSite.new
  end
  
  def create
    @camp_site = CampSite.new(camp_site_params)
    @camp_site.save
    redirect_to camp_site_path(@camp_site)
  end
  
  def index
    @camp_sites = CampSite.all
  end
  
  def show
    @camp_site = CampSite.find(params[:id])
    @reviews = Review.all
    @review = Review.new
  end
  
  private
  
  def camp_site_params
    params.require(:camp_site).permit(:site_name)
  end
  
end
