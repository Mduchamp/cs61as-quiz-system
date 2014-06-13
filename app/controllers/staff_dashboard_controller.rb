# Controller for staff dashboard
class StaffDashboardController < ApplicationController
  authorize_resource class: false

  def index
    @drafts = Quiz.drafts
    @published = Quiz.published
    @quiz = Quiz.new
    @download = downloads
  end

  def questions
    @lessons = Quiz.all_lessons
  end

  def requests
    @requests = QuizRequest.all
    @regrades = Regrade.not_graded
  end

  def students
    @students = Student.page params[:page]
    @value = params[:search]
    @search = Student.get(params[:search])
  end

  def grading
    @to_grade = TakenQuiz.not_graded
  end

  def bank
    @questions = Question.where(lesson: params[:id])
                         .includes(:solution).includes(:rubric)
                         .page params[:page]
    @requests = QuizRequest.all
    @add = params[:add] == 'true'
    @id = params[:quiz_id]
  end

  def add
    id, qid = params[:id], params[:quiz_id]
    quiz = Quiz.find params[:quiz_id]
    quest = Question.find params[:id]
    if quiz.can_add? quest
      Relationship.where(question_id: id, quiz_id: qid).first_or_create
      flash[:success] = 'Added question from question bank!'
      redirect_to edit_quiz_path(params[:quiz_id])
    else
      @lesson = Quiz.all_lessons
      flash[:error] = 'This question has already been used on a retake!'
      redirect_to question_bank_path(id: quiz.lesson,
                                     add: true,
                                     quiz_id: quiz.id)
    end
  end

  def download
    respond_to do |format|
      format.html { redirect_to staff_dashboard_path }
      format.csv do
        send_data Student.get_csv(params[:lesson]),
                  filename: "lesson#{params[:lesson]}.csv"
      end
    end
  end

  def import_students_form
    @results = []
  end

  def import_students
    @logins = params[:logins]
    @results = @logins.split
                      .reject { |login| Student.find_by_login login }
                      .map { |login| import_student login }
    render :import_students_form
  end

  private

  def downloads
    download = []
    (1..14).each do |n|
      download << ["Lesson #{n}", n.to_s]
    end
    download
  end

  def import_student(login)
    password = Devise.friendly_token.first 8
    student = Student.create(login: login, password: password,
                             first_name: login, last_name: login)
    if student.new_record?
      [login, "Not saved. #{student.errors.full_messages.join ' '}"]
    else
      [login, password]
    end
  end
end
