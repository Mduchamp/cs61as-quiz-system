# == Schema Information
#
# Table name: quizzes
#
#  id         :integer          not null, primary key
#  lesson     :string(255)      default("")
#  version    :integer          default(0)
#  retake     :boolean          default(FALSE)
#  created_at :datetime
#  updated_at :datetime
#  is_draft   :boolean          default(TRUE)
#

# Quiz class; knows its questions and its submisisons
class Quiz < ActiveRecord::Base
  has_many :students, through: :taken_quizzes, foreign_key: 'quiz_id'
  has_many :taken_quizzes
  has_many :questions, through: :relationships, foreign_key: 'question_id'
  has_many :relationships, dependent: :destroy
  has_many :submissions
  has_many :quiz_requests
  has_many :quiz_locks
  has_many :grades

  # TODO: Make sure deleting a question won't screw up quizzes too hard

  scope :drafts,    -> { where is_draft: true }
  scope :published, -> { where is_draft: false }
  scope :invalid, -> { where lesson: "" }

  # validates :lesson, :version, presence: true
  LESSON_VALUES = ["0-1", "0-2", "0-3", "1", "2", "3", "4", "5", "6",
                   "7", "8", "9", "10", "11", "12", "13", "14"]

  def self.lessons
    published.map(&:lesson).uniq.sort_by do |num|
      Quiz::LESSON_VALUES.find_index num
    end
  end

  def self.choose_one(quiz_request)
    published.where(lesson: quiz_request.lesson, retake: quiz_request.retake)
             .sample
  end

  def to_s
    "Quiz #{lesson}#{!retake ? 'a' : 'b'}#{version}#{' (Draft)' if is_draft}"
  end

  def new_submissions
    questions.map { |q| submissions.build question: q }
  end

  def next_number
    return 1 if questions.empty?
    questions.last.relationships.find_by_quiz_id(id).number + 1
  end

  def self.generate_random(lesson, rtk)
    quiz = create lesson: lesson, retake: rtk == '1'
    easy, medium, hard = quiz.get_quest(lesson)
    quiz.relationships.create(question: hard, number: quiz.next_number) unless hard.nil?
    quiz.relationships.create(question: medium, number: quiz.next_number) unless medium.nil?
    quiz.relationships.create(question: easy, number: quiz.next_number) unless easy.nil?
    quiz
  end

  def get_quest(lesson)
    questions = []
    ['Easy', 'Medium', 'Hard'].each do |diff|
      qst = Question.where(lesson: lesson, difficulty: diff)
      questions << qst.select { |q| can_add? q }.sample
    end
    questions
  end

  def add_numbers
    rlt = Relationship.where quiz_id: id
    count = 1
    rlt.each do |r|
      r.update_attribute :number, count
      count += 1
    end
  end

  def can_add?(question)
    quizzes = Quiz.where lesson: lesson, retake: !retake
    Quiz.check_question quizzes, question
  end

  def self.can_add?(question, les, ret)
    quizzes = Quiz.where lesson: les, retake: !ret
    Quiz.check_question quizzes, question
  end

  def self.check_question(quizzes, question)
    questions_list = []
    quizzes.each { |q| questions_list << q.questions }
    !(questions_list.flatten.include? question)
  end

  def self.has_quiz(lesson, retake)
    !Quiz.published.where(lesson: lesson, retake: retake).blank?
  end

  def self.sort_lesson(quizzes)
    quizzes.sort_by do |q|
      [Quiz::LESSON_VALUES.find_index(q.lesson), q.version]
    end
  end
end
