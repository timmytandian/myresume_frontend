document.addEventListener("DOMContentLoaded", updateVisitCounterElmtInnerHtml);

async function getVisitorCount(){
    // define the API endpoint
    const apiEndpoint = new URL("https://vo422t3t39.execute-api.ap-northeast-1.amazonaws.com/counts/250808e1-38f9-2c29-90b9-5146319be0c3?func=addOneVisitorCount");
    
    // fetch the data from the database
    try {
        const apiResponse = await fetch(apiEndpoint, {
            method: "GET",
        });
        if (!apiResponse.ok) {
            let errorTitle = `Fetch API response not OK (status ${apiResponse.status})` 
            throw new Error(errorTitle);
        }
        
        // set the value to output variable
        const data = await apiResponse.json();
        return data;
    } 
    catch(error) {
        // log the error to console
        console.error(error);
        throw error
    }
    
}

function updateVisitCounterElmtInnerHtml(){
    // select the element to update
    var visitCounterElmt = document.querySelector("#visit-count");
    getVisitorCount()
    .then(
        response => {
            visitCounterElmt.innerHTML = response
        },
        errorResponse => {
            visitCounterElmt.innerHTML = "(under development)"
        }
    )
}

export {getVisitorCount};