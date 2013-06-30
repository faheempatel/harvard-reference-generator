// clipboard.js
var clip = new ZeroClipboard( document.getElementById("copy-button"), {
  moviePath: "./scripts/ZeroClipboard.swf"
} );

clip.on( 'load', function(client) {
  // alert( "movie is loaded" );
} );

clip.on( 'complete', function(client) {
  alert("Copied!");
} );

clip.on( 'mouseover', function(client) {
  // alert("mouse over");
} );

clip.on( 'mouseout', function(client) {
  // alert("mouse out");
} );

clip.on( 'mousedown', function(client) {

  // alert("mouse down");
} );

clip.on( 'mouseup', function(client) {
  // alert("mouse up");
} );
