#
# todo: nested params
#

class ExcerptLinksController < ApplicationController
  def create

    t1 = Translation.find(params[:id_1])
    e1 = t1.excerpt(params[:text_1], params[:start_1], params[:end_1])
    t2 = Translation.find(params[:id_2])
    e2 = t2.excerpt(params[:text_2], params[:start_2], params[:end_2])

    e1.linked << e2
    # .save?

    #location = :back
    x = t1.translateable
    location = book_vagga_gatha_path(x.book, x.vagga, x)

    redirect_to location
  end

  #def destroy
  #end
end
