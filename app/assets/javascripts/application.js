// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require select2-full
//= require jquery.barrating.min.js
//= require turbolinks
//= require_tree .

$(document).ready(function() {
  enableBootstrapTooltips();

  var $alerts = $('#alerts');
  if ($alerts.length) {
      centerAbsoluteElement($alerts);
      hideAlertAfterDelay($alerts, 5000);
  }
});

function enableBootstrapTooltips() {
  $('[data-toggle="tooltip"]').tooltip();
}

function centerAbsoluteElement(element) {
    var width = element.css('width');
    var height = element.css('height');

    width = width.replace('px', '');
    height = height.replace('px', '');

    element.css('left', ($(window).width() / 2) - (width / 2));
    element.css('top', ($(window).height() / 6) - (height / 2));
}

function hideAlertAfterDelay(element, delay) {
    element.delay(delay).fadeOut(200, function() {
        $(this).alert('close');
    });
}

$(document).on('click', '.profile .panel-heading.clickable', function(e) {
  var $panel = $(this).closest('.panel');
  togglePanel($panel);
});

function togglePanel(panel) {
  if (!panel.hasClass('panel-collapsed')) {
    hidePanel(panel);
  } else {
    showPanel(panel);
  }
}

function hidePanel(panel) {
  panel.find('.panel-body').slideUp();
  panel.addClass('panel-collapsed');
  panel.find('i').removeClass('fa-chevron-up').addClass('fa-chevron-down');
}

function showPanel(panel) {
  panel.find('.panel-body').slideDown();
  panel.removeClass('panel-collapsed');
  panel.find('i').removeClass('fa-chevron-down').addClass('fa-chevron-up');
}
