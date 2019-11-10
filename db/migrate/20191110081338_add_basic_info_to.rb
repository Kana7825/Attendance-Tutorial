class AddBasicInfoTo < ActiveRecord::Migration[5.1]
  def change
    add_colum :users, :basic_time, :datetime, default: time.current.change(hour: 8, min: 0, sec: 0)
    add_colum :users, :work_time, :datetime, default: time.current.chang(hour: 7, min: 30, sec: 0)
  end
end
