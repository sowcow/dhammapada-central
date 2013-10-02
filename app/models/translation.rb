class Translation < ActiveRecord::Base
  belongs_to :translateable, polymorphic: true
  belongs_to :source
  belongs_to :language
  has_many :excerpts

  def excerpt text, from, to
    phrase = Phrase.where(text: text).first_or_create
    excerpt = phrase.excerpts
      .where(translation: self, from: from, to: to)
      .first_or_create
  end
end
