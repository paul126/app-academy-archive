NewsReader.Views.NewUser = Backbone.View.extend({
  template: JST["new_user"],

  events: {
    "submit .new-user": "createUser"
  },

  render: function () {
    var content = this.template();
    this.$el.html(content);

    return this;
  },

  createUser: function (event) {
    event.preventDefault();

    var data = $(event.target).serializeJSON();
    this.collection.create(data, {
      success: function () {
        Backbone.history.navigate("", {trigger: true})
      }.bind(this),

      error: function (data, response) {
        console.log(response)
      }
    });
  }

});
