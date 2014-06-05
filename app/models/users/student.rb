require 'csv'
# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  type                   :string(255)
#  first_name             :string(255)
#  last_name              :string(255)
#  login                  :string(255)      default("")
#

# Student model; uses users table
class Student < User
  default_scope -> { order 'last_name' }

  has_many :quizzes, through: :taken_quizzes, foreign_key: 'student_id'
  has_many :taken_quizzes, dependent: :destroy
  has_many :submissions
  has_one :quiz_request
  has_one :quiz_lock
  has_many :grades
  has_many :regrades

  delegate :lesson, to: :quiz_request, prefix: true
  delegate :locked?, to: :quiz_lock, allow_nil: true

  def approved_request?
    quiz_lock && !quiz_lock.locked
  end

  def making_request?
    quiz_request
  end

  def taking_quiz?
    quiz_lock
  end

  def student?
    true
  end

  def to_s
    "#{first_name} #{last_name}"
  end

  def taken_quizzes
    taken = []
    submissions.each { |sub| taken << Quiz.find(sub.quiz_id) }
    taken.uniq.sort_by(&:lesson)
  end

  def retake(lesson)
    subm = Submission.where(student_id: id)
    take = []
    subm.each do |s|
      q = Quiz.find(s.quiz_id)
      take << q if q.lesson == lesson.to_i
    end
    take.uniq.size
  end

  def self.get_csv(lesson)
    headers = ['Login', 'Grade', 'Retake']
    CSV.generate({ headers: headers}) do |csv|
      csv << ["Lesson #{lesson} grades"]
      all.each do |student|
        if student.has_grade(lesson)
          csv << student.get_row(lesson)
        end
      end
    end
  end

  def has_grade(lesson)
    !grades.where(lesson: lesson).blank?
  end

  def get_row(lesson)
    grades1 = grades.where(lesson: lesson, retake: 'false')
    grades2 = grades.where(lesson: lesson, retake: 'true')
    total1, total2 = 0, 0
    if grades2.blank?
      grades1.each { |g| total1 += g.grade }
      return [login, grade, 'true']
    else
      grades2.each { |g| total2 += g.grade }
      return total2
    end
  end
end
