class CreateQuizTime < ActiveRecord::Migration
  def change
    create_table :quiz_times do |t|
      t.integer :student_id
      t.integer :time
    end
  end
end
