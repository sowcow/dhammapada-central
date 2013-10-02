# Place all the behaviors and hooks related to the matching controller here.


# todo: to try to get rid of js...

# copy/paste
param = (name) ->
  name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]")
  regex = new RegExp("[\\?&]" + name + "=([^&#]*)")
  results = regex.exec(location.search)
  if results == null
    ''
  else
    decodeURIComponent results[1].replace(/\+/g, ' ')


#getSelectionCharOffsetsWithin = (element) ->
selPos = (element) ->
    start = 0
    end = 0
    #sel, range, priorRange;
    if typeof window.getSelection != "undefined"
      range = window.getSelection().getRangeAt 0
      priorRange = range.cloneRange()
      priorRange.selectNodeContents(element)
      priorRange.setEnd(range.startContainer, range.startOffset)
      start = priorRange.toString().length
      end = start + range.toString().length
    else if (typeof document.selection != "undefined" &&
            (sel = document.selection).type != "Control")        
      range = sel.createRange()
      priorRange = document.body.createTextRange()
      priorRange.moveToElementText element
      priorRange.setEndPoint "EndToStart", range
      start = priorRange.text.length
      end = start + range.text.length
    { start: start, end: end }


#
# overkill for plain ol' GET request
# window.href = 'url', or so
#
submit = (action, method, values) ->
  form = $ '<form/>', action: action,  method: method
  $.each values, ->
    form.append $ '<input/>',
      type: 'hidden',
      name: this.name,
      value: this.value
  form.appendTo('body').submit()


$ ->

  highlightText = ->
    # dirty step...
    if window.location.search
      from = param 'start'
      to = param 'end'
      node = $(".translation[x-id=#{ param('id') }] .text")
      inner = node.html()
      highlighted = inner.substring from, to
      console.log('wtf!') unless highlighted is param('text')
      span = "<span class=hili>#{highlighted}</span>"
      updated = inner.substring(0,from) + span + \
                inner.substring(to,inner.length)
      node.html updated

    

  $('.button').click ->
    text_node = window.getSelection().anchorNode
    node = text_node.parentNode
    text = window.getSelection().getRangeAt(0).toString()

    pos = selPos text_node
    id = $(node.parentNode).attr 'x-id'


    # dirty js...
    if window.location.search
      token = $('meta[name=csrf-token]').attr 'content'
      submit '/excerpt_links/create', 'POST',
        [
          {name: 'text_1', value: param('text')},
          {name: 'start_1', value: param('start')},
          {name: 'end_1', value: param('end')},
          {name: 'id_1', value: param('id')},

          {name: 'text_2', value: text},
          {name: 'start_2', value: pos.start},
          {name: 'end_2', value: pos.end},
          {name: 'id_2', value: id},
          {name: 'authenticity_token', value: token}
        ]
    else
      submit window.location.pathname, 'GET',
        [
          {name: 'text', value: text},
          {name: 'start', value: pos.start},
          {name: 'end', value: pos.end},
          {name: 'id', value: id},
        ]

  showButton = (node) ->
    button = $ '.button'

    rect = $(node).offset()
    width = $(node).width()
    button.offset top: rect.top, left: rect.left + width
    button.show()

  hideButton = ->
    button = $ '.button'
    button.hide()

  isTranslation = (node) ->
    node = $ node
    node.hasClass('text') and node.parent().hasClass('translation')


  react = ->
    node = window.getSelection().anchorNode
    node = node.parentNode
    text = window.getSelection().getRangeAt(0).toString()
    if node and text and isTranslation node
      showButton node
    else
      hideButton()
 
  highlightText()
  hideButton()
  $('html').click react
  $('html').mouseup react
  $(window).resize hideButton
