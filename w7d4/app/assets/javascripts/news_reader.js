window.NewsReader = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    new NewsReader.Routers.FeedRouter($('.content'), $('.user-info'));
    Backbone.history.start();
  }
};

$(document).ready(function(){
  NewsReader.initialize();
});
