# ensures dhp skeleton
# only crates stuff, does not remove anything...
# so it does not update attrs, just creates new entities
# maybe there is some reason not to be destructive...


# Dhp Structure:
#
dhp = YAML.load File.read 'db/seeds/toc.yml'

book = Book.where(index: dhp[:index])
           .first_or_create

dhp[:vaggas].each { |x|
  vagga = Vagga.where(index: x[:index], book: book)
               .first_or_create

  x[:gathas].each { |x|
    Gatha.where(index: x[:index], vagga: vagga)
         .first_or_create
  }
}


# Dhp Contents:
#
def ensure_content file
dhp = YAML.load File.read file

#attrs = dhp.reject { |k,v| %i[books tags].include? k }
attrs = dhp.select { |k,v| %i[source lang].include? k }
src = Source.where(attrs).first_or_create

dhp[:books].each { |text, data|
  #text, data = x.to_a.first # hash
  #binding.pry
  index = data[:index]
  text = data[:text] if data[:text]

  book = Book.where(index: index).first
  book.translations.where(source: src)
  .first_or_create text: text

  data[:vaggas].each { |text, data|
    #index, data = x.to_a.first # hash
    index = data[:index]
    text = data[:text] if data[:text]

    vagga = Vagga.where(book: book, index: index).first
    vagga.translations.where(source: src)
    .first_or_create text: text

    data[:gathas].each { |index, data|
      #index, data = x.to_a.first # hash
      #index = data[:index]
      #binding.pry unless data_
      text = data[:text] #if data[:text]

      if index == 0
        puts 'ignoring'
        next
      end
      gatha = Gatha.where(vagga: vagga, index: index).first
      gatha.translations.where(source: src)
      .first_or_create text: text
    }
  }
}
end

ensure_content 'db/seeds/dhp_original.yml'
ensure_content 'db/seeds/en_dhp_achariya.yml'
