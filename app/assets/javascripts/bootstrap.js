$(function() {
  $("a[rel~=popover], .has-popover").popover();
  return $("body").tooltip({
	selector: "a[rel~=tooltip], .has-tooltip"
  });
});
