window.onload = function ()
{
    // Your JavaScript code to execute when the page and all resources are fully loaded
    document.getElementById('submit').addEventListener('click', put);
};

function addRecordCreatedAlert(id)
{
    var html = `<div class="alert alert-success alert-dismissible fade show mt-3" role="alert"> \
    A record with ID <a href="records/${id}" class="alert-link">${id}</a> created.\
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button> \
    </div>`;
    document.body.insertAdjacentHTML('beforeend', html);
}

function put(event)
{
    console.log("1");

    var titleValue = document.getElementById('title_textarea').value;
    var bodyValue = document.getElementById('body_textarea').value;
    var url = 'http://0.0.0.0:5000/create';

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