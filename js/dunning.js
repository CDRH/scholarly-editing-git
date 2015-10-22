/* Dunning */

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

$(function () {
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
});

$(function () {
$("#dunning_controls_quote").text("Highlight Quotes");
    $("#dunning_controls_quote").clicktoggle(
        function () {
            $(this).text("Unhighlight Quotes");
            $(".quote").addClass("highlight");
        },
        function () {
            $(this).text("Highlight Quotes");
            $(".quote").removeClass("highlight");
        }
    );
}); 

$(function () {
$("#dunning_controls_breaks").text("Disable Line Breaks");
    $("#dunning_controls_breaks").clicktoggle(
        function () {
            $(this).text("Enable Line Breaks");
            $("br").hide();
        },
        function () {
            $(this).text("Disable Line Breaks");
            $("br").show();
        }
    );
});
