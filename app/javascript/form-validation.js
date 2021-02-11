$(function() {
  $("#signup-form").validationEngine('attach', {
    promptPosition: "bottomLeft", scrollOffset: 140
  });
});

$(function() {
  $("#login-form").validationEngine('attach', {
    promptPosition: "bottomLeft", scrollOffset: 140
  });
});

$(function() {
  $("#edit-form").validationEngine('attach', {
    promptPosition: "bottomLeft", scrollOffset: 140
  });
});

$(function() {
  $('#password-reset-form').validationEngine('attach', {
    promptPosition: "bottomLeft", scrollOffset: 140
  });
});

