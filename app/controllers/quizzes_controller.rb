# Controller for quizzes
class QuizzesController < ApplicationController
  def take
    @quiz_form = QuizForm.new Quiz.find(params[:id])
  end

  def submit
    @quiz_form = QuizForm.new Quiz.find(params[:id])
    inject_current_user_into! params
    if @quiz_form.save params[:quiz]
      flash[:success] = "Submitted quiz #{@quiz_form.lesson}!"
      redirect_to student_dashboard_path
    else
      render 'take'
    end
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

  private

  def check_authorization
    authorize! :take, Quiz
  end

  def inject_current_user_into!(quiz_params)
    submissions_params = quiz_params[:quiz][:new_submissions_attributes]
    submissions_params.each { |_, v| v[:student_id] = current_user.id }
  end
end
