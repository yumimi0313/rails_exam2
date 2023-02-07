class PostsController < ApplicationController
  before_action :set_post, only:[:show, :edit, :update, :destroy]

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
    #バリデーションが発生するタイミングは値が保存される時、確認画面時にバリデーションされていてないといけない、手動 でバリデーションに失敗した場合は投稿画面に戻す
    render :new if @post.invalid? 
  end

  def edit
    # current_userと投稿者が一致してなければどこかにredirectさせる
    if current_user.id != @post.user_id
      redirect_to posts_path
    else
      render :edit
    end
  end

  def create
    @post = Post.new(post_params)
    #postsはモデルUserで定義したアソシエーション、アソシエーション状態のインスタンスを作るときはbuild、ログイン中のユーザのpostをbuild(new)する
    @post = current_user.posts.build(post_params)

    if params[:back]
        render :new
    else
      if @post.save
        #newページへ、リダイレクト
      redirect_to new_post_path, notice: "保存しました" 
      else
      render :new
      end
    end
  end

  def update
    if @post.update(post_params)
      #indexページへ
      redirect_to posts_path, notice: "保存しました"
    else
      render :edit
    end
  end

  def destroy
    if current_user.id = @post.user_id
      @post.destroy
      redirect_to posts_path, notice: "削除しました"
    else
      render :posts_path
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
