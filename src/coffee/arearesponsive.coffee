(($) ->

  $.fn.rwdImageMaps = ->
    $img = this

    rwdImageMap = ->
      $img.each ->
        if typeof $(this).attr('usemap') == 'undefined'
          return
        that = this
        $that = $(that)
        # Since WebKit doesn't know the height until after the image has loaded, perform everything in an onload copy
        $('<img />').on('load', ->
          attrW = 'width'
          attrH = 'height'
          w = $that.attr(attrW)
          h = $that.attr(attrH)
          if !w or !h
            temp = new Image
            temp.src = $that.attr('src')
            if !w
              w = temp.width
            if !h
              h = temp.height
          wPercent = $that.width() / 100
          hPercent = $that.height() / 100
          map = $that.attr('usemap').replace('#', '')
          c = 'coords'
          $('map[name="' + map + '"]').find('area').each ->
            $this = $(this)
            if !$this.data(c)
              $this.data c, $this.attr(c)
            coords = $this.data(c).split(',')
            coordsPercent = new Array(coords.length)
            i = 0
            while i < coordsPercent.length
              if i % 2 == 0
                coordsPercent[i] = parseInt(coords[i] / w * 100 * wPercent)
              else
                coordsPercent[i] = parseInt(coords[i] / h * 100 * hPercent)
              ++i
            $this.attr c, coordsPercent.toString()
            return
          return
        ).attr 'src', $that.attr('src')
        return
      return

    $(window).resize(rwdImageMap).trigger 'resize'
    this

  return
) jQuery