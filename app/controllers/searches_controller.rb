class SearchesController < ApplicationController

  def search
		@content = params[:content]
    if @content.include?("#") #頭文字が'#'の場合は
      @content.slice!("#") #'#'を取り除いた文字列を用いて
      @posts = Tag.search(@content).order('created_at DESC') #tag_nameカラムを検索
    else
      @posts = Post.search_for(params[:content]).order('created_at DESC') #'#'がなければ投稿本文を検索
    end
     @post_count = @posts.count
  end

end
