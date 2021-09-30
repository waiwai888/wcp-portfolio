class CampSitesController < ApplicationController
  before_action :authenticate_user!

  def new
    @camp_site = CampSite.new
    @regions = Region.where(ancestry: nil)
  end
  
  def index
    @region = Region.find_by(id: params[:region_id])
    @camp_sites = CampSite.where(region_id: @region.id).page(params[:page]).per(5) #都道府県（子）に紐づくキャンプサイトを取得
  end

  def create
    @camp_site = CampSite.new(camp_site_params)
    @regions = Region.all #キャンプサイト登録時にregionを選択するために定義
    if !params[:camp_site][:region_id].blank? #region_idがブランク（選択してくださいのまま）である場合は@camp_site.saveのバリデーションで弾く
      @region = Region.find(params[:camp_site][:region_id]) #登録するregionを受け取り取得
      @camp_site.region_id = @region.id #region_idに入れて保存
    end
    if @camp_site.save
      redirect_to camp_site_path(@camp_site)
    else
      @regions = Region.where(ancestry: nil)
      render :new
    end
  end

  def show
    @camp_site = CampSite.find(params[:id])
    @reviews = @camp_site.reviews.page(params[:page]).per(5)
    @review = Review.new
    @posts = Post.where(camp_site_id: @camp_site.id)
  end

  private

  def camp_site_params
    params.require(:camp_site).permit(:site_name, :region_id)
  end

end
