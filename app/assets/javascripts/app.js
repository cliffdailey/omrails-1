$(function() {
	
	$(window).on('scroll', function(){
		if( $(window).scrollTop()  < 500 ) {			
			$('#back_to_top img').addClass('no_display');
		} 
		else {
			$('#back_to_top img').removeClass('no_display');				
		}
	});
	
});