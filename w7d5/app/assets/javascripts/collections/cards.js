TrelloClone.Collections.Cards = Backbone.Collection.extend ({

  model: TrelloClone.Models.Card,

  url: 'api/cards',

  comparator: 'ord',

  initialize: function (model, options) {
    this.list = options.list;
  }

});
