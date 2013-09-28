class Vagga < ActiveRecord::Base
  belongs_to :book
  has_many :gathas

  extend FriendlyId
  friendly_id :index, use: :finders
end
