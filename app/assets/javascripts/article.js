$(document).ready(function(){
	if ($('form #article_cover_image').length) {
		var iframeBody = $('iframe.wysihtml5-sandbox').contents().find('body');
		var cover_image_input = $('form #article_cover_image');
		
		$('#article_preview').on('click', function(event) {
			event.preventDefault();
			var articlepreviewModal = $('#article_preview_modal');
			var articleHtml = $(iframeBody).clone();
			var articleTitle = $("form [name='article[title]']").val();
			
			//articlepreviewModal.find('.modal-body .title').html(articleTitle);
			articlepreviewModal.find('.modal-body .body').html(articleHtml);
			articlepreviewModal.find('.modal-header h3').html('Previewing: ' + articleTitle);
			articlepreviewModal.modal('show');
		});
		
		var displaySelectedText = function(text) {
			$('span#selected_article_image').html(text);
		}
		
		var addCheckedIcon = function(element){
			var icon = $("<i class='icon-ok-sign selected-article-icon'></i>");
			element.prepend(icon);
		}
		
		var removeCheckedIcons = function(parent){
			parent.find('i').remove();
		}
		
		var updateSelectedAndInput = function(images) {
			if (images.length == 0) {
				cover_image_input.val('');
				displaySelectedText('Nothing');	
			}
		}
		
		var findImages = function(){
			var images = iframeBody.find('img');
			
			images.css('max-width', '100%');
			updateSelectedAndInput(images);
			$('span#images_count').html(images.length);
			$('div#article_images').html('');

			images.each(function() {
				var selectableImg = $(this).clone();
				var parentDiv = $('div#article_images');
				var div = $("<div class='selectable_image col-md-6 col-sm-6 col-xs-6'></div>");
				
				div.append(selectableImg);
				parentDiv.append(div);

				if(cover_image_input.val() === this.src) {
					selectableImg.toggleClass('selected-img');
					displaySelectedText(this.src.split('/').pop());
					addCheckedIcon(div);
				}
				
				$(this).on('click', function(event){
					event.preventDefault();
				});

				selectableImg.on('click', function(){
					cover_image_input.val(this.src);
					$('.selectable_image img').removeClass('selected-img');
					$(this).toggleClass('selected-img');
					displaySelectedText(this.src.split('/').pop());
					removeCheckedIcons(parentDiv);
					addCheckedIcon(div);
				});
			});
		}

		setTimeout(function(){
			findImages();
		}, 500);

		iframeBody.bind("DOMSubtreeModified", function() {
			findImages();
	    });
	}
});