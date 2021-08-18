class HomesController < ApplicationController

  def top
    @posts = Post.all.sample(6)
  end

end
