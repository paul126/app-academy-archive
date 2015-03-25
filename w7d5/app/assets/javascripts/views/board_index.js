TrelloClone.Views.BoardIndex = Backbone.View.extend ({

  template: JST['board_index'],

  initialize: function () {
    this.listenTo(this.collection, "add sync", this.render);
  },

  render: function () {
    var content = this.template({boards: this.collection});
    this.$el.html(content);

    return this;
  }

});
