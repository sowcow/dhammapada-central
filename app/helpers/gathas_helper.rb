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
        #next unless x.excerpt_links.any? #1/3
        # to use other links someday...
        link = x.meaning #x.linkz.first.id #excerpt_links.first.id
        known_links << link
        [link, x.from...x.to]
      }#.compact #2/3
    }#.reject(&:empty?) # 3/3
    mapping = known_links.uniq.each_with_index.map { |x,i|
      { x => i + 1 }
    }.reduce(:merge)
    res = res.map { |a|
      a.map { |id, range|
        [mapping[id], range]
      }
    }
    #throw
  end
end


__END__
require 'slim'
require 'color-generator'

c = ColorGenerator.new lightness: 0.5, saturation: 0.5, hue: 0.5
all_colors = (1..100).map { |i|
  ?# + c.create_hex
}
all_colors
color_styles = all_colors.each_with_index.map { |color,i|
  "&.x#{ i + 1 }\n  @include glass(#{color})\n"
}.join
.lines.map { |x| (' ' * 8) + x}.join


slim = DATA.read.sub '%COLORS%', color_styles
#puts slim


text = 'one sun kinda erases it all ...'
colors = [
  [1, (23...27)],
  [1, (4...20)],
  [2, (8...23)],
  [3, (14...27)],
  [4, (4...7)],
  [5, (4...7)],
  [6, (4...7)],
  #[6, (4...20)],
]


class Range
  def intersect? other
    (entries & other.entries).any?
  end
end

def colored text, fragments # = colors
  lines = fragments.map { |x,y| y } #values
                   .flat_map{|x| [x.begin, x.end] }.uniq
  borders = (lines + [0, text.size]).uniq.sort
  chunks = borders.zip(borders.rotate)[0..-2]
                    .map { |x| Range.new *x, :excl }

  groups = chunks.group_by { |x|
    fragments.select { |_,v|
      v.intersect? x
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

  @BREAK = '&nbsp;'

  bounded_colored_chunks.map { |text, colors|
    first = colors.map { |n,pos|
      klass = "hl x#{n} #{pos}"
      stuff = ''
      # unless - just dirty fix
      unless text[0] =~ /\s/
        stuff += @BREAK if %w[left both].include? pos
      end
      "<span class=#{klass.inspect}>#{stuff}" 
    }.join
    last = colors.map { |_,pos|
      stuff = ''
      # unless - just dirty fix
      #unless text[-1] =~ /\s/
        stuff += @BREAK if %w[both right].include? pos
      #end
      "#{stuff}</span>"
    }.join
    first + text + last
  }.join
end

colored_text = colored text, colors

html = Slim::Template.new { slim }.render colored_text
File.write 'colors.html', html


__END__
doctype 5
html lang = 'en'
  head
    meta encoding = 'utf-8'
    title coloring
    sass:
      @mixin diagonal-stripes($color, $size)
        $c1: $color
        $c2: transparent
        background-size: $size $size
        background-image: repeating-linear-gradient(-45deg, $c1 25%, $c2 25%, $c2 50%, $c1 50%, $c1 75%, $c2 75%)
      @mixin glass($color)
        $part: 50%
        /*33%
        border-color: $color
        background-color: rgba(mix($color, white, $part),0.5)

      $b: 3px
      .hl
        border: solid
        &.left
          margin-left: -$b
          border-width: $b 0 $b $b
          border-radius: 1em 0 0 1em
        &.middle
          border-width: $b 0 $b 0
        &.right
          margin-right: -$b
          border-width: $b $b $b 0
          border-radius: 0 1em 1em 0
        &.both
          margin-left: -$b
          margin-right: -$b
          border-width: $b
          border-radius: 1em 1em 1em 1em

%COLORS%
        /*.map { |x| (' ' * 8) + x}
        /*&.x1
        /*  @include glass(red)
        /*&.x2
        /*  @include glass(blue)
        /*&.x3
        /*  @include glass(green)
        /*&.x4
        /*  @include glass(orange)

      /*html
        @include diagonal-stripes(lightgray, 30px)
  body
    p == self
    /p
      '...
      span class = 'hl left x1'
        span class = 'hl both x4'
          'one
        /'&nbsp;
      span class = 'hl middle x1'
        'sun
      span class = 'hl middle x1'
        span class = 'hl left x3'
          'kinda

      span class = 'hl middle x1'
        span class = 'hl left x2'
          span class = 'hl right x3'
            /'&nbsp;
            'erases
      span class = 'hl right x1'
        span class = 'hl middle x2'
          /'&nbsp;
          'it
      span class = 'hl right x2'  
        'all
      '...
