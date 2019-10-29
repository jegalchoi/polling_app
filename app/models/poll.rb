# == Schema Information
#
# Table name: polls
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  author_id  :integer          not null
#

class Poll < ApplicationRecord
  validates :title, uniqueness: true, presence: true
  validates :author_id, presence: true

  belongs_to :author,
    class_name: 'User',
    foreign_key: :author_id,  
    primary_key: :id
  
  has_many :questions,
    class_name: 'Question',
    foreign_key: :poll_id,
    primary_key: :id
end
