$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()
  $('#navbar li').on('click', 'a', function(event){
    event.preventDefault();
    link = $(this).attr('href');
    $.ajax({
      method: 'GET',
      url: link
    }).done(function(response){
      $('.starter-template').html(response);
      inboxListener();
      $(event.target).parent().siblings().removeClass('active');
      $(event.target).parent().addClass('active');

    });

  });

  // $('#welcomeLogin').on('click','a',function(e){
  //   e.preventDefault();
  //   link = $(this).attr('href');
  //   $.ajax({
  //     method: 'GET',
  //     url: link
  //   }).done(function(response){
  //     $('.starter-template').html(response);
  //   });
  // })



});

inboxListener =  function(){
  $('.conversation-wrap').on('click', 'a', function(e){
    e.preventDefault();
    link = $(this).attr('href');
    $.ajax({
      method: 'GET',
      url: link
    }).done(function(response){
      $('#thread-wrap').html(response);
      chatboxListener();
    })
  })
}

chatboxListener = function(){
  $('form').on('submit', function(event){
    event.preventDefault();
    var link = $(this).attr('action');
    var text_data = $(this).serialize();
    $.ajax({
      method: 'POST',
      url: link,
      data: text_data
    }).done(function(response){
      $('#thread-wrap').html(response);
      chatboxListener();
    })
  })

}