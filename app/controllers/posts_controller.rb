class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
  end

  def confirm
    @post = Post.new(post_params)
    #postsはモデルUserで定義したアソシエーション、アソシエーション状態のインスタンスを作るときはbuild、ログイン中のユーザのpostをbuild(new)する
    @post = current_user.posts.build(post_params) 
    #バリデーションが発生するタイミング、値が保存される時、よって手動でバリデーションに失敗した場合は投稿画面に戻す
    render :new if post.invalid? 
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_path, notice: "Post was successfully destroyed." }
    end
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:content, :image, :image_cache)
    end
end
