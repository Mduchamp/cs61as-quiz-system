# == Schema Information
#
# Table name: taken_quizzes
#
#  id         :integer          not null, primary key
#  quiz_id    :integer
#  student_id :integer
#  created_at :datetime
#  updated_at :datetime
#  grade      :integer          default(0)
#

# TakenQuiz Class
class TakenQuiz < ActiveRecord::Base
  belongs_to :quiz
  belongs_to :student
end
