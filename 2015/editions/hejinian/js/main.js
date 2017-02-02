var tmp;

var w = 1200;
var h = 600;

var set1Color = "#7EA43C";
var set2Color = "#EF3439";
var bgColor = "#ededed";
var strokeColor = "#ccc";
var hoverColor = "#111";
var activeColor = "#00B5E5";
var inactiveColor = "#888";

var mode = "default";

var set1Length = 1369;
var set2Length = 2025;

var set1Sections = 37;
var set2Sections = 45;

var labelGI = "Green Integer";
var labelBD = "Burning Deck";

var sectionHeight = h / set2Sections;
var sentenceWidth = 8;

var defaultOpacity = .6;

var svg = d3.select("#viz")
	.append("svg")
	.attr("width",w)
	.attr("height", h);

var text = d3.select('#text');

var rowCount = -1;
var rowCount2 = -1;
var xOffset = 0;
var yOffset = 0;
var sectionCount = 0;
var currentSection = 1
var firstSentence = true;
var currentSentence = -1;
var currentRelation;
var currentMatch;
var maxStrength = 0;
var minStrength = 999;

var patternScale = d3.scale.linear();
var opacityScale2 = d3.scale.linear().domain([0,1]).range([.2,1]);

//Load relation data
var relations = new Array();
var currentRelations = new Array();
d3.csv('hejinian/data/sentences_relations.csv', function(d) {
	relations = d;
	processSentences();
});

var a = 0;
var b = 0;

//Loop through sentence data

