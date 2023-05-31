 function callAPI(url, method, headers, data, callback) {
     var xhr = new XMLHttpRequest();
     xhr.open(method, url, true);

    // Set headers
     if (headers) {
         for (var header in headers) {
             xhr.setRequestHeader(header, headers[header]);
         }
     }

     if (!!data&&Object.keys(data).length > 0) {
         xhr.setRequestHeader('Content-Type', 'application/json');
     }
         

     

    xhr.onload = function () {
        if (xhr.status === 200) {
            var response = JSON.parse(xhr.responseText);
            callback(null, response);
        } else {
            callback(xhr.statusText, null);
        }
    };

    xhr.onerror = function () {
        callback(xhr.statusText, null);
     };
     if (data !== null) {
         if (data instanceof FormData) {
             console.log("formData");
             xhr.send(data);

         } else
         xhr.send(JSON.stringify(data));

     }
     else
         xhr.send();
}


export { callAPI };