TrelloClone.Collections.Boards = Backbone.Collection.extend ({

  model: TrelloClone.Models.Board,

  url: 'api/boards',

  getOrFetch: function (id) {
    var board = this.get(id);
    if (!board) {
      board = new TrelloClone.Models.Board({id: id});
      this.add(board);
    }

    board.fetch();
    return board;
  }

});
