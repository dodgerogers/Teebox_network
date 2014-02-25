$("a#vote").click(function() {
  var url;
  url = this.href;
  return $.post(url);
});