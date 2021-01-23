$(function() {
  var password = '#password'
  var passcheck = '#password-check'

  $(passcheck).change(function(){
    if ($(this).prop('checked')){
      $(password).attr('type','text');
    } else {
      $(password).attr('type', 'password');
    }
  });
});
