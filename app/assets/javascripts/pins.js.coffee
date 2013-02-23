jQuery ->
	$('#pins').imagesLoaded ->
		$('#pins').masonry itemSelector: ".box"	

	jQuery ->
  if $('.pagination').length
    $(window).scroll ->
      url = $('.pagination .next_page').attr('href')
      if url &&  $(window).scrollTop() > $(document).height() - $(window).height() - 30
        $('.pagination').text('Fetching more images...')
        $.getScript(url)
    $(window).scroll()