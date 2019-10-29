class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password]) 
      # ログイン後にユーザー情報ページにリダイレクトします。
    else
      
    render :new
    end
  end
end
