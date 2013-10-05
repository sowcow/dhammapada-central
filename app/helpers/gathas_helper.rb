# require 'color-generator'
# stylesheet with colors generation
# should be in a seperate file actually
#
module GathasHelper
  COLOR_COUNT = 100
  PARAMS = { lightness: 0.5, saturation: 0.5, hue: 0.5 }
  INDENT = 2 # in sass file...

  def colors
    c = ColorGenerator.new PARAMS
    (1..COLOR_COUNT)
      .map { ?# + c.create_hex }
      .each_with_index
      .map { |color,i|
        "&.x#{ i + 1 }\n  @include glass(#{color})\n"
      }.join.lines.map { |x| (' ' * INDENT) + x}.join
  end

  def colored_text translation
    colored translation.text, translation_framents(translation)
  end

  def translation_framents translation
    text = translation.text
    colors = translation.excerpts.map { |x|
      [x.id, x.from...x.to]
    }
  end

  def range_intersect? range, other
    (range.entries & other.entries).any?
  end

  BREAK = '' #'&nbsp;'
  
  def colored text, fragments # = colors
    lines = fragments.map { |x,y| y } #values
                     .flat_map{|x| [x.begin, x.end] }.uniq
    borders = (lines + [0, text.size]).uniq.sort
    chunks = borders.zip(borders.rotate)[0..-2]
                      .map { |x| Range.new *x, :excl }
  
    groups = chunks.group_by { |x|
      fragments.select { |_,v|
        range_intersect? v, x
      }.map(&:first)
    }.invert
  
    colored_chunks = chunks.map { |x|
      colors = groups.find { |k,v| k.include? x }[1]
      [text[x], colors]
    }
    
    # extract func?
    a = colored_chunks
    around = a.zip([nil]+a.rotate(-1)[1..-1], a.rotate[0..-2]+[nil])
   
    bounded_colored_chunks = around
      .map { |(text,colors), (_,prev_colors),(_,next_colors)|
        colors = colors.map { |x|
          pos = case
          when prev_colors && next_colors \
            && prev_colors.include?(x) \
            && next_colors.include?(x)
            'middle'
          when prev_colors && prev_colors.include?(x)
            'right'
          when next_colors && next_colors.include?(x)
            'left'
          else
            'both'
          end
          [x, pos]
        }
        [text, colors]
      }
  
    bounded_colored_chunks.map { |text, colors|
      first = colors.map { |n,pos|
        klass = "hl x#{n} #{pos}"
        stuff = ''
        # unless - just dirty fix
        unless text[0] =~ /\s/
          stuff += BREAK if %w[left both].include? pos
        end
        "<span class=#{klass.inspect}>#{stuff}" 
      }.join
      last = colors.map { |_,pos|
        stuff = ''
        # unless - just dirty fix
        #unless text[-1] =~ /\s/
          stuff += BREAK if %w[both right].include? pos
        #end
        "#{stuff}</span>"
      }.join
      first + text + last
    }.join
  end


  def prepare_colors translations
    known_links = []
    res = translations.map { |x|
      x.excerpts.map { |x|
        link = x.meaning
        known_links << link
        [link, x.from...x.to]
      }
    }
    mapping = known_links.uniq.each_with_index.map { |x,i|
      { x => i + 1 }
    }.reduce(:merge)
    res = res.map { |a|
      a.map { |id, range|
        [mapping[id], range]
      }
    }
  end
end
