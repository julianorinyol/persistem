$(function(){
  $("tr[data-link].clickable-tr").click(function() {
    window.location = $(this).data("link")
  })
  $("tr[data-link]").on('mouseenter', function() {
    $(this).css({"background":"purple", 'color':'white'});
  })
  $("tr[data-link]").on('mouseleave', function() {
    $(this).css({"background":"white",'color':'black'});
  })
})