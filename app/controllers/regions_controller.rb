class RegionsController < ApplicationController
  
  def index
    @regions = Region.where(ancestry: nil) #地方の一覧(親)レコードを取得
  end
  
  def show
    @regions = Region.find(params[:id]).children #地方(親)に紐づく都道府県（子）のレコードを取得
  end
  
end
