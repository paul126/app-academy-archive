TrelloClone.Views.CardsShow = Backbone.View.extend({

  initialize: function(options) {

    this.$el = options.el;

  },

  template: JST['cards_show'],

  render: function () {

    var content = this.template({cards: this.collection});
    this.$el.html(content);

    return this;
  }


})
