TrelloClone.Views.BoardShow = Backbone.View.extend({

  template: JST['board_show'],

  events: {
    'click .delete-board': 'deleteBoard'
  },

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
  },

  render: function() {
    var content = this.template({board: this.model});
    this.$el.html(content);

    var $ul = $('<ul>');
    $ul.addClass('board-lists-list group');

    var listsView = new TrelloClone.Views.ListsShow({
      el: $ul,
      collection: this.model.lists()

    });

    var $content = this.$el.find('.board-lists')
    $content.html(listsView.render().$el);

    return this;
  },

  deleteBoard: function(event) {
    event.preventDefault();

    this.model.destroy({
      success: function () {
        Backbone.history.navigate('', {trigger:true});
      },
      wait: true
    });
  }

});
