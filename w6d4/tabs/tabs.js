var Tabs = $.Tabs = function (el) {

  this.$el = $(el);
  this.$tabTitles = this.$el.find(".tab-titles");
  this.$activeTitle = this.$el.find("a.active");
  this.$contentTabs = this.$el.find(".content-tabs")
  this.$activeTab = this.$el.find(".tab-pane.active")

  this.clickTabs();

};

$.fn.tabs = function () {
  return this.each(function () {
    new $.Tabs(this);
  });
};

Tabs.prototype.clickTabs = function (){
  this.$el.on('click', 'a', function (event) {
    event.preventDefault();
    var $clickedTab = $(event.currentTarget);
    this.$activeTitle.removeClass("active");
    this.$activeTitle = $clickedTab;
    this.$activeTitle.addClass("active");

    this.$activeTab.removeClass("active");
    this.$activeTab.addClass("transitioning");

    this.listenForTransition();

  }.bind(this));
};

Tabs.prototype.listenForTransition = function (){

  this.$activeTab.one('transitionend', function (event) {

    this.$activeTab.removeClass("transitioning");

    this.$activeTab = this.$contentTabs.find(this.$activeTitle.attr("href"));
    this.$activeTab.addClass("active");
    this.$activeTab.addClass("transitioning");

    setTimeout(function() {
      this.$activeTab.removeClass("transitioning");
    }.bind(this), 0);

  }.bind(this));

};
