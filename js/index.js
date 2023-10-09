var visitCounterElmt = document.querySelector("#visit-count");
var resetButton = document.querySelector("#reset");

// Adding onClick event listener
resetButton.addEventListener("click", () => {
    visitCount = 1;    
    visitCounterElmt.innerHTML = visitCount;
});