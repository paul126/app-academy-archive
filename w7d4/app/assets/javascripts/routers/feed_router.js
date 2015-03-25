NewsReader.Routers.FeedRouter = Backbone.Router.extend({
  routes: {
    "" : "feedIndex",
    "feeds/new": "feedNew",
    "feeds/:id" : "feedShow",
    "users/new" : "userNew",
    "session/new": "sessionNew"
  },

  initialize: function ($content, $nav) {
    this.$content = $content;
    this.$nav = $nav;
    this._feeds = new NewsReader.Collections.Feeds();
    this._users = new NewsReader.Collections.Users();
    this._session = new NewsReader.Collections.Session();
    this._users.fetch();
    this._feeds.fetch();
    this.navView = undefined;
    this.renderNav();
    this.listenTo(this._session, "add remove", this.renderNav);
  },

  renderNav: function (){
    this.navView && this.navView.remove();

    this.navView = new NewsReader.Views.Nav({model: this._session.models[0], collection: this._session});
    this.$nav.html(this.navView.render().$el);

  },

  feedIndex: function () {
    console.log('x')
    var indexView = new NewsReader.Views.FeedIndex({collection: this._feeds});
    this._swapView(indexView);
  },

  feedNew: function () {
    var newFeedView = new NewsReader.Views.NewFeed({collection: this._feeds});
    this._swapView(newFeedView);
  },

  feedShow: function (id) {
    var feed = this._feeds.getOrFetch(id);
    var showView = new NewsReader.Views.FeedShow({model: feed});
    this._swapView(showView);
  },

  userNew: function () {
    var newUserView = new NewsReader.Views.NewUser({collection: this._users});
    this._swapView(newUserView);
  },

  sessionNew: function () {
    var newSessionView = new NewsReader.Views.NewSession({collection: this._session});
    this._swapView(newSessionView);
  },

  _swapView: function (view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$content.html(this._currentView.render().$el);
  }


});
