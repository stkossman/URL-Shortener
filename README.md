<p align="center">
  <img src="https://i.imgur.com/mmLswHH.png" alt="URL Shortener Screenshot">
</p>

# 🔗 Sinatra URL Shortener

A minimalist URL shortening service built with Ruby and Sinatra. Accepts URLs via web interface or API, generates short codes, and redirects users - all in under 100 lines of code!

## Features

- **URL Shortening**: Convert long links to short, memorable URLs
- **Web Interface**: Simple, responsive HTML frontend
- **API Endpoint**: JSON API for programmatic access (`POST /shorten`)
- **Instant Redirects**: Fast 302 redirects for shortened URLs
- **Clean UI**: Modern styling with Font Awesome icons

## Tech Stack

- **Ruby 3+** - Programming language
- **Sinatra** - Lightweight web framework
- **Rack** - Web server interface
- **SecureRandom** - For generating unique short codes
- **Vanilla JS** - Frontend interactivity

## Limitations

⚠️ **In-memory storage** - URLs are lost when server restarts  
⚠️ No analytics or click tracking  
⚠️ No user accounts or vanity URLs

Perfect for personal use, prototyping, or as a starting point for more advanced features.
