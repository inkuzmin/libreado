// Generated by CoffeeScript 1.7.1
(function() {
  var $content;

  $('.welcome-background').blurjs({
    source: '#content',
    overlay: 'rgba(255,255,255,0.4)',
    offset: {
      x: 0,
      y: -12
    },
    fluid: true,
    radius: 5,
    customCSS: {
      'opacity': '1'
    }
  });

  if (Modernizr.touch) {
    $(".welcome").addClass("layer").data("depth", "0.15");
    $content = $("#content").parallax({
      css3: false
    });
    $('input').focusin(function() {
      return $content.parallax("disable");
    });
    $('input').focusout(function() {
      return $content.parallax("enable");
    });
  }

}).call(this);

//# sourceMappingURL=login.map
