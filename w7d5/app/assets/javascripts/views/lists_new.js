TrelloClone.Views.ListsNew = Backbone.View.extend ({

  events: {
    "submit .new-list" : "createList"
  },

  template: JST['list_new'],

  initialize: function (options) {
    this.board = options.board;
    this.collection = this.board.lists();
    this.listenTo(this.board, "sync", this.render);
  },

  render: function() {
    var content = this.template({board: this.board, list: this.model});
    this.$el.html(content);

    return this;
  },

  createList: function(event) {
    event.preventDefault();

    var boardId = this.board.id;

    var listTitle = $(event.target).serializeJSON().list.title;
    var listDesc = $(event.target).serializeJSON().list.description;

    var newList = new TrelloClone.Models.List({
      title: listTitle,
      description: listDesc,
      board_id: boardId
    });

    this.collection.create(newList, {
      success: function (){
        var url = 'boards/' + boardId;
        Backbone.history.navigate(url, {trigger: true});
      },
      error: function() {
        console.log('list creation failure')
      }
    });
  }


});
