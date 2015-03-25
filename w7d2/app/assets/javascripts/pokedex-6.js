Pokedex.Router = Backbone.Router.extend({
  routes: {
    '': 'pokemonIndex',
    'pokemon/:id': 'pokemonDetail',
    'pokemon/:pokemonId/toys/:toyId': 'toyDetail'
  },

  pokemonDetail: function (id, callback) {
    if(!this._pokemonIndex) {
      this.pokemonIndex(this.pokemonDetail.bind(this, id, callback));
      return;
    }

    var poke = this._pokemonIndex.collection.get(id);
    var detailView = new Pokedex.Views.PokemonDetail({model: poke});
    $("#pokedex .toy-detail").empty();
    $("#pokedex .pokemon-detail").html(detailView.$el);
    detailView.refreshPokemon({callback: callback});
  },

  pokemonIndex: function (callback) {
    this._pokemonIndex = new Pokedex.Views.PokemonIndex();
    this._pokemonIndex.refreshPokemon({callback: callback});
    $("#pokedex .pokemon-list").html(this._pokemonIndex.$el);
    this.pokemonForm();
  },

  toyDetail: function (pokemonId, toyId) {
    if(!this._pokemonIndex) {

      this.pokemonDetail(pokemonId, this.toyDetail.bind(this, pokemonId, toyId));
    } else {

      var poke = this._pokemonIndex.collection.get(pokemonId);
      var toy = poke.toys().get(toyId);

      var toyDetail = new Pokedex.Views.ToyDetail({model: toy});
      $("#pokedex .toy-detail").html(toyDetail.render().$el);
    };
  },

  pokemonForm: function () {
    var poke = new Pokedex.Models.Pokemon();
    var collection = this._pokemonIndex.collection;
    var form = new Pokedex.Views.PokemonForm({model: poke, collection: collection});
    $('#pokedex .pokemon-form').html(form.render().$el);
  }
});

$(function () {
  new Pokedex.Router();
  Backbone.history.start();
});
