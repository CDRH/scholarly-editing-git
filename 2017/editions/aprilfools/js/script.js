
// from https://datatables.net/
$(document).ready(function() {
    $('.table-sortable').DataTable( {
        // "lengthMenu": [[25,50,-1], [25, 50,"All"]]
        paging: false
    } );
} );

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
    $('.aprilfools_tei_thumbnail a').lightBox({
        fixedNavigation: true
    });
});