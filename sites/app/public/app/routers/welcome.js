// Generated by CoffeeScript 1.7.1
(function() {
  define(["backbone", "app/modules/welcome/main", "subroute"], function(Backbone, Welcome) {
    return Backbone.SubRoute.extend({
      routes: {
        "": "login",
        "login": "login",
        "register": "register"
      },
      login: function() {
        return Welcome.init();
      },
      index: function() {
        return console.log("Route to index...");
      },
      register: function() {
        return console.log("Route to register...");
      }
    });
  });

}).call(this);

//# sourceMappingURL=welcome.map