# == Schema Information
#
# Table name: questions
#
#  id         :bigint           not null, primary key
#  text       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  poll_id    :integer          not null
#

class Question < ApplicationRecord
  validates :text, presence: true, uniqueness: true
  validates :poll_id, presence: true

  has_many :answer_choices,
    class_name: 'AnswerChoice',
    foreign_key: :question_id,
    primary_key: :id

  belongs_to :poll,
    class_name: 'Poll',
    foreign_key: :poll_id,
    primary_key: :id

  has_many :responses,
    through: :answer_choices,
    source: :responses

  def results_n_plus_one
    answer_choices = self.answer_choices

    question_answer_choices_count = {}
    answer_choices.each do |answer_choice|
      question_answer_choices_count[answer_choice.text] = answer_choice.responses.count
    end

    question_answer_choices_count
  end

  def results_includes
    answer_choices = self.answer_choices.includes(:responses)

    question_answer_choices_count = {}
    answer_choices.each do |answer_choice|
      question_answer_choices_count[answer_choice.text] = answer_choice.responses.length
    end

    question_answer_choices_count
  end

  def results_includes_improved
    answer_choices_with_counts = self
      .answer_choices
      .select('answer_choices.text, COUNT(responses.id) answer_choices_count')
      .left_outer_joins(:responses)
      .group('answer_choices.id')

    results = {}  
    answer_choices_with_counts.each do |answer_choice|
      results[answer_choice.text] = answer_choice.answer_choices_count
    end

    results
  end

end
