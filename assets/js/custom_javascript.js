setTimeout(function() {
  $('#successMessage').fadeOut("slow");
}, 1500); // <-- time in milliseconds

var deadline = new Date("Dec 19 , 2019 15:37:25").getTime();
var x = setInterval(function() {
var now = new Date().getTime();
var t = deadline - now; 
var days = Math.floor(t / (1000 * 60 * 60 * 24));
var hours = Math.floor((t%(1000 * 60 * 60 * 24))/(1000 * 60 * 60));
var minutes = Math.floor((t % (1000 * 60 * 60)) / (1000 * 60));
var seconds = Math.floor((t % (1000 * 60)) / 1000);

var new_time =  new Date(deadline);

document.getElementById("start-date").innerHTML = "Starts " +  new_time.toUTCString();

document.getElementById("expire-date").innerHTML = days + "d "  
+ hours + "h " + minutes + "m " + seconds + "s " + "Left"; 
    if (t < 0) { 
        clearInterval(x); 
        document.getElementById("expire-date").innerHTML = "EXPIRED";
    } 
}, 1000);