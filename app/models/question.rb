# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  content    :text
#  number     :integer
#  quiz_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  points     :integer          default(0), not null
#  type       :string(255)
#

# Model that represents questions
class Question < ActiveRecord::Base
  default_scope -> { order 'number ASC' }

  belongs_to :quiz
  has_many :submissions
  has_one :solution, dependent: :destroy
  has_many :options

  def to_s
    "Question #{number} (#{points} points)"
  end
end
