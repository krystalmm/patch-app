$(function(){
  const quantity = document.getElementById('quantity-text')
  const stock = $('#stock').text();

  $('#down').on('click', function(event){
    if(quantity.value > 0) {
      quantity.value--;
    }
  });

  $('#up').on('click', function(event){
    if(stock > quantity.value) {
      quantity.value++;
    }
  });
});
