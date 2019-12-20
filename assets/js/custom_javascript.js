setTimeout(function() {
  $('#successMessage').fadeOut("slow");
}, 1500); // <-- time in milliseconds

var deadline = new Date("Dec 21 , 2019 15:37:25").getTime();
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


//----------------------
// Timer for live Bids
//----------------------

var timerInterval;

let minutes = 0;
let seconds = 6;

let duration = (minutes * 60) + seconds;
let display = document.querySelector('#timer');

function startTimer(duration, display) {
  var timer = duration, minutes, seconds;
  timerInterval = setInterval(function() {
    minutes = parseInt(timer / 60, 10)
    seconds = parseInt(timer % 60, 10);

    minutes = minutes < 10 ? "0" + minutes : minutes;
    seconds = seconds < 10 ? "0" + seconds : seconds;

    display.textContent = minutes + ":" + seconds;

    if (--timer < 0) {
      timer = duration;
      clearInterval(timerInterval);
      $('.button').attr('disabled','disabled');
      document.getElementById("timer").innerHTML = "Item Sold For";
    }
  }, 1000);
}

startTimer(duration, display);

$('#reset').click((e) => {
	clearInterval(timerInterval);
  startTimer(duration, display);
});
