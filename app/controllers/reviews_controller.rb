class ReviewsController < ApplicationController
  
  def create
    @camp_site = CampSite.find(params[:camp_site_id])
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    
    if @review.save
      flash[:notice] = "レビューを投稿しました"
      redirect_back(fallback_location: root_path)
    else
      @camp_site = CampSite.find(params[:camp_site_id])
      render camp_site_path(@camp_site)
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
    params.require(:review).permit(:title, :camp_site_id, :body, :score)
  end
  
end
