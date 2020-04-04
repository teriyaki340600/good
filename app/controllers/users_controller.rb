class UsersController < ApplicationController
	before_action :authenticate_user!
  def show
  	@user = User.find(params[:id])
    @books = @user.books.page(params[:page]).reverse_order
  	@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
    @book_comment = BookComment.new
  end

  def index
  	@users = User.all #一覧表示するためにUserモデルのデータを全て変数に入れて取り出す。
  	@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
    @user = current_user
  end

  def edit
  	@user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to user_path(current_user)
    end
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
  		redirect_to user_path(@user.id), notice: "successfully updated user!"
  	else
  		@users = User.all
      flash[:alert] = 'error'
      render :edit
  	end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = 'Welcome! You have signed up successfully.'
      redirect_to user_path(@user.id)
    else
      flash.now[:alert] = 'error'
      render "new"
    end
  end

  private
  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image)
  end

  #url直接防止　メソッドを自己定義してbefore_actionで発動。
   #def baria_user
  	#unless params[:id].to_i == current_user.id
  		#redirect_to user_path(current_user)
  	#end
   #end

end