function processSentences() {
d3.csv("hejinian/data/sentences_compiled.csv", function(sentences) {
	
	var toc = svg.selectAll("rect")
	    .data(sentences)
		.enter()
		.append("rect")	
		.attr("data-version", function(d,i) {
			if (i > set1Length - 1) {
				return "gi";
			} else {
				return "bd";
			}
		})
		.attr("data-section", function(d,i) {
			if (i == set1Length) {
				currentSection = 1;
				sectionCount = 0;
			}
			if (i > set1Length - 1) {
				if (sectionCount > 44) {
					currentSection++;
					sectionCount = 1;
				} else {
					sectionCount++;
				}
				return currentSection;			
			} else {
				if (sectionCount > 36) {
					currentSection++;
					sectionCount = 1;
				} else {
					sectionCount++;
				}
				return currentSection;
			}			
		})	
		.attr("x", function(d,i) {		
			if (i > set1Length - 1) {
				if (rowCount > set2Sections - 2) {
					xOffset = 0;
					rowCount = 0;
				} else {
					xOffset += sentenceWidth;
					rowCount++;
				}
			} else {
				if (rowCount > set1Sections - 2) {
					xOffset = 0;
					rowCount = 0;
				} else {
					if (firstSentence) {
						rowCount++;				
						firstSentence = false;		
					} else {
						rowCount++;
						xOffset += sentenceWidth;
					}
				}
			}
			if (i == set1Length) {
				xOffset = 0;
				rowCount = 0;
			}
			if (i > set1Length - 1) {
				return w - (sentenceWidth * set2Sections) + xOffset - 4;
			} else {
				return xOffset + 4;
			}
		})
		.attr("y", function(d, i) {
			if (i > set1Length - 1) {
				if (rowCount2 > set2Sections - 2) {
					yOffset += sectionHeight;
					rowCount2 = 0;
				} else {
					rowCount2++;
				}
			} else {
				if (rowCount2 > set1Sections - 2) {
					yOffset += sectionHeight;
					rowCount2 = 0;
				} else {
					rowCount2++;
				}
			}
			if (i == set1Length) {
				yOffset = 0;
				rowCount2 = 0;
			}
			return yOffset;		
		})		
		.attr("width", sentenceWidth)
		.attr("height", sectionHeight)
		.attr("opacity", defaultOpacity)
		.attr("stroke", strokeColor)
		.attr("id", function(d, i) {
			return "sentence-" + i;
		})
		.attr("data-difference", 0)
		
		.on("mouseover", function() {
			if (mode == "default") {
				if (d3.select(this).attr("data-class") != "active") {
					d3.select(this).attr("opacity", .4).attr("fill", activeColor);		
				}
			}
			else if (mode == "diff" || mode == "patterns") {
				if (d3.select(this).attr("data-class") != "active") {
					d3.select(this).attr("opacity", .6).attr("fill", activeColor)			
				}
			}
		})
		
		.on("mouseout", function() {
			if (mode == "default") {
				if (d3.select(this).attr("data-class") != "active") {
					d3.select(this).attr("opacity", defaultOpacity)	
						.attr("fill", function() {
								var version = d3.select(this).attr("data-version");
								if (version == "gi") {
									return set1Color;
								} else {
									return set2Color;
								}
							});		
				}
			} else if (mode == "diff") {
				if (d3.select(this).attr("data-class") != "active") {
					d3.select(this).attr("opacity", function() {
						var diff = d3.select(this).attr("data-difference");
						if (diff < 2) {
							return opacityScale2(2 - diff);
						} else {
							return 1;
						}
					}).attr("fill", function() {
						var diff = d3.select(this).attr("data-difference");
						var version = d3.select(this).attr("data-version");
						if (diff < 2) {
							if (version == "gi") {
								return set1Color;
							} else {
								return set2Color;
							}
						} else {
							return bgColor;
						}
					});	
				}//if not active
			}//if diff mode
			else if (mode == "patterns") {
				if (d3.select(this).attr("data-class") != "active") {
					d3.select(this).attr("opacity", function() {
						var diff = d3.select(this).attr("data-difference");
						if (diff > 5) {
							return patternScale(diff);
						} else {
							return 1;
						}
					}).attr("fill", function() {
						var diff = d3.select(this).attr("data-difference");
						var version = d3.select(this).attr("data-version");
						if (diff > 5) {
							if (version == "gi") {
								return set1Color;
							} else {
								return set2Color;
							}
						} else {
							return bgColor;
						}
					});	
				}//if not active
			}//if diff mode			
		})		

		.on("click", function(d, i) {

			//remove original text
			/*
			d3.select("#text-original")
				.remove();
			*/

			//show text
			text.selectAll("p")
				.remove();

			text.append("p")
				.attr("class", function() {
					if (i > set1Length - 1) {
						return "gi";
					} else {
						return "bd";
					}
				})
				.html(function() {
					if (i > set1Length - 1) {
						var section = Math.floor(((i - set1Length) / 45) + 1);
						var sentence = (i - set1Length) - ((section - 1) * 45) + 1;
						return "<span>" + labelGI + ", Sec. " + section + ", Sent. " + sentence + "</span>" + d.content;
					} else {
						var section = Math.floor((i / 37) + 1);
						var sentence = i - ((section - 1) * 37) + 1;
						return "<span>" + labelBD + ", Sec. " + section + ", Sent. " + sentence + "</span>" + d.content;
					}
				});

			//reset colors
			if (mode == "default") {
					d3.selectAll("rect")
					.attr("data-class","")
					.attr("opacity", defaultOpacity)
					.attr("fill", function(d,i) {
						if (i > set1Length - 1) {
							return set1Color;
						} else {
							return set2Color;
						}
					});	
			} else if (mode == "diff") {
				colorByDiff();
				resetColors();
			} else if (mode == "patterns") {
				colorByPattern();
				resetColors();
			}	

			//get relations
			currentRelations = relations.filter(function(relation) {
				return relation.a == i;
			});

			var currentSection = d3.select(this)
				.attr("data-section");
			var currentId = d3.select(this)
				.attr("id");
			var currentVersion = d3.select(this)
				.attr("data-version");

			currentMatch = -1;
			var tmpMaxStrength = 0;

			currentRelations.forEach(function(relation) {
				d3.select("#sentence-" + relation.b)
					.attr("opacity", .5 + +relation.strength)
					.attr("data-class", "active")
					.attr("fill", activeColor);

				var section = d3.select("#sentence-" + relation.b)
					.attr("data-section");

				var version = d3.select("#sentence-" + relation.b)
					.attr("data-version");

				//figure out best match within section
				if (section == currentSection && relation.b != relation.a && currentVersion != version) {
					var currentStrength = +relation.strength;
					if (currentStrength > tmpMaxStrength) {
						maxStrength = currentStrength;
						currentMatch = relation.b;
					}
					if (currentStrength > maxStrength) {
						maxStrength = currentStrength;
					} else if (currentStrength < minStrength) {
						minStrength = currentStrength;
					}
				}
			});


			//if there's an inexact match, show the differences
			if (maxStrength > 0 && maxStrength < 1) {

				var original = d3.select("#" + currentId)
						.datum();
				
				var changed = d3.select("#sentence-" + currentMatch)
						.datum();
				
				if (original.content != changed.content) {

					original.content = String(original.content).replace("<em>","").replace("</em>","");
					changed.content = String(changed.content).replace("<em>","").replace("</em>","");

					d3.select("#text")
						.append("p")
						.html(function() {
							if (currentMatch > set1Length - 1) {
								var section = Math.floor(((currentMatch - set1Length) / 45) + 1);
								var sentence = (currentMatch - set1Length) - ((section - 1) * 45) + 1;
								return "<span>" + labelGI + ", Sec. " + section + ", Sent. " + sentence + "</span>" + diffString(original.content, changed.content);
							} else {
								var section = Math.floor((currentMatch / 37) + 1);
								var sentence = currentMatch - ((section - 1) * 37) + 1;
								return "<span>" + labelBD + ", Sec. " + section + ", Sent. " + sentence + "</span>" + diffString(original.content, changed.content);
							}
							})
							.attr("class", function() {
								if (currentMatch > set1Length - 1) {
									return "gi"
								} else {
									return "bd"
								}
							});

				}
			}

			//if there's an exact match
			if (maxStrength == 1) {

				var changed = d3.select("#sentence-" + currentMatch)
						.datum();

					d3.select("#text")
						.append("p")
						.html(function() {
							if (currentMatch > set1Length - 1) {
								var section = Math.floor(((currentMatch - set1Length) / 45) + 1);
								var sentence = (currentMatch - set1Length) - ((section - 1) * 45) + 1;
								return "<span>" + labelGI + ", Sec. " + section + ", Sent. " + sentence + "</span>" + changed.content;
							} else {
								var section = Math.floor((currentMatch / 37) + 1);
								var sentence = currentMatch - ((section - 1) * 37) + 1;
								return "<span>" + labelBD + ", Sec. " + section + ", Sent. " + sentence + "</span>" + changed.content;
							}
							})
							.attr("class", function() {
								if (currentMatch > set1Length - 1) {
									return "gi"
								} else {
									return "bd"
								}
							});

			}//if same

			//turn on current match
			d3.select('#sentence-' + currentMatch)
				.attr("fill", "#333");

			//turn on clicked element
			d3.select(this).attr("opacity",1)
				.attr("data-class", "active")
				.attr("fill", "#333");

		});

	//Assign difference weightings
	relations.forEach(function(relation) {
		d3.select("#sentence-" + relation.a)
			.attr("data-difference", function() {
				var diff = +d3.select(this).attr("data-difference") + +relation.strength;
				return diff;
			});
	})

	resetColors();
	doFirst();

})//csv
}//processSentences

