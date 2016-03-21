/* */

$(function () {
    //$('span[class="abbr"] span[class="abbr_long"]').attr('style','background-color:yellow;');
    //$('span[class="abbr"] span[class="abbr_short"]').attr('style','background-color:red;');
    $('span[class="abbr"] span[class="abbr_long"]').hide(); 
    $("a.abbrExpanLink").hover(
        function () {
            $('span[class="abbr"]').attr('style','background-color:#ccc;');
        },
        function () {
            $('span[class="abbr"]').removeAttr("style");
        });
    
});


$(function () {
    $("a.abbrExpanLink").toggle(
    function () {
        $('span[class="abbr"] span[class="abbr_long"]').show();
        $('span[class="abbr"] span[class="abbr_short"]').hide();
        $("a.abbrExpanLink div").text("collapse all abbreviations");
    },
    function () {
        $('span[class="abbr"] span[class="abbr_long"]').hide();
        $('span[class="abbr"] span[class="abbr_short"]').show();
        $("a.abbrExpanLink div").text("expand all abbreviations");
    }
);
    
}); 






$(function () {
    $('span[class="avisos_abbrExpan"] span[class="avisos_abbr"]').hide(); 
    $('span[class="avisos_origReg"] span[class="avisos_orig"]').hide(); 
    $('span[class="avisos_sicCorr"] span[class="avisos_sic"]').hide(); 
    $("a.modernizedLink").hover(
        function () {
            $('span[class="avisos_abbrExpan"]').attr('style','border-bottom: 3px solid #ff9900;');
            $('span[class="avisos_origReg"]').attr('style','border-bottom: 3px solid #cc0000;');
            $('span[class="avisos_sicCorr"]').attr('style','border-bottom: 3px solid #66cc66;');
            $('span[class="avisos_supplied_editorial_choice"]').attr('style','color: #1896fb;');
        },
        function () {
            $('span[class="avisos_abbrExpan"]').removeAttr("style");
            $('span[class="avisos_origReg"]').removeAttr("style");
            $('span[class="avisos_sicCorr"]').removeAttr("style");
//            $('span[class="avisos_supplied_editorial_choice"]').removeAttr("style");
        });
    
});

$(function () {
    $("a.modernizedLink").toggle(
    function () {
    	    $('span[class="avisos_expan"]').attr('style','border-bottom: 3px solid #ff9900;');
            $('span[class="avisos_reg"]').attr('style','border-bottom: 3px solid #cc0000;');
            $('span[class="avisos_corr"]').attr('style','border-bottom: 3px solid #66cc66;');
            $('span[class="avisos_supplied_editorial_choice"]').attr('style','color: #1896fb;');
        $("a.modernizedLink div").text("Remove highlights");
        $("a.modernizedKey div").show();
    
       
    },
    function () {
         $('span[class="avisos_abbrExpan"] span[class="avisos_expan"]').show();
        $('span[class="avisos_abbrExpan"] span[class="avisos_abbr"]').hide();
        $('span[class="avisos_origReg"] span[class="avisos_reg"]').show(); 
        $('span[class="avisos_origReg"] span[class="avisos_orig"]').hide(); 
        $('span[class="avisos_sicCorr"] span[class="avisos_corr"]').show();
        $('span[class="avisos_sicCorr"] span[class="avisos_sic"]').hide();
            $('span[class="avisos_expan"]').removeAttr("style");
            $('span[class="avisos_reg"]').removeAttr("style");
            $('span[class="avisos_corr"]').removeAttr("style");
            $('span[class="avisos_supplied_editorial_choice"]').removeAttr("style");
        $("a.modernizedLink div").text("Highlight text that has been modernized");
        $("a.modernizedKey div").hide();    
    }
);
    
}); 



$(function () {
    $('.appEntry').hide();
    /*  $('.rdgNote').hide();*/
    
    $('.showNote').click(function () {
        $(this).next('.appEntry').toggle(); 
    });
});

$(function () {
    $('.viewsize a').lightBox({
        fixedNavigation: true
    });
});

$(function () {
    $('.whitmanheydeviewsize a').lightBox({
        fixedNavigation: true
    });
});

$(function () {
    $('.pageid a').lightBox({
        fixedNavigation: true
    });
});

$(function () {
    $('.enlargeOnClick a').lightBox({
        fixedNavigation: true
    });
});

$(function () {
    $('.thumbnail a').lightBox({
        fixedNavigation: true
    });
});

$(function () {
    $('.whitmanheydethumbnail a').lightBox({
        fixedNavigation: true
    });
});

$(function () {
	$('.closenote').show();
   
    
   $('.closenote').click(function () {
        $(this).parent().hide(); 
        return false;
    });
});