jQuery ->
	$('#pins').imagesLoaded ->
		$('#pins').masonry itemSelector: ".box"	

	$(window).scroll ->
    return if(window.pagination_loading)

    url = $('.pagination .next_page').attr('href')
    if url &&  $(window).scrollTop() > $(document).height() - $(window).height() - 150
      window.pagination_loading = true

      $('.pagination').text('Fetching more products...')
      $.getScript(url).always -> window.pagination_loading = false
  