$(function() {
  return $('#user_postcode').jpostal({
    postcode: ['#user_postcode'],
    address: {
      '#user_prefecture_code': '%3',
      '#user_address_city': '%4',
      '#user_address_street': '%5%6%7',
    },
  });
});

$(function() {
  return $('#edit-user_postcode').jpostal({
    postcode: ['#edit-user_postcode'],
    address: {
      '#edit-user_prefecture_code': '%3',
      '#edit-user_address_city': '%4',
      '#edit-user_address_street': '%5%6%7',
    },
  });
});
