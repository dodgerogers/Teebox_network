var SublimeVideoPlaylist = function(playlistWrapperId, options){
  if (!$("#" + playlistWrapperId)) return;

  this.options = options;
  this.playlistWrapperId = playlistWrapperId;
  this.firstVideoId = $("#" + this.playlistWrapperId + " video").attr("id");

  this.setupObservers();
  this.updateActiveVideo(this.firstVideoId);
  this.clickOnThumbnail(this.activeVideoId, this.options["autoplayOnPageLoad"]);
};

$.extend(SublimeVideoPlaylist.prototype, {
  setupObservers: function() {
    var that = this;

    $("#"+ this.playlistWrapperId + " li").each(function() {
      $(this).on("click", function(event) {
        event.preventDefault();
        if (!$(this).hasClass("active")) {
		  event.preventDefault();
          that.clickOnThumbnail($(this).attr("id"), that.options["autoplayNext"]);
        }
      });
    });
  },
  reset: function() {
    // Hide the current active video
    $("#" + this.playlistWrapperId + " .video_wrap.active").removeClass("active");

    // Get current active video and unprepare it
    sublime.unprepare($("#" + this.activeVideoId)[0]);

    // Deselect its thumbnail
    this.deselectThumbnail(this.activeVideoId);
  },
  clickOnThumbnail: function(thumbnailId, autoplay) {
    var that = this;
    this.updateActiveVideo(thumbnailId.replace(/^thumbnail_/, ""));

    sublime.prepare($("#" + this.activeVideoId)[0], function(player){
      if (autoplay) player.play(); // Play it if autoplay is true
      player.on({
        start: that.onVideoStart,
        play: that.onVideoPlay,
        pause: that.onVideoPause,
        end: that.onVideoEnd,
        stop: that.onVideoStop
      });
    });
  },
  selectThumbnail: function(videoId) {
    $("#thumbnail_" + videoId).addClass("active");
  },
  deselectThumbnail: function(videoId) {
    $("#thumbnail_" + videoId).removeClass("active");
  },
  updateActiveVideo: function(videoId) {
    // Basically undo all the stuff and bring it back to the point before js kicked in
    if (this.activeVideoId) this.reset();

    // Set the new active video
    this.activeVideoId = videoId;

    // And show the video
    this.showActiveVideo();
  },
  showActiveVideo: function() {
    // Select its thumbnail
    this.selectThumbnail(this.activeVideoId);

    // Show it
    $("#" + this.activeVideoId).parent().addClass("active");
  },
  handleAutoNext: function(newVideoId) {
    this.clickOnThumbnail(newVideoId, this.options["autoplayNext"]);
  },
  onVideoStart: function(player) {
    // console.log("Stop event!")
  },
  onVideoPlay: function(player) {
    // console.log("Play event!")
  },
  onVideoPause: function(player) {
    // console.log("Pause event!")
  },
  onVideoEnd: function(player) {
    // console.log("End event!")
    var videoId = player.videoElement().id;
    if (videoId.match(/^video([0-9]+)$/) !== undefined) {
      var playlistId    = $(player.videoElement()).parents(".sv_playlist").attr("id");
      var nextThumbnail = $("#thumbnail_" + videoId).next("li");

      if (nextThumbnail.length > 0) {
        if (SublimeVideo.playlists[playlistId].options["loadNext"]) {
          SublimeVideo.playlists[playlistId].handleAutoNext(nextThumbnail.attr("id"));
        }
      }
      else if (SublimeVideo.playlists[playlistId].options["loop"]) {
        SublimeVideo.playlists[playlistId].updateActiveVideo(SublimeVideo.playlists[playlistId].firstVideoId);
        SublimeVideo.playlists[playlistId].handleAutoNext(SublimeVideo.playlists[playlistId].activeVideoId);
      }
      else { player.stop(); }
    }
  },
  onVideoStop: function(player) {
    // console.log("Stop event!")
  }
});

var SublimeVideo = SublimeVideo || {};
SublimeVideo.playlists = {};

sublime.ready(function() {
  // A SublimeVideoPlaylist instance can takes some options:
  //  - autoplayOnPageLoad: whether or not to autoplay the playlist on page load. Note that if you set it to true,
  //    you should remove the "sublime" class from the first video in the playlist.
  //  - loadNext: whether or not to load the next item in the playlist once a video playback ends
  //  - autoplayNext: whether or not to autoplay the next item in the playlist once a video playback ends
  //  - loop: whether or not to loop the entire playlist once the last video playback ends
  var playlistOptions = { autoplayOnPageLoad: false, loadNext: true, autoplayNext: true, loop: false };

  // Automatically instantiate all the playlists in the page
  $(".sv_playlist").each(function(i, el) {
    SublimeVideo.playlists[el.id] = new SublimeVideoPlaylist(el.id, playlistOptions);
  });
});