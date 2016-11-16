// Adding/subtracting classes based on ID

$(function () {
  $('#button_highlight').click(function(){
    event.preventDefault();
    $('#sevensins_content').toggleClass('red');
  }); 
}); 

$(function () {
  $('#button_line_breaks').click(function(){
    event.preventDefault();
    $('#sevensins_content').toggleClass('disable_line_breaks');
  }); 
});

//Witness buttons
//tei_wit_Bd
//tei_wit_Tr
//tei_wit_Em
$(function () {
  $('#button_toggle_Bd').click(function(){
    event.preventDefault();
    $('.tei_wit_Bd').toggleClass('hide');
  }); 
});

$(function () {
  $('#button_toggle_Tr').click(function(){
    event.preventDefault();
    $('.tei_wit_Tr').toggleClass('hide');
  }); 
});

$(function () {
  $('#button_toggle_Em').click(function(){
    event.preventDefault();
    $('.tei_wit_Em').toggleClass('hide');
  }); 
});








//Notes as Popover

/*$(function () {
    $('a.edition_notes')
      .on('click',function(e){
        e.preventDefault();
      })
      .popover({
            content: function () {
                var str = $(this).attr('id');
                var res = str.replace("inline", "");
                var path = '#' + res + ' .note_text';
                return '<button type="button" class="popover_close close" onclick="$(&quot;#example&quot;).popover(&quot;hide&quot;);">&times;</button>' + $(path).html() ;
            },
            trigger: 'click',
            animation: false,
            placement: 'auto',
            html: true,
            title: ''
        }).focus();
  }); 
  
 This is not quite working (you have to click twice to get it to show up after you close it) but is the best I have found
 $(document).on("click", ".popover .popover_close" , function(){
        $(this).parents(".popover").popover('hide');
    });*/

//Notes as Modal
/*$(function () {

    $('a.edition_notes').attr( "data-target", ".insert_modal" );
    $('a.edition_notes').attr( "data-toggle", "modal" );
    
    var modalhtml = '<div class="modal fade insert_modal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true"><div class="modal-dialog modal-lg"><div class="modal-content"><div class="modal-body"><button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button><div class="modal-insert"></div></div></div></div></div>'
    
    $('.main_content').append(modalhtml);

});

$(document).on("click", "a.edition_notes", function () {
     var str = $(this).attr('id');
     var res = str.replace("inline", "");
     var path = '#' + res + ' .note_text';
     var notehtml = $(path).html();
     $(".modal-content .modal-insert").html( notehtml );
});*/