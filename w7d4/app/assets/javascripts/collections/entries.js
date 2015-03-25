NewsReader.Collections.Entries = Backbone.Collection.extend({

  model: NewsReader.Models.Entry,

  comparator: function (entry) {
    var time = new Date(entry.escape('published_at')).getTime()
    return -time;
  },

  initialize: function (obj, options) {
    this.feed = options.feed;
  },

  url: function () {
    return this.feed.url() + "/entries";
  }

});
