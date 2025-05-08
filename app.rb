require 'sinatra'
require 'securerandom'
require 'json'

URL_STORE = {}

get '/' do
  <<~HTML
  <!DOCTYPE html>
  <html>
    <head>
      <meta charset="UTF-8" />
      <title>URL Shortener</title>
      <style>
        body { font-family: sans-serif; padding: 2em; max-width: 600px; margin: auto; }
        input[type="url"] { width: 100%; padding: 0.5em; margin-bottom: 1em; }
        button { padding: 0.5em 1em; }
        #result { margin-top: 1em; font-weight: bold; }
      </style>
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    </head>
    <body>
      <h1><i class="fas fa-link"></i> URL Shortener</h1>
      <input type="url" id="longUrl" placeholder="Paste original URL here" required />
      <button onclick="shorten()">Shorten!</button>
      <div id="result"></div>

      <script>
        async function shorten() {
          const longUrl = document.getElementById('longUrl').value;
          const res = await fetch('/shorten', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ long_url: longUrl })
          });

          const data = await res.json();
          if (res.ok) {
            document.getElementById('result').innerHTML = 
              `Shorten link: <a href="${data.short_url}" target="_blank">${data.short_url}</a>`;
          } else {
            document.getElementById('result').textContent = 'Error: ' + data.error;
          }
        }
      </script>
    </body>
  </html>
  HTML
end

post '/shorten' do
  content_type :json

  request_payload = JSON.parse(request.body.read)
  long_url = request_payload['long_url']

  halt 400, { error: 'Missing long_url' }.to_json unless long_url

  short_id = SecureRandom.alphanumeric(6)
  URL_STORE[short_id] = long_url

  short_url = "#{request.base_url}/#{short_id}"
  { short_url: short_url }.to_json
end

get '/:short_id' do
  short_id = params[:short_id]
  long_url = URL_STORE[short_id]

  if long_url
    redirect long_url, 302
  else
    status 404
    'URL not found'
  end
end
