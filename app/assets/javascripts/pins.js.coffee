jQuery ->
  $("#pins").imagesLoaded -> 
  	$('#pins').masonry itemSelector: ".box"  

  if $(".pagination").length
    $(window).scroll ->
      url = $(".pagination .next a").attr("href")
      if url and $(window).scrollTop() > $(document).height() - $(window).height() - 50
        $(".pagination").text "Fetching more images..."
        $.getScript url

  $(window).scroll()