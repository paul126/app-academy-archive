NewsReader.Views.Nav = Backbone.View.extend ({

  template: JST['nav'],

  events: {
    "click .sign-in": "newSessionRedirect",
    "click .sign-up": "newUserRedirect",
    "click .sign-out": "sessionDestroy"
  },

  render: function () {
    debugger
    var content = this.template({user: this.model});
    this.$el.html(content);

    return this;
  },

  newSessionRedirect: function (event) {
    Backbone.history.navigate("session/new", {trigger: true});
  },

  newUserRedirect: function (event) {
    Backbone.history.navigate("users/new", {trigger: true});
  },

  sessionDestroy: function (event) {
    this.model.destroy();
  }
});
