class QuizzesController < ApplicationController

  def take
    @quiz = Quiz.find params[:id]
    @questions = @quiz.questions.order(:number)
                                .each { @quiz.submissions.build }
  end

  def submit
    quiz = Quiz.find params[:id]
    params['submissions'].each do |question_id, submission|
      question = Question.find question_id
      quiz.submissions.create question: question, student: current_user
    end
    flash[:success] = "Submitted quiz #{quiz.lesson}!"
    redirect_to student_dashboard_path
  end

  def index
    @quizzes = Quiz.all
  end

  def new
    @quiz = Quiz.new
  end

  def create
    @quiz = Quiz.new quiz_params
    if @quiz.save
      redirect_to quizzes_path, notice: 'Created quiz.'
    else
      render :new
    end
  end

  def edit
    @quiz = Quiz.find params[:id]
  end

  def update
    @quiz = Quiz.find params[:id]
    if @quiz.update_attributes quiz_params
      redirect_to quizzes_path, notice: 'Updated quiz.'
    else
      render :edit
    end
  end

  def destroy
    Quiz.find(params[:id]).destroy
    redirect_to quizzes_path, notice: 'Deleted quiz.'
  end
end
