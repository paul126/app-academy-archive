TrelloClone.Routers.BoardRouter = Backbone.Router.extend({

  routes: {
      '' : 'boardIndex',
      'boards/new' : 'boardNew',
      'boards/:id' : 'boardShow',
      'boards/:id/lists/new' : 'listNew'
  },

  initialize: function ($backdrop) {
    this.$backdrop = $backdrop;
    this._boards = new TrelloClone.Collections.Boards();
    this._boards.fetch();
  },

  boardIndex: function () {
    var boardView = new TrelloClone.Views.BoardIndex({collection: this._boards});
    this._swapView(boardView);
  },

  boardNew: function () {
    var boardView = new TrelloClone.Views.BoardNew({collection: this._boards});
    this._swapView(boardView);
  },

  boardShow: function (id) {

    var board = this._boards.getOrFetch(id);
    var boardView = new TrelloClone.Views.BoardShow({model: board});
    this._swapView(boardView);
  },

  listNew: function (id) {
    var board = this._boards.getOrFetch(id);
    var listNewView = new TrelloClone.Views.ListsNew({board: board})
    this._swapView(listNewView);

  },

  _swapView: function (newView) {
    this._currentView && this._currentView.remove();
    this._currentView = newView;
    this.$backdrop.html(this._currentView.render().$el);
  }

});
