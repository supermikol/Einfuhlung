$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()
  $('#navbar').on('click', 'a', function(event){
    event.preventDefault();
    link = $(this).attr('href');
    $.ajax({
      method: 'GET',
      url: link
    }).done(function(response){
      $('.starter-template').html(response);
    });

  });

  $('#welcomeLogin').on('click','a',function(e){
    e.preventDefault();
    link = $(this).attr('href');
    $.ajax({
      method: 'GET',
      url: link
    }).done(function(response){
      $('.starter-template').html(response);
    });
  })

});
