Pokedex.Views = (Pokedex.Views || {});

Pokedex.Views.PokemonForm = Backbone.View.extend({
  events: {
    "submit .new-pokemon" : "savePokemon"
  },

  render: function () {
    var content = JST['pokemonForm']();
    this.$el.html(content);
    return this;
  },

  savePokemon: function (event) {
    event.preventDefault();
    var that = this;
    var data = $(event.currentTarget).serializeJSON();

    this.model.save(data.pokemon,
      {success: function(){
        that.collection.add(that.model);
        Backbone.history.navigate("/pokemon/" + that.model.id, {trigger: true})
    }});
  }
});
