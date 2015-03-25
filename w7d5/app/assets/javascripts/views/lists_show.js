TrelloClone.Views.ListsShow = Backbone.View.extend({

  initialize: function(options) {

    this.$el = options.el;

  },

  template: JST['lists_show'],

  render: function () {

    var that = this;

    this.collection.each( function (list) {

      var content = that.template({list: list});
      var $list = that.$el.append(content);

      var $ul = $('<ul>');
      $ul.addClass('cards-list group');



      var cardsView = new TrelloClone.Views.CardsShow({
        el: $ul,
        collection: list.cards()
      });

      var $something = $list.find('.list-item.' + list.id);

      $something.append(cardsView.render().$el);


    });

    return this;
  }


})
