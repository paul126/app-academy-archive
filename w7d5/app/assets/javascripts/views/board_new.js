TrelloClone.Views.BoardNew = Backbone.View.extend({

  events: {
    "submit" :"submitBoard"
  },

  template: JST['board_new'],

  initialize: function() {
    this.listenTo(this.collection, "sync add", this.render);
  },

  render: function() {
    var content = this.template({board: this.model});
    this.$el.html(content);

    return this;
  },

  submitBoard: function(event) {
    event.preventDefault();
    var boardTitle = $(event.target).serializeJSON().board.title;

    var newBoard = new TrelloClone.Models.Board({title: boardTitle});

    this.collection.create(newBoard, {
      success: function (){
        var url = 'boards/' + newBoard.id
        Backbone.history.navigate(url, {trigger: true})
      },
      error: function() {
        console.log('board creation failure')
      }
    });
  }

});
