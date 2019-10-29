# == Schema Information
#
# Table name: answer_choices
#
#  id          :bigint           not null, primary key
#  text        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :integer          not null
#

class AnswerChoice < ApplicationRecord
  validates :text, presence: true, uniqueness: true
  validates :question_id, presence: true

  belongs_to :question,
    class_name: 'Question',
    foreign_key: :question_id,
    primary_key: :id
  
  has_many :responses
end
