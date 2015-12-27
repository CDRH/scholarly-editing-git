/* Dunning side by side
dunning.js is included in html 
*/


/*$(function () {
$(".clicktext").parent().clicktoggle(
    function () {
        event.preventDefault();
        $(this).attr('style','background-color:red;');
            var linkname = $(this).find('a').attr('href').replace('#','');
            var linkname_decoded = decodeURIComponent(linkname);
            $('#' + linkname_decoded).parent().attr('style','background-color:green;');
    },
    function () {
        event.preventDefault();
        $(this).attr('style','background-color:yellow;');
        var linkname = $(this).find('a').attr('href').replace('#','');
            var linkname_decoded = decodeURIComponent(linkname);
            $('#' + linkname_decoded).parent().attr('style','');
    }
);
});*/





/*$(function () {
$(".tei_seg_side").hover(
    function () {
        $(this).children().first().attr('style','background-color:#A3E0D5;');  
    },
    function () {
        $(this).children().first().attr('style','');
    }
);
});*/

$(function () {
$(".tei_seg_side").hover(
    function () {
        $(this).css( 'cursor', 'pointer' );  
    },
    function () {
        $(this).css( 'cursor', 'default' );
    }
);
});


$(function () {
$(".tei_seg_side").clicktoggle(
    function () {
        event.preventDefault();
        event.preventDefault();
        var classname = $(this).children().first().attr('class');
        $('.' + classname).attr('style','background-color:#A3E0D5;');
        
            
    },
    function () {
        event.preventDefault();
        event.preventDefault();
        var classname = $(this).children().first().attr('class');
        $('.' + classname).attr('style','');
    }
);
});


/*$(function () {

$(".clicktext").hide();
    $(".clicktext").parent().hover(
        function () {
            event.preventDefault();
            $(this).attr('style','background-color:#A3E0D5;');
            var linkname = $(this).find('a').attr('href').replace('#','');
            var linkname_decoded = decodeURIComponent(linkname);
            $('#' + linkname_decoded).parent().attr('style','background-color:#A3E0D5;'); 
        },
        function () {
            event.preventDefault();
            $(this).attr('style','');
            var linkname = $(this).find('a').attr('href').replace('#','');
            var linkname_decoded = decodeURIComponent(linkname);
            $('#' + linkname_decoded).parent().attr('style','');
        }
    );
});*/



/*$(function () {



    $(".clicktext").parent().clicktoggle(
        function () {
            event.preventDefault();
            $(this).attr('style','background-color:#A3E0D5;');
            var linkname = $(this).find('a').attr('href').replace('#','');
            var linkname_decoded = decodeURIComponent(linkname);
            $('#' + linkname_decoded).parent().attr('style','background-color:#A3E0D5;');
            
            
        },
        function () {
            event.preventDefault();
            $(this).attr('style','');
            var linkname = $(this).find('a').attr('href').replace('#','');
            var linkname_decoded = decodeURIComponent(linkname);
            $('#' + linkname_decoded).parent().attr('style','');
        }
    );
});*/
