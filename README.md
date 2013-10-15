# sassd

sassd is an ultra-minimalist Sinatra based HTTP service used for compiling
sass and scss files into valid CSS.

### Run

Install the requirements

    gem install sinatra
    gem install sass

Run sassd form the terminal

    ruby app.rb

### Compile Files

Two endpoints are available: `/scss` and `/sass`. Use the endpoint
corresponding to the syntax format you have.

Sample Request:

    POST /scss

    Content-Type: text/scss

    $link-color: #333;

    a {
        color: $link-color;
    }

Sample Response:

    HTTP/1.1 200 OK

    X-Content-Type-Options: nosniff
    Content-Type: text/css
    Content-Length: 24
    Connection: Keep-Alive
    Server: WEBrick/1.3.1 (Ruby/1.8.7/2012-02-08)
    Date: Tue, 15 Oct 2013 21:31:15 GMT

    a {
         color: #333333;
    }
