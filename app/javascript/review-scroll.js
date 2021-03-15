$(function(){
  $('#button-review a').on('click', function(event){
    var position = $('#review').offset().top;
    $('body, html').animate({
      scrollTop: position - 140
    }, 800);
    event.preventDefault();
  });
});
