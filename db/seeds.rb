
def make_users
  1.upto(2) do |i|
    Student.create! first_name: 'Student',
                    last_name: "#{i}",
                    email: "student#{i}@gmail.com",
                    password: 'password'
    Staff.create! first_name: 'Staff',
                  last_name: "#{i}",
                  email: "staff#{i}@gmail.com",
                  password: 'password'
  end
end

def make_quizzes
  q = Quiz.create! lesson: 1,
                   version: 1,
                   is_draft: false
  q1 = q.questions.create! number: 1,
                           points: 2,
                           content: 'What is 1 + 1?',
                           type: 'TextboxQuestion'
  q1.create_solution content: '2'
  q.submissions.create content: '2',
                       student_id: 1,
                       question_id: 1
  q2 = q.questions.create! number: 2,
                           points: 3,
                           content: 'What is 1 * 3?',
                           type: 'CheckboxQuestion'
  q.submissions.create content: '3',
                       student_id: 1,
                       question_id: 2
  q2.create_solution content: '3'
  q2.options.create content: '2'
  q2.options.create content: '3'
  q3 = q.questions.create! number: 3,
                           points: 5,
                           content: 'What is 10 + 1?',
                           type: 'MCQuestion'
  q3.create_solution content: '11'
  q3.options.create content: '1'
  q3.options.create content: '11'
  q.submissions.create content: '11',
                       student_id: 1,
                       question_id: 3
  q = Quiz.create! lesson: 2,
                   version: 1
  q1 = q.questions.create! number: 1,
                           points: 10,
                           content: 'What do you say after Hello?',
                           type: 'CodeboxQuestion'
  q1.create_solution content: 'World'
end

def make_requests
  Student.first.create_quiz_request lesson: 1
end

make_users
make_quizzes
make_requests
