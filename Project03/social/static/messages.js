$('p[contenteditable]').keydown(function(e) {
	// trap the return key being pressed
	if (e.keyCode === 13) {
	// insert 2 br tags (if only one br tag is inserted the cursor won't go to the next line)
		document.execCommand('insertHTML', false);
		// prevent the default behaviour of return key pressed
		return false;
	}
});



/* ********************************************************************************************
   | Handle Submitting Posts - called by $('#post-button').click(submitPost)
   ********************************************************************************************
   */

	// COMPLETE Objective 8: send contents of post-text via AJAX Post to post_submit_view (reload page upon success)

function postResponse(data, status) {
	if (status == 'success') {
		location.reload();
        }                                                                                                       else {                                                                                                      alert('failed to accept or decline request ' + status);
        }
}

function submitPost(event) {
	let postContent = document.getElementById("post_text").innerHTML;
	let json_data = { 'postContent' : postContent };
	let url_path = post_submit_url;
	
	$.post(url_path,
		json_data,
            	postResponse);
}

/* ********************************************************************************************
   | Handle Liking Posts - called by $('.like-button').click(submitLike)
   ********************************************************************************************
   */
function submitLikeResponse(data, status) {
	if (status == 'success') {
		location.reload()
	}
	else {
		alert('failed to like the post ' + status);
	}
}

function submitLike(event) {
    // COMPLETE Objective 10: send post-n id via AJAX POST to like_view (reload page upon success)
	let postID = event.target.id;
	let json_data = { 'postID' : postID };
	let url_path = like_post_url;

	$.post(url_path,
		json_data,
		submitLikeResponse);
}

/* ********************************************************************************************
   | Handle Requesting More Posts - called by $('#more-button').click(submitMore)
   ********************************************************************************************
   */
function moreResponse(data,status) {
    if (status == 'success') {
        // reload page to display new Post
        location.reload();
    }
    else {
        alert('failed to request more posts' + status);
    }
}

function submitMore(event) {
    // submit empty data
    let json_data = { };
    // globally defined in messages.djhtml using i{% url 'social:more_post_view' %}
    let url_path = more_post_url;

    // AJAX post
    $.post(url_path,
           json_data,
           moreResponse);
}

/* ********************************************************************************************
   | Document Ready (Only Execute After Document Has Been Loaded)
   ********************************************************************************************
   */
$(document).ready(function() {
    // handle post submission
    $('#post-button').click(submitPost);
    // handle likes
    $('.like-button').click(submitLike);
    // handle more posts
    $('#more-button').click(submitMore);
});
