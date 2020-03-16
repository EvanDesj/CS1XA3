function toggleText(arrow, id){
  var img = document.getElementById(arrow);
  if ($(id).is(":visible")){
    $(id).hide();
        img.style.transform = 'rotate(0deg)';
  }
  else {
    $(id).show();
    img.style.transform = 'rotate(90deg)';
  }
}

//https://stackoverflow.com/questions/1740700/how-to-get-hex-color-value-rather-than-rgb-value {

var hexDigits = new Array
        ("0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f");

//Function to convert rgb color to hex format
function rgb2hex(rgb) {
 var rgbArray = rgb.match(/^rgb\((\d+),\s*(\d+),\s*(\d+)\)$/);
 return hex(rgbArray[1]) + hex(rgbArray[2]) + hex(rgbArray[3]);
}

function hex(x) {
  return isNaN(x) ? "00" : hexDigits[(x - x % 16) / 16] + hexDigits[x % 16];
 }

// Stack overflow hex color not rgb ends here

function invertColors(name, attr){
  $(name).each(function(){
    var color = $(this).css(attr);
    var invHex = inverseHexColor(color);
    $(this).css(attr, ("#" + invHex));
  });
}

function inverseHexColor(color) {
  var hexColor = rgb2hex(color);
  var subtractHex = 0xFFFFFF - ("0x" + String(hexColor));
  var invHex = subtractHex.toString(16)
  for (i=invHex.length; i<6; i++){
    invHex = "0" + invHex
  }
  return invHex
}

function toggleLD(){
  if($("#lightdarkimg").attr('class') === "light"){
    $("#lightdarkimg").attr('class', 'dark');
    $("#lightdarkimg").attr('src', 'images/dark.png');
    $(".arrow").attr('src', 'images/arrow.png');
    invertColors("h1", "color");
    invertColors("p", "color");
    invertColors("h2", "color");
    invertColors("ul li", "color");
    invertColors(".link", "color");
    invertColors(".keySkills", "color");
    invertColors(".mainDetails", "background-color");
    invertColors("#cv", "background-color");
  }
  else {
    $("#lightdarkimg").attr('class', 'light');
    $("#lightdarkimg").attr('src', 'images/light.png');
    $(".arrow").attr('src', 'images/white_arrow.png');
    invertColors("h1", "color");
    invertColors("p", "color");
    invertColors("h2", "color");
    invertColors("ul li", "color");
    invertColors(".link", "color");
    invertColors(".keySkills", "color");
    invertColors(".mainDetails", "background-color");
    invertColors("#cv", "background-color");
  }
}

$(function(){
  var currentLinkColor = $(".link").css("color");
  $("#profileTitle").click(function() {
    toggleText("profileArrow", "#profileText");
  });
  $("#workTitle").click(function() {
    toggleText("workArrow", "#workText");
  });
  $("#skillsTitle").click(function() {
    toggleText("skillsArrow", "#skillsText");
  });
  $("#eduTitle").click(function() {
    toggleText("eduArrow", "#eduText");
  });
  $("#volunTitle").click(function() {
    toggleText("volunArrow", "#volunText");
  });
  $("#credTitle").click(function() {
    toggleText("credArrow", "#credText");
  });
  $("#lightdarkimg").click(function() {
    toggleLD();
  });
});
