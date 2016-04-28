/* Dunning */

/* Function to replicate the old jquery toggle behaviour */
$.fn.clicktoggle = function(a, b) {
    return this.each(function() {
        var clicked = false;
        $(this).bind("click", function() {
            if (clicked) {
                clicked = false;
                return b.apply(this, arguments);
            }
            clicked = true;
            return a.apply(this, arguments);
        });
    });
};

/*$(function () {
$("#dunning_controls_expan").text("Hide Editorial Expansions");
    $("#dunning_controls_expan").clicktoggle(
        function () {
            $(this).text("Show Editorial Expansions");
            $(".tei_ex").hide();
        },
        function () {
            $(this).text("Hide Editorial Expansions");
            $(".tei_ex").show();
        }
    );
});*/

$(function () {
$(".highlight_quotes").clicktoggle(
    function () {
        event.preventDefault();
        $(this).text("Unhighlight Quotes");
        $(".quote").addClass("highlight");
        $(this).addClass("selected");
    },
    function () {
        event.preventDefault();
        $(this).text("Highlight Quotes");
        $(".quote").removeClass("highlight");
        $(this).removeClass("selected");
    }
);
}); 



$(function () {
    $(".line_breaks").clicktoggle(
        function () {
            event.preventDefault();
            $(this).text("Enable Line Breaks");
            $("br").addClass("br_regularized");
            $("br").removeClass("br_diplomatic");
            $(this).addClass("selected");
            $(".tei_lb, .tei_pb_label").hide();
        },
        function () {
            event.preventDefault();
            $(this).text("Disable Line Breaks");
            $("br").addClass("br_diplomatic");
            $("br").removeClass("br_regularized");
            $(this).removeClass("selected");
            $(".tei_lb, .tei_pb_label").show();
        }
    );
});

$(function () {
$(".tei_hand_attr_B").hide();
$(".handwritten_text").clicktoggle(
    function () {
        event.preventDefault();
        $(this).text("Hide Handwritten Text");
        $(".tei_hand_attr_B").show();
        $(this).addClass("selected");
    },
    function () {
        event.preventDefault();
        $(this).text("Display Handwritten Text");
        $(".tei_hand_attr_B").hide();
        $(this).removeClass("selected");
    }
);
}); 

$(function () {
$("#highlight_quotes_note").hide();
$("#highlight_quotes_link").clicktoggle(
    function () {
        event.preventDefault();
        $("#highlight_quotes_note").show();
        $("#line_breaks_note").hide();
        $("#handwritten_text_note").hide();
    },
    function () {
        event.preventDefault();
        $("#highlight_quotes_note").hide();
    }
    );
});

$(function () {
$("#line_breaks_note").hide();
$("#line_breaks_link").clicktoggle(
    function () {
        event.preventDefault();
        $("#line_breaks_note").show();
        $("#highlight_quotes_note").hide();
        $("#handwritten_text_note").hide();
    },
    function () {
        event.preventDefault();
        $("#line_breaks_note").hide();
    }
    );
});

$(function () {
$("#handwritten_text_note").hide();
$("#handwritten_text_link").clicktoggle(
    function () {
        event.preventDefault();
        $("#handwritten_text_note").show();
        $("#line_breaks_note").hide();
        $("#highlight_quotes_note").hide();
    },
    function () {
        event.preventDefault();
        $("#handwritten_text_note").hide();
        
    }
    );
});



/*$(function () {
    $(".translation_links").clicktoggle(
        function () {
            event.preventDefault();
            
            $(this).text("Show Translation Links");
            $(".tei_seg").removeClass('tei_seg').addClass('tei_seg_off');
            $(".orig_trans_link").hide();
            $(".translation_links").addClass("selected");
        },
        function () {
            event.preventDefault();
             $(this).text("Hide Translation Links");
            $(".tei_seg_off").addClass('tei_seg').removeClass('tei_seg_off');
            $(".orig_trans_link").show();
            $(".translation_links").removeClass("selected");
        }
    );
});*/
