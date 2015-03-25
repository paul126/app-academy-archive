window.TrelloClone = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    new TrelloClone.Routers.BoardRouter($(".backdrop")) ;
    Backbone.history.start();
  }
};

$(document).ready(function(){
  TrelloClone.initialize();
});
