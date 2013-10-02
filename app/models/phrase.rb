class Phrase < ActiveRecord::Base
  has_many :excerpts
  delegate :lang, to: :excerpt

  def where_used
    excerpts.map(&:translateable).uniq
  end
end
