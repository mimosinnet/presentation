/** Auto-fit Image {{{ */
function set_body_height()
{
	    var wh = $(window).height();
	    $('body').attr('style', 'height:' + wh + 'px;');
}
$(document).ready(function() {
	    set_body_height();
	    $(window).bind('resize', function() { set_body_height(); });
});

/** }}} */
