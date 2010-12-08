// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(function() {
  $(".asset-summary").hover(
    function() {
      $(this).css("-webkit-transform", "scale(1.05)");
      $(this).css("-moz-transform", "scale(1.05)");
    },

    function() {
      $(this).css("-webkit-transform", "scale(1)");
      $(this).css("-moz-transform", "scale(1)");
    }
  );
});
