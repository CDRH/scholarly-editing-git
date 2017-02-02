
// Code from http://jsfiddle.net/erik1337/ZBp2U/
// Not sure why the above works but my version 
// requires an extra click to ope another popover

// POPOVER TOGGLES

$(document).ready(function(){
    var $elements = $('[data-toggle="popover"]');
    $elements.each(function () {
        var $element = $(this);
        
        $element.popover({
            html: true,
            placement: 'right',
            container: $('body'), // This is just so the btn-group doesn't get messed up... also makes sorting the z-index issue easier
            content: function() {
                var button = '<button type="button" class="close close-button"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button>'
                var middle = $(this).next('.popper-content').html();
                return button + middle
            }
        });
        
        $element.on('shown.bs.popover', function () {
            var popover = $element.data('bs.popover');
            if (typeof popover !== "undefined") {
                var $tip = popover.tip();
                zindex = $tip.css('z-index');
                
                $tip.find('.close').bind('click', function () {
                    popover.hide();
                });
                
                $tip.mouseover(function () {
                    $tip.css('z-index', function () {
                        return zindex + 1;
                    });
                })
                    .mouseout(function () {
                    $tip.css('z-index', function () {
                        return zindex;
                    });
                });
            }
        });
    });
});



$(function () {
  $('#button_line_breaks').click(function(event){
    event.preventDefault();
    $('#sevensins_content').toggleClass('disable_line_breaks');
    $("#controls_sevensins").toggleClass("disable_line_breaks");
  }); 
});

$(function () {
  $('#button_editorial_marks').click(function(event){
    event.preventDefault();
    $('#sevensins_content').toggleClass('show_editorial_marks');
    $("#controls_sevensins").toggleClass("show_editorial_marks");
  }); 
});

$(function () {
  $('#button_toggle_Bd').click(function(event){
    event.preventDefault();
    $('.tei_wit_Bd').toggleClass('hide');
  }); 
});

$(function () {
  $('#button_toggle_Tr').click(function(event){
    event.preventDefault();
    $('.tei_wit_Tr').toggleClass('hide');
  }); 
});

$(function () {
  $('#button_toggle_Em').click(function(event){
    event.preventDefault();
    $('.tei_wit_Em').toggleClass('hide');
  }); 
});


$(function () {
  $('#button_regularize').click(function(event){
    event.preventDefault();
    $("#sevensins_content").addClass("regularized");
    $("#controls_sevensins").addClass("regularized");
  }); 
});

$(function () {
  $('#button_diplomatic').click(function(event){
    event.preventDefault();
    $("#sevensins_content").removeClass("regularized");
    $("#controls_sevensins").removeClass("regularized");
  }); 
});
