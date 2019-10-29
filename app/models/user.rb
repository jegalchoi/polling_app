# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  username   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true

  has_many :authored_polls,
    class_name: 'Poll',
    foreign_key: :author_id,
    primary_key: :id

  has_many :responses

  def completed_polls
    polls = Poll.find_by_sql([<<-SQL, self.id])
      SELECT
        polls.*
      FROM
        polls
      JOIN
        questions ON polls.id = questions.poll_id
      LEFT OUTER JOIN
        (
          SELECT
            *
          FROM
            responses
          JOIN
            answer_choices ON answer_choices.id = responses.answer_choice_id
          JOIN
            questions ON answer_choices.question_id = questions.id
          WHERE
            responses.user_id = ?
        ) user_responses ON user_responses.question_id = questions.id
      GROUP BY
        polls.id
      HAVING
        COUNT(questions.id) = COUNT(user_responses.user_id)
    SQL
  end

  def uncompleted_polls
    polls = Poll.find_by_sql([<<-SQL, self.id])
      SELECT
        polls.*
      FROM
        polls
      JOIN
        questions ON polls.id = questions.poll_id
      LEFT OUTER JOIN
        (
          SELECT
            *
          FROM
            responses
          JOIN
            answer_choices ON answer_choices.id = responses.answer_choice_id
          JOIN
            questions ON answer_choices.question_id = questions.id
          WHERE
            responses.user_id = ?
        ) user_responses ON user_responses.question_id = questions.id
      GROUP BY
        polls.id
      HAVING
        COUNT(questions.id) != COUNT(user_responses.user_id) AND COUNT(user_responses.user_id) >= 1
    SQL
  end
    
end
