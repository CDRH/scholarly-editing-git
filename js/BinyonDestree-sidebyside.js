/* BinyonDestree side by side
dunning.js is included in html 
*/


$(function () {
$(".corresponded").hover(
    function () {
    var classname = $(this).attr('class').replace('tei_s ','#').replace(' ',', #');
        $(this).addClass( 'tei_s_selected' );
    $( classname).addClass( 'tei_s_selected' );
    console.log(classname);
    },
    function () {
    var classname = $(this).attr('class').replace('tei_s ','#').replace(' ',', #');
        $(this).removeClass( 'tei_s_selected' ); 
        $( classname).removeClass( 'tei_s_selected' );
    }
);
});
