class Book < ActiveRecord::Base
  has_many :vaggas
  has_many :translations, as: :translateable
  has_many :gathas, through: :vaggas

  extend FriendlyId
  friendly_id :index, use: :finders
end