d3.select("#differences").on("click", function() {
	mode = "diff";
	clearText();
	colorByDiff();
	resetColors();
	d3.selectAll("#meta a")
		.attr("class","");
	d3.select(this).attr("class", "active");
})

d3.select("#patterns").on("click", function() {
	mode = "patterns";
	clearText();
	colorByPattern();
	resetColors();
	d3.selectAll("#meta a")
		.attr("class","");
	d3.select(this).attr("class", "active");	
})

d3.select("#default").on("click", function() {
	mode = "default";
	clearText();
	colorByDefault();
	resetColors();
	d3.selectAll("#meta a")
		.attr("class","");
	d3.select(this).attr("class", "active");	
})

function doFirst() {
	d3.select("#sentence-0").each(function(d, i) {
		console.log("!");
	    var onClickFunc = d3.select(this).on("click");
	    onClickFunc.apply(this, [d, i]);
	}); 	
}

function colorByDefault() {

	d3.selectAll("rect")
		.attr("opacity", defaultOpacity);

}//colorByDefault

function colorByDiff() {
	d3.selectAll("rect")
	.attr("opacity", function() {
		var diff = d3.select(this).attr("data-difference");
		if (diff < 2) {
			return opacityScale2(2 - diff);
		} else {
			return 1;
		}
	}).attr("fill", function () {
		var version = d3.select(this).attr("data-version");
		var diff = d3.select(this).attr("data-difference");
		if (diff < 2) {
			if (version == "gi") {
				return set1Color;
			} else {
				return set2Color;
			}			
		} else {
			return bgColor;
		}

	})
}//colorByDiff

