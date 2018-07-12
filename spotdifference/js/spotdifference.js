var SpotDifference;

SpotDifference = (function() {
  function SpotDifference($options) {
    if ($options == null) {
      $options = {};
    }
    this.options = {
      image_div: '#findimage',
      map_name: 'mapname',
      class_mark: 'mark',
      onLoad: function(differences) {},
      onStart: function() {},
      onFind: function(finds, differences) {},
      onEnd: function(time) {}
    };
    this.differences = 0;
    this.start_time = false;
    this.options = $.extend(this.options, $options);
    this.initialize();
  }

  SpotDifference.prototype.initialize = function() {
    this.differences = $("map[name=" + this.options.map_name + "] area").length;
    $('img[usemap]').rwdImageMaps();
    $(this.options.image_div).css('position', 'relative');
    $("map[name=" + this.options.map_name + "] area").on('click', (function(_this) {
      return function(e) {
        e.preventDefault();
        _this.addMark(e);
        _this.finded($(e.target));
      };
    })(this));
    this.options.onLoad(this.differences);
    return this.start_time = new Date().getTime();
  };

  SpotDifference.prototype.finded = function(element) {
    var time;
    element.remove();
    this.options.onFind(this.differences - $("map[name=" + this.options.map_name + "] area").length, this.differences, element);
    if ($("map[name=" + this.options.map_name + "] area").length <= 0) {
      time = new Date().getTime();
      return this.options.onEnd((time - this.start_time) / 1000);
    }
  };

  SpotDifference.prototype.addMark = function(e) {
    var coords, element, h, mark, w, x, x1, x2, y, y1, y2;
    element = $(e.target);
    coords = element.attr('coords').split(',');
    x1 = parseInt(coords[0]);
    y1 = parseInt(coords[1]);
    x2 = parseInt(coords[2]);
    y2 = parseInt(coords[3]);
    x = x1;
    y = y1;
    w = x2 - x1;
    h = y2 - y1;
    mark = $('<i />').addClass(this.options.class_mark);
    mark.css('position', 'absolute');
    $(this.options.image_div).append(mark);
    mark.css('top', y);
    mark.css('left', x);
    mark.css('width', w + 'px');
    return mark.css('height', h + 'px');
  };

  return SpotDifference;

})();
