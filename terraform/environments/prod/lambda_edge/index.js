'use strict';
exports.handler = (event, context, callback) => {

    //Get contents of response
    const response = event.Records[0].cf.response;
    const headers = response.headers;

    //Set new headers
    headers['strict-transport-security'] = [{key: 'Strict-Transport-Security', value: 'max-age= 63072000; includeSubdomains; preload'}];
    headers['content-security-policy'] = [{key: 'Content-Security-Policy', value: "default-src 'self'; img-src 'self' data: w3.org; script-src 'self' https://cdn.jsdelivr.net/ https://use.fontawesome.com/; style-src 'self' 'unsafe-inline' https://fonts.googleapis.com/ https://use.fontawesome.com/; object-src 'none'; font-src fonts.gstatic.com; connect-src https://3ijz5acnoe.execute-api.ap-northeast-1.amazonaws.com/"}];
    headers['x-content-type-options'] = [{key: 'X-Content-Type-Options', value: 'nosniff'}];
    headers['x-frame-options'] = [{key: 'X-Frame-Options', value: 'DENY'}];
    headers['x-xss-protection'] = [{key: 'X-XSS-Protection', value: '1; mode=block'}];
    headers['referrer-policy'] = [{key: 'Referrer-Policy', value: 'same-origin'}];

    //Return modified response
    callback(null, response);
};