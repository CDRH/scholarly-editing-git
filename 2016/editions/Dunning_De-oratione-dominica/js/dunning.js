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


$( document ).ready(function() {
  $(".highlight_quotes").clicktoggle(
      function () {
          $(this).text("Unhighlight Quotes");
          $(".quote").addClass("highlight");
          $(this).addClass("selected");
          event.preventDefault();

      },
      function () {
          $(this).text("Highlight Quotes");
          $(".quote").removeClass("highlight");
          $(this).removeClass("selected");
          event.preventDefault();
    
      }
  );
}); 



$( document ).ready(function() {
  $(".line_breaks").clicktoggle(
      function () {
          
          $(this).text("Enable Line Breaks");
          $("br").addClass("br_regularized");
          $("br").removeClass("br_diplomatic");
          $(this).addClass("selected");
          $(".tei_lb, .tei_pb_label").hide();
          event.preventDefault();
   
      },
      function () {
          $(this).text("Disable Line Breaks");
          $("br").addClass("br_diplomatic");
          $("br").removeClass("br_regularized");
          $(this).removeClass("selected");
          $(".tei_lb, .tei_pb_label").show();
          event.preventDefault();
     
      }
  );
});

$( document ).ready(function() {
  $(".tei_hand_attr_B").hide();
    $(".handwritten_text").clicktoggle(
        function () {
            
            $(this).text("Hide Handwritten Text");
            $(".tei_hand_attr_B").show();
            $(this).addClass("selected");
            event.preventDefault();
        },
        function () {
            
            $(this).text("Display Handwritten Text");
            $(".tei_hand_attr_B").hide();
            $(this).removeClass("selected");
            event.preventDefault();
      }
  );
}); 


$( document ).ready(function() {
  $("#highlight_quotes_note").hide();
    $("#highlight_quotes_link").clicktoggle(
        function () {
            
            $("#highlight_quotes_note").show();
            $("#line_breaks_note").hide();
            $("#handwritten_text_note").hide();
            event.preventDefault();
        },
        function () {
            $("#highlight_quotes_note").hide();
            event.preventDefault();
        }
  );
});

$( document ).ready(function() {
  $("#line_breaks_note").hide();
    $("#line_breaks_link").clicktoggle(
        function () {
            
            $("#line_breaks_note").show();
            $("#highlight_quotes_note").hide();
            $("#handwritten_text_note").hide();
            event.preventDefault();
        },
        function () {
            
            $("#line_breaks_note").hide();
            event.preventDefault();
      }
    );
});

$( document ).ready(function() {
  $("#handwritten_text_note").hide();
    $("#handwritten_text_link").clicktoggle(
        function () {
            $("#handwritten_text_note").show();
            $("#line_breaks_note").hide();
            $("#highlight_quotes_note").hide();
            event.preventDefault();
        },
        function () {
            $("#handwritten_text_note").hide();
            event.preventDefault();
            
        }
      );
});


