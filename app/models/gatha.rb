class Gatha < ActiveRecord::Base
  belongs_to :vagga
  has_many :translations, as: :translateable
end
