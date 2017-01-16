(function($) {
  $.fn.rwdImageMaps = function() {
    var $img, rwdImageMap;
    $img = this;
    rwdImageMap = function() {
      $img.each(function() {
        var $that, that;
        if (typeof $(this).attr('usemap') === 'undefined') {
          return;
        }
        that = this;
        $that = $(that);
        $('<img />').on('load', function() {
          var attrH, attrW, c, h, hPercent, map, temp, w, wPercent;
          attrW = 'width';
          attrH = 'height';
          w = $that.attr(attrW);
          h = $that.attr(attrH);
          if (!w || !h) {
            temp = new Image;
            temp.src = $that.attr('src');
            if (!w) {
              w = temp.width;
            }
            if (!h) {
              h = temp.height;
            }
          }
          wPercent = $that.width() / 100;
          hPercent = $that.height() / 100;
          map = $that.attr('usemap').replace('#', '');
          c = 'coords';
          $('map[name="' + map + '"]').find('area').each(function() {
            var $this, coords, coordsPercent, i;
            $this = $(this);
            if (!$this.data(c)) {
              $this.data(c, $this.attr(c));
            }
            coords = $this.data(c).split(',');
            coordsPercent = new Array(coords.length);
            i = 0;
            while (i < coordsPercent.length) {
              if (i % 2 === 0) {
                coordsPercent[i] = parseInt(coords[i] / w * 100 * wPercent);
              } else {
                coordsPercent[i] = parseInt(coords[i] / h * 100 * hPercent);
              }
              ++i;
            }
            $this.attr(c, coordsPercent.toString());
          });
        }).attr('src', $that.attr('src'));
      });
    };
    $(window).resize(rwdImageMap).trigger('resize');
    return this;
  };
})(jQuery);
