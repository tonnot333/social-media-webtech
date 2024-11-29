class PostsController < ApplicationController
  before_action :require_user
  before_action :set_post, only: [:edit, :update, :destroy,:like]

  def index
    @post = Post.new
    @comment = Comment.new  # Initialize @comment
    if params[:search].present?
      @posts = Post.where("topic LIKE ? OR content LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    else
      @posts = Post.includes(:user, :comments).order(created_at: :desc)
    end
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to posts_path, notice: 'Post created successfully!'
    else
      flash.now[:alert] = "Failed to create post. Please check your input."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post = Post.find(params[:id])
    respond_to do |format|
      format.html { render :edit } # fallback สำหรับ non-AJAX request
      format.js   # สำหรับ AJAX request
    end
  end
  
  def update
    if @post.update(post_params)
      redirect_to posts_path, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @post = current_user.posts.find_by(id: params[:id])
    if @post
      @post.destroy
      redirect_to posts_path, notice: 'Post deleted successfully!'
    else
      redirect_to posts_path, alert: 'Post not found!'
    end
  end
  
  def like
    # ตรวจสอบสถานะ Like
    like = @post.likes.find_by(user: current_user)
  
    if like
      like.destroy # ถ้ามีการ Like แล้ว ให้ Unlike
      @status = 'unliked'
    else
      @post.likes.create(user: current_user) # ถ้ายังไม่มีการ Like ให้ Like
      @status = 'liked'
    end
  
    respond_to do |format|
      format.html { redirect_to posts_path }
      format.js # สำหรับ AJAX
    end
  end
  

  private

  def post_params
    params.require(:post).permit(:topic, :content)
  end

  def set_post
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to posts_path, alert: 'Post not found!' unless @post
  end
end
