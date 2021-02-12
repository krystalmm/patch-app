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

$(function() {
  var password = '#password_confirmation'
  var passcheck = '#password_confirmation-check'

  $(passcheck).change(function(){
    if ($(this).prop('checked')) {
      $(password).attr('type', 'text');
    } else {
      $(password).attr('type', 'password');
    }
  });
});

$(function() {
  var password = '#login-password'
  var passcheck = '#login-password-check'

  $(passcheck).change(function(){
    if ($(this).prop('checked')) {
      $(password).attr('type', 'text');
    } else {
      $(password).attr('type', 'password');
    }
  });
});

$(function() {
  var password = '#password-reset-edit'
  var passcheck = '#password-reset-check'

  $(passcheck).change(function(){
    if ($(this).prop('checked')) {
      $(password).attr('type', 'text');
    } else {
      $(password).attr('type', 'password');
    }
  });
});

$(function() {
  var password = '#password_confirmation-reset-edit'
  var passcheck = '#password_confirmation-reset-check'

  $(passcheck).change(function(){
    if ($(this).prop('checked')) {
      $(password).attr('type', 'text');
    } else {
      $(password).attr('type', 'password');
    }
  });
});
