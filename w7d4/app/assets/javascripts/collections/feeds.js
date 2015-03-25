NewsReader.Collections.Feeds = Backbone.Collection.extend ({

  url: "api/feeds",

  model: NewsReader.Models.Feed,

  comparator: 'id',

  initialize: function () {
    this.listenTo(this, "add", this.redirectIndex);
  },

  redirectIndex: function () {

    Backbone.history.navigate("", {trigger: true});

  },

  getOrFetch : function (id) {
    var feed = this.get(id);
    if (!feed) {
      feed = new NewsReader.Models.Feed({id: id});
      this.add(feed);
    }

    feed.fetch();

    return feed;
  }

});
