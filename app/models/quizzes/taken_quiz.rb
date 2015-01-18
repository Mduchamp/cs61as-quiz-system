# == Schema Information
#
# Table name: taken_quizzes
#
#  id         :integer          not null, primary key
#  quiz_id    :integer
#  student_id :integer
#  created_at :datetime
#  updated_at :datetime
#  grade      :decimal(, )      default(0.0)
#  finished   :boolean          default(FALSE)
#  lesson     :string(255)      default("")
#  comment    :string(255)      default("No comments")
#  retake     :boolean          default(FALSE)
#  reader_id  :integer
#  login      :string(255)      default("")
#

# TakenQuiz Class
class TakenQuiz < ActiveRecord::Base
  default_scope -> { order 'created_at DESC' }

  belongs_to :quiz
  belongs_to :student
  belongs_to :reader
  # Validations for comments

  LOGIN_PATTERN = /\Acs61as-[a-z]{2,3}\z/

  validates :comment, presence: true, length: { maximum: 200 }
  validates :login, presence: true, format: { with: LOGIN_PATTERN }

  scope :not_graded, -> { where(finished: false).includes(:quiz, :student) }
  scope :graded, -> { where(finished: true) }

  def to_s
    "#{Student.find student_id}: #{Quiz.find quiz_id}"
  end

  def finish
    update_attribute(:finished, true)
  end

  def undo
    update_attribute(:finished, false)
  end

  def self.sort_quizzes(taken_quizzes)
    taken_quizzes.sort_by do |r|
      q = Quiz.find(r.quiz_id)
      [Quiz::LESSON_VALUES.find_index(q.lesson), q.version]
    end
  end
end