function colorByPattern() {
	patternScale.domain([maxStrength, 2]).range([.5,1]);

	d3.selectAll("rect")
		.attr("opacity", function() {
			var diff = d3.select(this).attr("data-difference");
			if (diff > 5) {
				return patternScale(diff);
			} else {
				return 1;
			}
		}).attr("fill", function() {
			var diff = d3.select(this).attr("data-difference");
			if (diff > 5) {
				var version = d3.select(this).attr("data-version");
				if (version == "gi") {
					return set1Color;
				} else {
					return set2Color;
				}
			} else {
				return bgColor;
			}		
		});
}//colorByPattern



function resetColors() {
	d3.selectAll("rect")
		.attr("data-class", "")
		.attr("fill", function(d,i) {
			if (mode == "diff" && d3.select(this).attr("data-difference") >= 2) {
				return bgColor;
			} else if (mode == "patterns" && d3.select(this).attr("data-difference") <= 5) {
				return bgColor;
			}
			else if (i > set1Length - 1) {
				return set1Color;
			} else {
				return set2Color;
			}
		});	
}//resetColors

function clearText() {
	d3.selectAll("#text p").remove();
}//clearText

function returnRange(sentence) {
	var set = 0;
	var range = [];

	if (sentence <= set1Length - 1) {
		set = Math.ceil((sentence + 1) / set1Sections);
		range.push(set * set1Sections - set1Sections);	
		range.push(set * set1Sections - 1);	
	} else {
		set = Math.ceil((sentence + 1 - set1Length) / set2Sections);
		range.push(set * set2Sections - set2Sections + set1Length);	
		range.push(set * set2Sections - 1 + set1Length);					
	}
}//returnRange




















/*
 * Javascript Diff Algorithm
 *  By John Resig (http://ejohn.org/)
 *  Modified by Chu Alan "sprite"
 *
 * Released under the MIT license.
 *
 * More Info:
 *  http://ejohn.org/projects/javascript-diff-algorithm/
 */

