# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  content    :text
#  number     :integer
#  created_at :datetime
#  updated_at :datetime
#  points     :integer          default(0), not null
#  type       :string(255)
#  lesson     :integer
#  difficulty :string(255)
#  draft      :boolean          default(TRUE)
#

# Checkbox Question
class CheckboxQuestion < Question
  def self.title
    'Checkbox Question'
  end

  def self.param
    'CheckboxQuestion'
  end
end
