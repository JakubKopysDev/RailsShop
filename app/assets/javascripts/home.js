var ready = function() {
  $('#search').autocomplete({
    serviceUrl: '/autocomplete',
    dataType: 'json',
    transformResult: function(response) {
        return {
          suggestions: $.map(response, function(item) {
            return { value: item.value, data: item.data };
          })
        }
    }
  });
};

$(document).ready(ready);
$(document).on('turbolinks:load', ready);
