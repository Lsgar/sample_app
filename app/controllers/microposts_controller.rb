class MicropostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      # @feed_items = []
      @feed_items = current_user.feed.paginate(page: params[:page])
      render 'static_pages/home'
    end
  end

  def destroy
    # @micropost = current_user.microposts.find_by(id: params[:id])
    # if @micropost.nil?
      # redirect_to root_url
    # else
      @micropost.destroy
      flash[:success] = "Micropost destroyed."
      redirect_to root_url
    # end
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content)
    end

    def correct_user
      # @micropost = current_user.microposts.find_by(id: params[:id])
      # redirect_to root_url if @micropost.nil?
      @micropost = current_user.microposts.find(params[:id])
    rescue
      redirect_to root_url
    end
end
