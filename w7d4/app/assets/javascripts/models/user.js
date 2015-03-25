NewsReader.Models.User = Backbone.Model.extend({

  toJSON: function () {
    return {user: _.clone(this.attributes)};
  }

});
