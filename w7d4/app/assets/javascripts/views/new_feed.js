NewsReader.Views.NewFeed = Backbone.View.extend({

  events: {
    "submit .create-feed": "createFeed"
  },

  template: JST["new_feed"],

  render: function () {
    var content = this.template();
    this.$el.html(content);

    return this;
  },

  createFeed: function (event) {
    event.preventDefault();
    var data = $(event.target).serializeJSON();
    
    this.collection.create(data);
  }
});
