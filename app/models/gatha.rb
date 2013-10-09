class Gatha < ActiveRecord::Base
  belongs_to :vagga
  has_many :translations, as: :translateable
  delegate :book, to: :vagga

  has_many :articles, as: :translateable

  # hardcode is not always a problem...
  MIN = 1
  MAX = 423

  def prev
    that = index.to_i - 1
    that = MAX if that < MIN
    vagga.book.gathas.where(index: that.to_s).first
  end
  def next
    that = index.to_i + 1
    that = MIN if that > MAX
    vagga.book.gathas.where(index: that.to_s).first
  end
end
