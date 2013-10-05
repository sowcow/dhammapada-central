#
# todo: nested params
# rename or remove
#

class ExcerptLinksController < ApplicationController
  def create

    t1 = Translation.find(params[:id_1])
    e1 = t1.excerpt(params[:text_1], params[:start_1], params[:end_1])
    t2 = Translation.find(params[:id_2])
    e2 = t2.excerpt(params[:text_2], params[:start_2], params[:end_2])

    case
    when e1.meaning && e2.meaning
      throw 'conflict of colors?'
    when e1.meaning || e2.meaning
      m = e1.meaning if e1.meaning
      m = e2.meaning if e2.meaning
      e1.meaning = m
      e2.meaning = m
    else
      m = Meaning.create translateable: t1.translateable
      e1.meaning = m
      e2.meaning = m
      e1.save
      e2.save
    end
    #e1.linked << e2
    # .save?

    #location = :back
    x = t1.translateable
    location = book_vagga_gatha_path(x.book, x.vagga, x)

    redirect_to location
  end

  #def destroy
  #end
end
