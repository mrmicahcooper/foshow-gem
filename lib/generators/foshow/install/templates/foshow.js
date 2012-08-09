$(function(){
  $('section#code_viewer nav a').click(function(e){
    e.preventDefault();
    var link = $(this), link_text = link.html();
    if (link_text == 'all'){
      $('section#code_viewer div').css('display','block')
    }
    else{
      $('section#code_viewer > div').css('display','none');
      $('div.'+ link_text).css('display','block');
    }
  })
})
