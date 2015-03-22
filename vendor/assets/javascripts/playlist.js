// =============== Custom Events =============== //

var teeboxPlaylist = getNamespace('Teebox.playList');

teeboxPlaylist.videoWrapper = function(){
	return '.sv_playlist';
}
teeboxPlaylist.playButton = function(){
	return $(teeboxPlaylist.videoWrapper() + ' button#play');	
}
teeboxPlaylist.setPlayerControlState = function(state) {
	var validStates = ['play', 'pause'];
	if(validStates.indexOf(state) > -1 ) {
		teeboxPlaylist.playButton().attr('data-state', state);
		if(state == 'play') {
			teeboxPlaylist.playButton().removeClass('active');
		} else {
			teeboxPlaylist.playButton().addClass('active');
		}
	} else {
		throw 'teeboxPlaylistError: Note a valid playlist state: ' + state;
	}
}
teeboxPlaylist.playPauseVideoHandler = function(playlistWrapperId){
	teeboxPlaylist.playButton().on('click', function(event){
		event.preventDefault();
		var activeVideo = $("#" + playlistWrapperId + " .video_wrap.active video")[0];
		
		var button = $(this);
		var state = button.attr('data-state');
		
		sublime.prepare(activeVideo, function(player){
			player[state]();
		});
		
		var newState = teeboxPlaylist.getPlayermMethodAndState(state);
		teeboxPlaylist.setPlayerControlState(newState);
	});
}
teeboxPlaylist.setPlayerSpeed = function(playlistWrapperId) {
	$('button.slow-mo').on('click', function(){
		var activeVideo = $("#" + playlistWrapperId + " .video_wrap.active video")[0];
		var speed = $(this).data('speed');
	
		$('button.slow-mo').removeClass('active');
		$(this).addClass('active');
		$(this).blur();
		
		activeVideo.playbackRate = speed || 1;
	});
}
teeboxPlaylist.getPlayermMethodAndState = function(state){
	var method;
	
	if(state === 'pause') {
		method = 'play';
	} else if(state === 'play') {
		method = 'pause';
	} else {
		throw 'teeboxPlaylist: Invalid state: ' + state; 
	}
	return method;
}

function getNamespace(namespace) {
    if (namespace.match(/[^a-zA-Z0-9_\.]/)) {
        throw new Error('Failed to define namespace. Namespace is invalid.');
    }
    var components = namespace.split('.');
    var namespace = window;
    for (var n = 0, nn = components.length; n < nn; n++) {
        var component = components[n];
        namespace = namespace[component] = namespace[component] || {};
    }
    return namespace;
}

// ======= End of custom events ===== //

var SublimeVideoPlaylist = function(playlistWrapperId, options){
	if (!$("#" + playlistWrapperId)) return;

	this.options = options;
	this.playlistWrapperId = playlistWrapperId;
	this.firstVideoId = $("#" + this.playlistWrapperId + " video").attr("id");

	this.setupObservers();
	this.updateActiveVideo(this.firstVideoId);
	this.clickOnThumbnail(this.activeVideoId, this.options["autoplayOnPageLoad"]);

	// Custom events
	teeboxPlaylist.playPauseVideoHandler(playlistWrapperId);
	teeboxPlaylist.setPlayerSpeed(playlistWrapperId);
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
	$('button.slow-mo').removeClass('active');

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
	teeboxPlaylist.setPlayerControlState('pause');
  },
  onVideoPlay: function(player) {
	teeboxPlaylist.setPlayerControlState('pause');
  },
  onVideoPause: function(player) {
	teeboxPlaylist.setPlayerControlState('play');
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
      else { 
		player.stop(); 
	  }
    }
	$('button.slow-mo').removeClass('active');
	teeboxPlaylist.setPlayerControlState('play');
  },
  onVideoStop: function(player) {
	teeboxPlaylist.setPlayerControlState('play');
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
  var playlistOptions = { autoplayOnPageLoad: false, loadNext: true, autoplayNext: false, loop: false };

  // Automatically instantiate all the playlists in the page
  $(teeboxPlaylist.videoWrapper()).each(function(i, el) {
    SublimeVideo.playlists[el.id] = new SublimeVideoPlaylist(el.id, playlistOptions);
  });
});