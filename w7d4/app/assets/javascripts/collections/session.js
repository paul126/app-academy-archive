NewsReader.Collections.Session = Backbone.Collection.extend({
  model: NewsReader.Models.User,

  url: "api/session"
});
