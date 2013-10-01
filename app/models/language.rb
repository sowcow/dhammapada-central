class Language < ActiveRecord::Base
  has_many :translations
  has_many :excerpts, through: :translations
  has_many :phrases, through: :excerpts
end
