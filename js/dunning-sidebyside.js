

$(function () {

//var s = $(".clicktext a").attr('href').replace('#','');
//console.log(s);

    $(".clicktext").clicktoggle(
        function () {
            event.preventDefault();
            $(this).parent().attr('style','background-color:yellow;');
            var linkname = $(this).find('a').attr('href').replace('#','');
            var linkname_decoded = decodeURIComponent(linkname);
            $('#' + linkname_decoded).parent().attr('style','background-color:yellow;');
            
            
        },
        function () {
            event.preventDefault();
            $(this).parent().attr('style','');
            var linkname = $(this).find('a').attr('href').replace('#','');
            var linkname_decoded = decodeURIComponent(linkname);
            $('#' + linkname_decoded).parent().attr('style','');
        }
    );
});
