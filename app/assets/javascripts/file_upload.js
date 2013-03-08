function handleDragEnter(e) {$('#filesArea').addClass('over');}
function handleDragLeave(e) {$('#filesArea').removeClass('over');}

$(document).ready(function(){
    if (Modernizr.draganddrop) {
      var drop_zone = $('#filesArea');
      drop_zone.bind('dragenter', handleDragEnter);
      drop_zone.bind('dragleave', handleDragLeave);
    }
    
    $('#dropZone').fileupload({
        dataType: 'json',
        url: '/upload',
        type: 'PUT',
        fileInput: $('#inputFile'),
        done: function (e, data) {
            $('#bg_prog_' + data.id).remove();
            $.each(data.result, function (index, file) {
                var file_row_id = 'file_row_'+ file.id;
                var remove_icon_id = 'remove_file_' + file.id;
                
                $('#dropZone').append('<div id="' + file_row_id + '" class="file_line"><div class="thumb"><a class="preview" href="' + file.big_thumb + '" rel="' + file.big_thumb + '"><img src="' + file.thumb + '"/></a></div><div class="desc">' + file.name + ' (' + file.size + ') <input type="hidden" name="deal[files_ids][]" value="' + file.id + '"><a data-method="delete" data-remote="true" href="/remove_upload/' + file.id + '" id=' + remove_icon_id + '><i" class="icon-trash"></i></a></div></div>');
            });
            imagePreview();
        },
        send: function (e, data) {
            var _id = new Date().getTime();
            data.id = _id;
            var el = $('#dropZone').append('<div id="bg_prog_' + _id + '" class="bg-progress"><p></p><div id="fg_prog_' + _id + '" class="fg-progress"></div></div>');
            return true;
        }
    });
    
    $('#dropZone').fileupload().bind('fileuploadstart', function(e){
        $('#submit_btn').attr('disabled','disabled');
    });
    $('#dropZone').fileupload().bind('fileuploadstop', function(e){
        $('#submit_btn').removeAttr('disabled');
        $('#filesArea').removeClass("over");
    });
    $('#dropZone').fileupload().bind('fileuploadprogress', function(e, data){
        $('#bg_prog_' + data.id + ' p').text(data.files[0].name + " - " + parseInt(data.loaded / data.total * 100, 10) + '%');
        $('#fg_prog_' + data.id).css('width', parseInt(data.loaded / data.total * 100, 10) + '%');

    });
    $('#dropZone').fileupload().bind('fileuploadchange', function(e, data){
        
    });
});

this.imagePreview = function(){	
	/* CONFIG */
		
		xOffset = 10;
		yOffset = 30;
		
		// these 2 variable determine popup's distance from the cursor
		// you might want to adjust to get the right result
		
	/* END CONFIG */
	$("a.preview").hover(function(e){
		this.t = this.title;
		this.title = "";	
		var c = (this.t != "") ? "<br/>" + this.t : "";
		$("body").append("<p id='preview'><img src='"+ this.href +"' alt='Image preview' />"+ c +"</p>");								 
		$("#preview")
			.css("top",(e.pageY - xOffset) + "px")
			.css("left",(e.pageX + yOffset) + "px")
			.fadeIn("fast");						
    },
	function(){
		this.title = this.t;	
		$("#preview").remove();
    });	
	$("a.preview").mousemove(function(e){
		$("#preview")
			.css("top",(e.pageY - xOffset) + "px")
			.css("left",(e.pageX + yOffset) + "px");
	});			
};


// starting the script on page load
$(document).ready(function(){
	imagePreview();
});
