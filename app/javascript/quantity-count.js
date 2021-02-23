$(function(){
  const quantity = document.getElementById('quantity-text')

  $('#down').on('click', function(event){
    if(quantity.value > 1) {
      quantity.value--;
    }
  });

  $('#up').on('click', function(event){
    quantity.value++;
  });
});