function escape(s) {
    var n = s;
    n = n.replace(/&/g, "&amp;");
    n = n.replace(/</g, "&lt;");
    n = n.replace(/>/g, "&gt;");
    n = n.replace(/"/g, "&quot;");

    return n;
}

function diffString( o, n ) {
  o = o.replace(/\s+$/, '');
  n = n.replace(/\s+$/, '');

  var out = diff(o == "" ? [] : o.split(/\s+/), n == "" ? [] : n.split(/\s+/) );
  var str = "";

  var oSpace = o.match(/\s+/g);
  if (oSpace == null) {
    oSpace = ["\n"];
  } else {
    oSpace.push("\n");
  }
  var nSpace = n.match(/\s+/g);
  if (nSpace == null) {
    nSpace = ["\n"];
  } else {
    nSpace.push("\n");
  }

  if (out.n.length == 0) {
      for (var i = 0; i < out.o.length; i++) {
        str += '<del>' + escape(out.o[i]) + oSpace[i] + "</del>";
      }
  } else {
    if (out.n[0].text == null) {
      for (n = 0; n < out.o.length && out.o[n].text == null; n++) {
        str += '<del>' + escape(out.o[n]) + oSpace[n] + "</del>";
      }
    }

    for ( var i = 0; i < out.n.length; i++ ) {
      if (out.n[i].text == null) {
        str += '<ins>' + escape(out.n[i]) + nSpace[i] + "</ins>";
      } else {
        var pre = "";

        for (n = out.n[i].row + 1; n < out.o.length && out.o[n].text == null; n++ ) {
          pre += '<del>' + escape(out.o[n]) + oSpace[n] + "</del>";
        }
        str += " " + out.n[i].text + nSpace[i] + pre;
      }
    }
  }
  
  return str;
}

function randomColor() {
    return "rgb(" + (Math.random() * 100) + "%, " + 
                    (Math.random() * 100) + "%, " + 
                    (Math.random() * 100) + "%)";
}

function diffString2( o, n ) {
  o = o.replace(/\s+$/, '');
  n = n.replace(/\s+$/, '');

  var out = diff(o == "" ? [] : o.split(/\s+/), n == "" ? [] : n.split(/\s+/) );

  var oSpace = o.match(/\s+/g);
  if (oSpace == null) {
    oSpace = ["\n"];
  } else {
    oSpace.push("\n");
  }
  var nSpace = n.match(/\s+/g);
  if (nSpace == null) {
    nSpace = ["\n"];
  } else {
    nSpace.push("\n");
  }

  var os = "";
  var colors = new Array();
  for (var i = 0; i < out.o.length; i++) {
      colors[i] = randomColor();

      if (out.o[i].text != null) {
          os += '<span style="background-color: ' +colors[i]+ '">' + 
                escape(out.o[i].text) + oSpace[i] + "</span>";
      } else {
          os += "<del>" + escape(out.o[i]) + oSpace[i] + "</del>";
      }
  }

  var ns = "";
  for (var i = 0; i < out.n.length; i++) {
      if (out.n[i].text != null) {
          ns += '<span style="background-color: ' +colors[out.n[i].row]+ '">' + 
                escape(out.n[i].text) + nSpace[i] + "</span>";
      } else {
          ns += "<ins>" + escape(out.n[i]) + nSpace[i] + "</ins>";
      }
  }

  return { o : os , n : ns };
}

function diff( o, n ) {
  var ns = new Object();
  var os = new Object();
  
  for ( var i = 0; i < n.length; i++ ) {
    if ( ns[ n[i] ] == null )
      ns[ n[i] ] = { rows: new Array(), o: null };
    ns[ n[i] ].rows.push( i );
  }
  
  for ( var i = 0; i < o.length; i++ ) {
    if ( os[ o[i] ] == null )
      os[ o[i] ] = { rows: new Array(), n: null };
    os[ o[i] ].rows.push( i );
  }
  
  for ( var i in ns ) {
    if ( ns[i].rows.length == 1 && typeof(os[i]) != "undefined" && os[i].rows.length == 1 ) {
      n[ ns[i].rows[0] ] = { text: n[ ns[i].rows[0] ], row: os[i].rows[0] };
      o[ os[i].rows[0] ] = { text: o[ os[i].rows[0] ], row: ns[i].rows[0] };
    }
  }
  
  for ( var i = 0; i < n.length - 1; i++ ) {
    if ( n[i].text != null && n[i+1].text == null && n[i].row + 1 < o.length && o[ n[i].row + 1 ].text == null && 
         n[i+1] == o[ n[i].row + 1 ] ) {
      n[i+1] = { text: n[i+1], row: n[i].row + 1 };
      o[n[i].row+1] = { text: o[n[i].row+1], row: i + 1 };
    }
  }
  
  for ( var i = n.length - 1; i > 0; i-- ) {
    if ( n[i].text != null && n[i-1].text == null && n[i].row > 0 && o[ n[i].row - 1 ].text == null && 
         n[i-1] == o[ n[i].row - 1 ] ) {
      n[i-1] = { text: n[i-1], row: n[i].row - 1 };
      o[n[i].row-1] = { text: o[n[i].row-1], row: i - 1 };
    }
  }
  
  return { o: o, n: n };
}






	


