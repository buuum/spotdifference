class SpotDifference
  constructor: ($options = {}) ->
    @options =
      original_image_div: null
      original_map_name: null
      image_div: '#findimage'
      map_name: 'mapname'
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
      @removeTargets(e)
      @finded($(e.target))
      return

    if @options.original_map_name
      $("map[name=#{@options.original_map_name}] area").on 'click', (e) =>
        e.preventDefault()
        @addMark(e)
        @removeTargets(e)
        @finded($(e.target))
        return

    @options.onLoad @differences

    @start_time = new Date().getTime()

  removeTargets: (e) =>
    coords = $(e.target).attr('coords')
    $("area[coords='#{coords}']").each (index, element )=>
      element.remove()

  finded: (element) ->
    @options.onFind(@differences - $("map[name=#{@options.map_name}] area").length, @differences, element)
    if $("map[name=#{@options.map_name}] area").length <= 0
      time = new Date().getTime()
      @options.onEnd((time - @start_time) / 1000)

  addMark: (e) ->
    element = $(e.target)
    coords = element.attr('coords').split(',')

    x1 = parseInt(coords[0])
    y1 = parseInt(coords[1])
    x2 = parseInt(coords[2])
    y2 = parseInt(coords[3])

    x = x1
    y = y1
    w = x2 - x1
    h = y2 - y1

    mark = $('<i />').addClass(@options.class_mark);
    mark.css 'position', 'absolute'
    mark.css 'top', y
    mark.css 'left', x
    mark.css 'width', w + 'px'
    mark.css 'height', h + 'px'

    $(@options.image_div).append mark
    if @options.original_image_div
      $(@options.original_image_div).append mark.clone()
