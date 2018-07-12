class SpotDifference
  constructor: ($options = {}) ->
    @options =
      image_div: '#findimage'
      map_name: 'mapname'
      class_mark: 'mark'
      onLoad: (differences) ->
      onStart: ->
      onFind: (finds, differences) ->
      onEnd: (time) ->

    @differences = 0;
    @start_time = false

    @options = $.extend @options, $options
    @initialize()

  initialize: ->
    @differences = $("map[name=#{@options.map_name}] area").length
    $('img[usemap]').rwdImageMaps()
    $(@options.image_div).css 'position', 'relative'

    $("map[name=#{@options.map_name}] area").on 'click', (e) =>
      e.preventDefault()
      @addMark(e)
      @finded($(e.target))
      return

    @options.onLoad @differences

    @start_time = new Date().getTime()


  finded: (element) ->
    element.remove()
    @options.onFind(@differences - $("map[name=#{@options.map_name}] area").length, @differences)
    if $("map[name=#{@options.map_name}] area").length <= 0
      time = new Date().getTime()
      @options.onEnd((time - @start_time) / 1000)

  addMark: (e) ->
    x = e.pageX - $(@options.image_div).offset().left
    y = e.pageY - $(@options.image_div).offset().top

    mark = $('<i />').addClass(@options.class_mark);
    mark.css 'position', 'absolute'
    $(@options.image_div).append mark
    mark.css 'top', y - (mark.height() / 2)
    mark.css 'left', x - (mark.height() / 2)
