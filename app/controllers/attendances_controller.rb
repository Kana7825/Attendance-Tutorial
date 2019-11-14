class AttendancesController < ApplicationController
  before_action :ser_user, only: :edit_one_month
  before_action :logged_in_user, only: [:update, :edhit_one_month]
  before_action :set_one_month, only: :edit_one_month
  
  UPDATE_ERROR_MSG = "勤怠登録に失敗しました。やり直してください。"
  # ↑定数　定数は値を変えることができない。大文字表記。
  def update
    @user =User.find(params[:user_id])
    @attendance = Attendance.find(params[:id])
    # ↓ 出勤時間が未登録であることを判断します。
    if @attendance.started_at.nil?
      if @attendance.update_attributes(started_at: Time.current.change(sec: 0))
        flash[:info] = "おはようございます！"
      else
        flash[:danger] = UPDATE_ERROR_MSG
      end
    elsif @attendance.finished_at.nil?
      if @attendance.update_attributes(finished_at: Time.current.change(sec: 0))
        flash[:info] = "お疲れ様でした。"
      else
        flash[:danger] = UPDATE_ERROR_MSG
      end
    end
    redirect_to @user
  end
  
  def edit_one_month
  end
end
