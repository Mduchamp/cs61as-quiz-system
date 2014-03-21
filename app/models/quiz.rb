# == Schema Information
#
# Table name: quizzes
#
#  id         :integer          not null, primary key
#  lesson     :integer
#  version    :integer
#  retake     :boolean          default(FALSE)
#  created_at :datetime
#  updated_at :datetime
#

# Quiz class; knows its questions and its submisisons
class Quiz < ActiveRecord::Base
  has_many :questions, dependent: :destroy
  has_many :submissions
  has_many :quiz_requests

  scope :drafts,    -> { where is_draft: true }
  scope :published, -> { where is_draft: false }
  
  def self.lessons
    all.map(&:lesson).uniq.sort
  end

  def self.choose_one(lesson)
    where(lesson: lesson).sample
  end

  def full_name
    "Quiz #{lesson}#{!retake ? 'a' : 'b'}#{version}"
  end

  def new_submissions
    questions.map { |q| submissions.build question: q }
  end

  def self.create_with_question
    quiz = create
    quiz.questions.create
    quiz
  end
end
