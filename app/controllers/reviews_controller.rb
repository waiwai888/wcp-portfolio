class ReviewsController < ApplicationController
  
  def create
    @camp_site = CampSite.find(params[:id])
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    if @review.save
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @camp_site = CampSite.find(params[:id])
    @review = Review.find(params[:id])
    @review.destroy
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def review_params
    params.require(:review).permit(:title, :site_id, :body, :score)
  end
  
end
