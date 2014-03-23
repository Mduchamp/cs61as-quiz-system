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

# Checkbox Question
class CheckBoxQuestion < Question
  def self.title
    'Checkbox Question'
  end

  def self.param
    'checkbox'
  end
end
