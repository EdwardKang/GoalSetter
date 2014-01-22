class Goal < ActiveRecord::Base
  attr_accessible :body, :status, :user_id, :completed

  validates :body, :status, :user_id, presence: true

  belongs_to(
  :user,
  class_name: "User",
  foreign_key: :user_id,
  primary_key: :id)
  
  has_many(
    :cheers,
    class_name: 'Cheer',
    foreign_key: :goal_id,
    primary_key: :id
  )

end
