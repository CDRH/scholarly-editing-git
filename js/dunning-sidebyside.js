



$(function () {

//var s = $(".clicktext a").attr('href').replace('#','');
//console.log(s);
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
});



$(function () {

//var s = $(".clicktext a").attr('href').replace('#','');
//console.log(s);

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
});
