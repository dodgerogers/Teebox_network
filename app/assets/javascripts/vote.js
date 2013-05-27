$('a#vote').click(function () {
  var url = this.href; // get URL link
  $.post(url);
});