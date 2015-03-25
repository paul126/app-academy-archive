var Carousel = $.Carousel = function (el) {

  this.$el = $(el);
  this.$items = this.$el.find('.item');
  this.activeIdx = 0;

  this.handleClicks();

};

$.fn.carousel = function () {
  return this.each(function () {
    new $.Carousel(this);
  });
};

Carousel.prototype.handleClicks = function (){
  this.$el.on('click', '.slide-right', function (event) {

    if (this.activeIdx > 0) {
      this.$items.eq(this.activeIdx + 1).removeClass('right');
      this.$items.eq(this.activeIdx).removeClass('active');
      this.$items.eq(this.activeIdx).addClass('right');
      this.activeIdx -= 1;
      this.$items.eq(this.activeIdx).removeClass('left');
      this.$items.eq(this.activeIdx).addClass('active');
      this.$items.eq(this.activeIdx - 1).addClass('left');
    };

  }.bind(this));

  this.$el.on('click', '.slide-left', function (event) {

    if (this.activeIdx < 4) {
      this.$items.eq(this.activeIdx - 1).removeClass('left');
      this.$items.eq(this.activeIdx).removeClass('active');
      this.$items.eq(this.activeIdx).addClass('left');
      this.activeIdx += 1;
      this.$items.eq(this.activeIdx).removeClass('right');
      this.$items.eq(this.activeIdx).addClass('active');
      this.$items.eq(this.activeIdx + 1).addClass('right');
    };

  }.bind(this));

};
