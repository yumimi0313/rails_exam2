#ヘルパーメソッドに定義したメソッドはどのViewからの使用できる
module PostsHelper
  def choose_or_edit
    #アクションネームで分岐したい時使う、確認画面で戻るボタンを押、createアクションで戻るボタンを押した時の処理を実装したため、アクションネームがcreateアクションになっている
    if action_name == 'new' || action_name == 'create'
        confirm_posts_path
    elsif
      action_name == 'edit'
        post_path
    end 
  end
end
