# == Schema Information
#
# Table name: responses
#
#  id               :bigint           not null, primary key
#  user_id          :integer          not null
#  answer_choice_id :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Response < ApplicationRecord
  validates :answer_choice_id, :user_id, presence: true
  validate :respondent_can_answer_only_once, :author_cannot_respond_to_own_poll

  belongs_to :answer_choice
  
  belongs_to :respondent,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id

  has_one :question,
    through: :answer_choice,
    source: :question

  def sibling_responses
    self.question.responses.where.not(id: self.id)
  end
  
  def respondent_already_answered?
    sibling_responses.exists?(user_id: self.user_id)
  end

  def creator_rigging_results?
    #return true if user_id == AnswerChoice.find(answer_choice_id).question.poll.author.id
    status = Response.find_by_sql([<<-SQL, answer_choice_id, user_id])
      SELECT
        responses.*
      FROM
        responses
      JOIN
        answer_choices ON responses.answer_choice_id = answer_choices.id
      JOIN
        questions ON questions.id = answer_choices.question_id
      JOIN
        polls ON polls.id = questions.poll_id
      WHERE
        ? = ?
    
    SQL
    return false if status.empty?
    true
  end

  private
  def respondent_can_answer_only_once
    errors[:respondent] << 'can only answer the question once.' if respondent_already_answered?
  end

  def author_cannot_respond_to_own_poll
    errors[:author] << 'cannot respond to their own poll.' if creator_rigging_results?
  end
end
