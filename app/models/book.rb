class Book < ActiveRecord::Base
  has_many :vaggas

  extend FriendlyId
  friendly_id :index, use: [:finders]
end
