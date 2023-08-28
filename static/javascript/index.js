document.getElementById('b').addEventListener('click', put);

function put() {
    const textFieldValue = document.getElementById('textarea').value;
    const url = 'http://localhost';

    fetch(url, {
        method: 'PUT',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({ data: textFieldValue })
    })
    .then(response => response.json())
    .then(data => {
        console.log('PUT request successful');
        // Handle the response data here
    })
    .catch(error => {
        console.error('Error sending PUT request', error);
        console.log(textFieldValue);
        console.log(JSON.stringify({ data: textFieldValue }));
        // Handle errors here
    });
}