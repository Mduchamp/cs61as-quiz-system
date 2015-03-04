require 'spec_helper'

describe 'A signed in student' do
  let(:student) { create :student, added_info: true }
  before { sign_in student }

  subject { page }

  it { should have_content 'Student Dashboard' }

  describe 'cannot' do
    describe 'edit quizzes' do
      let(:quiz) { create :quiz }
      before { visit edit_staffs_quiz_path quiz }

      it { should_not have_content 'Editing' }
      it { should have_content 'Student' }
    end

    describe 'view staff dashboard' do
      before { staffs_dashboard_index_path }
      it { should_not have_content 'Staff' }
      it { should have_content 'Student' }
    end

    describe 'take quiz without making request' do
      before { visit take_students_quizzes_path }
      it { should_not have_content '#take_quiz_form' }
      it { should have_content 'Student' }
    end
  end

  describe 'can' do
    describe 'make a request' do
      let!(:quiz) { create :quiz }
      before do
        visit students_dashboard_path
        select quiz.lesson, from: 'lesson'
        click_button 'Request'
      end

      it { should have_content 'requesting' }
    end
  end
end
