class Cheer < ActiveRecord::Base
  attr_accessible :goal_id, :user_id

  validate :within_limit

  belongs_to(
    :user,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id
  )

  belongs_to(
    :goal,
    class_name: 'Goal',
    foreign_key: :goal_id,
    primary_key: :id
  )

  def within_limit
    user = User.find(self.user_id)
    if user.cheers.today.count >= 5
      errors.add(:base, "You're out of Cheers! :-(")
    end
  end
end
