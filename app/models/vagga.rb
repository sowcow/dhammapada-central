class Vagga < ActiveRecord::Base
  belongs_to :book
  has_many :gathas
end
