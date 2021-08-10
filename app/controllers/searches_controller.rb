class SearchesController < ApplicationController
  
  def search
		@content = params[:content]
		@posts = Post.search_for(@content).page(params[:page]).per(8)
		@post_count = Post.search_for(@content).count
  end

end
