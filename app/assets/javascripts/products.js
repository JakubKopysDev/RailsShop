function ready() {
  $('#review_rating').barrating({
    theme: 'fontawesome-stars',
    hoverState: true
  });

  $('.review-rate').barrating({
    theme: 'fontawesome-stars-o',
    readonly: true
  });

  $('.avg-rating').barrating({
    theme: 'fontawesome-stars-o',
    readonly: true,
    initialRating: $('.avg-rating').data('rating-cache')
  })
}

$(document).ready(ready);
$(document).on('turbolinks:load', ready);
