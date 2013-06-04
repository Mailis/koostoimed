// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require_tree .
 
/*
$(function() {
     //Convenience for forms or links that return HTML from a remote ajax call.
     //The returned markup will be inserted into the element id specified.
    $('form[data-update-target]').on('ajax:success', function(evt, data) {
        //var target = $(this).data('update-target');
        console.log("UPS!");
        $('div#update-container').html(data);
        
    });
});
*/



$(function() { 
    
   $('input').keyup(function() { 
     $ident= $(this).attr('id');
     if($ident != "atcs") $('#atcs').val("");
     if($ident != "est") $('#est').val("");
     if($ident != "eng") $('#eng').val("");
     $otsi = $(this).val()
     search_by_id($ident, $otsi);
   })      

    
   function search_by_id(ident, otsi){
       if(otsi != ""){
        $('table.soovitabel').css("display","block");
        $.get('/home/soovita', {inserted: otsi, ident: ident}, function(data) { 
             $('#update-atc').html(data); 
        });
      }
      else{
        $('table.soovitabel').css("display","none");
      }
   }

});

$( document ).ready(function() {
    
    
    $(document).on("click", "tr", function() {
        var tds = $(this).find("td");
        $('#atcs').val(tds[0].innerHTML);
        $('#est').val(tds[1].innerHTML);
        $('#eng').val(tds[2].innerHTML); 
        $('table.soovitabel').toggle();
    });
    
    $(document).on("mouseover", "tr", function() {
        $(this).effect( "highlight" , 2000);
    });

 $(document).on("click", '#btn_kuvakoostoime',function() {
    $('#update-atc').html('<img src="/assets/loading.gif" />'); 
      otsi = $('#atcs').val()
      window.location.href = otsi;
    });

    $(document).on("click", '#btn_kuvakoostoimed',function() {
    $('#update-atc').html('<img src="/assets/loading.gif" />'); 
      otsi = $('#atcs').val()
      $.get('/home/kuva', {atc: otsi}, function(data) { 
             $('#update-atc').html(data); 
        })
    });
    
    $(document).on("click", 'div.pdf_pealkiri',function() {
      $muu = $(this).next('div.muu'); 
      $muu.slideToggle(); 
    });
});     


