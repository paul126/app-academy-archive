NewsReader.Views.FeedShow = Backbone.View.extend({

  initialize: function () {
    this.subViews = [];
    this.listenTo(this.model, "sync", this.render);
  },

  events: {
    "click .refresh-feed": "refreshFeed"
  },

  template: JST["feed_show"],

  render: function () {
    var content = this.template({feed: this.model});
    this.$el.html(content);

    this.renderEntries();

    return this;
  },

  renderEntries : function () {

    this.subViews = [];
    var $ul = this.$el.find('.entries-list');

    this.model.entries().each( function(entry) {
      var subView = new NewsReader.Views.FeedShowSubview({model: entry});
      $ul.append(subView.render().$el);
      this.subViews.push(subView);
    }.bind(this));

  },

  refreshFeed: function () {

    this.model.fetch({
      success: function () {
        this.render();
      }.bind(this)
    });

  },

  remove: function () {
    this.subViews.forEach(function (view) {
      view.remove();
    });

    Backbone.View.prototype.remove.call(this);
  }
})
