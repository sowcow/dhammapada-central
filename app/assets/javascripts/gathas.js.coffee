# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
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
 
  hideButton()
  $('html').click react
  $('html').mouseup react
  $(window).resize hideButton
