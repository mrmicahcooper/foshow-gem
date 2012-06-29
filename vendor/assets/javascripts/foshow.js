$(function(){
  $('div#code nav a').click(function(){
    var link = $(this), link_text = link.html();
    if (link_text == 'all'){
      $('div#code div').css('display','block')
    }
    else{
      $('div#code > div').css('display','none');
      $('div.'+ link_text).css('display','block');
    }
  })
})
