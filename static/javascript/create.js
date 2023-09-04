window.onload = function ()
{
    // Your JavaScript code to execute when the page and all resources are fully loaded
    document.getElementById('submit').addEventListener('click', put);
}

function addRecordCreatedAlert(id)
{
    var html = `\
    <div> \
    A record with ID <a href="records/${id}">${id}</a> created.\
    <button type="button" onclick=" removeRecordCreatedAlert(event) ">X</button> \
    </div>`;
    document.body.insertAdjacentHTML('beforeend', html);
}

function removeRecordCreatedAlert(event)
{
    const clickedElement = event.target;
    clickedElement.parentElement.remove();
}

function put(event)
{
    console.log("1");

    var titleValue = document.getElementById('title_textarea').value;
    var bodyValue = document.getElementById('body_textarea').value;
    var url = `${endpoint}/create`;

    request = {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ 'title': titleValue, 'body': bodyValue })
    };

    console.log("111");
    fetch(url, request)
        .then(response => response.json())
        .then(data =>
        {
            console.log('PUT request successful');
            addRecordCreatedAlert(data['id']);
            // window.location.reload();
            // Handle the response data here
        })
        .catch(error =>
        {
            console.error('Error sending PUT request', error);
            console.log(textFieldValue);
            console.log(JSON.stringify({ data: textFieldValue }));
            // Handle errors here
        }
        );
}