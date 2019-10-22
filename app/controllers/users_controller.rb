class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new # ﾕｰｻﾞｰｵﾌﾞｼﾞｪｸﾄを生成し、ｲﾝｽﾀﾝｽ変数に代入します。
  end
end
