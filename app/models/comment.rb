class Comment < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :author, class_name: 'User'

  scope :persisted, lambda { where.not(id: nil) }
  
  delegate :project, to: :ticket

  validates :text, presence: true
end
