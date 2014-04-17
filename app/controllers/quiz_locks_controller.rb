# Controller for QuizLocks
class QuizLocksController < ApplicationController
  authorize_resource class: false

  def lock
    quiz_lock = QuizLock.find params[:id]
    quiz_lock.lock!
  end
end
