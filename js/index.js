document.addEventListener("DOMContentLoaded", getVisitorCount);

async function getVisitorCount(){
    // select the element to update
    var visitCounterElmt = document.querySelector("#visit-count");

    // fetch the data from the database
    const apiEndpoint = new URL("https://3ijz5acnoe.execute-api.ap-northeast-1.amazonaws.com/dev/counts/6632d5b4-5655-4c48-b7b6-071d5823c888?func=addOneVisitorCount");
    const apiResponse = await fetch(apiEndpoint, {
        method: "GET",
    });

    // back to default if connection to API failed
    if (apiResponse.status === 400) {
        visitCounterElmt.innerHTML = "(under development)"
        return
    }
    
    // retrieve the data
    const responseData = await apiResponse.json();    
    visitCounterElmt.innerHTML = responseData;
}