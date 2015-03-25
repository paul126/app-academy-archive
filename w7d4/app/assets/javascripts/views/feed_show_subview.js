NewsReader.Views.FeedShowSubview = Backbone.View.extend({

  template: JST["feed_show_subview"],

  tagName: 'li',

  addClass: 'entry-list-item',

  render: function() {
    var content = this.template({entry: this.model});
    this.$el.html(content);

    return this;
  }


});
