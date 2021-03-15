$(function(){
  Payjp.setPublicKey(gon.payjpPublicKey);
  $("#token_submit").on('click', function(event){
    event.preventDefault();
    let card = {
      number: $('#card_number').val(),
      cvc: $('#cvc').val(),
      exp_month: $('#exp_month').val(),
      exp_year: $('#exp_year').val()
    };

    Payjp.createToken(card, function(status, response) {
      if (response.error) {
        $('#token_submit').prop('disabled', false);
        alert('カード情報が正しくありません。');
      }
      else {
        $('#card_number').removeAttr('name');
        $('#cvc').removeAttr('name');
        $('#exp_month').removeAttr('name');
        $('#exp_year').removeAttr('name');

        let token = response.id;
        $('#card-form').append(`<input type="hidden" name="payjpToken" value=${token}>`);
        $('#card-form').get(0).submit();
      }
    });
  })
});
