class Meaning < ActiveRecord::Base
  belongs_to :translateable, polymorphic: true
  has_many :excerpts
end
