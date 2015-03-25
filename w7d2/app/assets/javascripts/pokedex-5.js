Pokedex.Views = {}

Pokedex.Views.PokemonIndex = Backbone.View.extend({
  events: {
    "click .poke-list-item": "selectPokemonFromList"
  },

  initialize: function () {
    this.collection = new Pokedex.Collections.Pokemon();

  },

  addPokemonToList: function (pokemon) {
    var content = JST['pokemonListItem']({pokemon: pokemon});
    this.$el.append(content);
  },

  refreshPokemon: function (options) {
    var that = this
    this.collection.fetch({
      success: (function () {
        this.render();
        if(options && options.callback){
          options.callback()
        }
      }).bind(this)
    })
  },

  render: function () {
    var that = this;
    this.$el.empty();
    this.collection.each( function(poke){ that.addPokemonToList(poke) });
    return this;
  },

  selectPokemonFromList: function (event) {
    var pokeId = $(event.currentTarget).attr('data-id');

    Backbone.history.navigate("/pokemon/" + pokeId, {trigger: true});
  }
});

Pokedex.Views.PokemonDetail = Backbone.View.extend({
  events: {
    "click .toy-list-item": "selectToyFromList",
  },

  refreshPokemon: function (options) {
    this.model.fetch({
      success: (function () {
        this.render();
        if(options && options.callback){
          options.callback()
        }
      }).bind(this)
    })

  },

  // template:JST['pokemonDetail'] ,

  render: function () {
    var that = this;
    var content = JST['pokemonDetail']({pokemon: this.model});
    this.$el.html(content);
    this.model.toys().each( function (toy) {
      content = JST['toyListItem']({toy: toy});
      that.$el.append(content)
    } )
    return this;
  },

  selectToyFromList: function (event) {

    var toyId = $(event.currentTarget).attr('data-id');
    var pokeId = $(event.currentTarget).attr('data-pokemon-id');
    var url = "pokemon/" + pokeId + "/toys/" + toyId;
    Backbone.history.navigate(url, {trigger: true});

  }
});

Pokedex.Views.ToyDetail = Backbone.View.extend({
  render: function () {

     var that = this;
     var content = JST['toyDetail']({toy: this.model, pokes: this.model.pokemon().collection});
     this.$el.html(content);
     return this;
  },
  events: {
    "change .toy-details select": "reassignToy",
  },

  reassignToy: function (event) {
    var toyId = $(event.currentTarget).attr("data-toy-id");
    var oldId = $(event.currentTarget).attr("data-pokemon-id");
    var selectedIndex = event.currentTarget.selectedIndex;
    var newPokeId = $(event.currentTarget.children).eq(selectedIndex).attr("value");

    this.model.save({pokemon_id: newPokeId}, {
      success: function(){
        var url = "/pokemon/" + newPokeId;
        Backbone.history.navigate(url, {trigger: true});
      }
    });

  }
});


// $(function () {
//   var pokemonIndex = new Pokedex.Views.PokemonIndex();
//   pokemonIndex.refreshPokemon();
//   $("#pokedex .pokemon-list").html(pokemonIndex.$el);
// });
