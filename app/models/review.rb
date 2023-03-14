class Review < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  delegate :user_name, to: :user
  delegate :email, to: :user
  delegate :photo, to: :user
end
