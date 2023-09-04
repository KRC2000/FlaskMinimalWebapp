window.onload = function ()
{
    // Your JavaScript code to execute when the page and all resources are fully loaded
    searchInput = document.getElementById('search');
    searchInput.focus();
    searchInput.setSelectionRange(searchInput.value.length, searchInput.value.length);
}

function searchstr(event) 
{
    searchInput = document.getElementById('search');
    window.location = `/?searchstr=${searchInput.value}`;
}

function buttonPress(event)
{
    if (event.key == "Enter")
    {
        searchstr(event)
    }
}