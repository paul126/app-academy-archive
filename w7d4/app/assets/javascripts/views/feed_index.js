NewsReader.Views.FeedIndex = Backbone.View.extend({

  initialize: function () {
    this.listenTo(this.collection, "sync", this.render);
  },

  events: {
    "click .destroy": "destroy"
  },

  template: JST["feed_index"],

  render: function () {
    var content = this.template({feeds: this.collection});
    this.$el.html(content);

    return this;
  },

  destroy: function (event) {
    event.preventDefault();
    var id = $(event.target).data("feed-id");

    var feed = this.collection.getOrFetch(id);
    this.collection.remove(feed);

    feed.destroy({
      success: function () {
        this.render();
      }.bind(this)
    });
  }
});
