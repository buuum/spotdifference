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
    this.options.onFind(this.differences - $("map[name=" + this.options.map_name + "] area").length, this.differences);
    if ($("map[name=" + this.options.map_name + "] area").length <= 0) {
      time = new Date().getTime();
      return this.options.onEnd((time - this.start_time) / 1000);
    }
  };

  SpotDifference.prototype.addMark = function(e) {
    var mark, x, y;
    x = e.pageX - $(this.options.image_div).offset().left;
    y = e.pageY - $(this.options.image_div).offset().top;
    mark = $('<i />').addClass(this.options.class_mark);
    mark.css('position', 'absolute');
    $(this.options.image_div).append(mark);
    mark.css('top', y - (mark.height() / 2));
    return mark.css('left', x - (mark.height() / 2));
  };

  return SpotDifference;

})();
