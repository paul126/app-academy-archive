NewsReader.Views.NewSession = Backbone.View.extend({
  events: {
    "submit .new-session": "createSession"
  },

  template: JST["new_session"],

  render: function () {
    var content = this.template();
    this.$el.html(content);

    return this;
  },

  createSession: function (event) {
    event.preventDefault();
    var data = $(event.target).serializeJSON();

    this.collection.create(data.user, {
      success: function () {
        console.log("succeed")
        Backbone.history.navigate("", {trigger: true});
      }.bind(this),

      error: function () {console.log('failed')},
      
      wait: true
    });
  }

});
