# Weather Application

A web app that shows real-time weather for any city. Search for a city and see the temperature, conditions, pressure, humidity, wind speed and wind direction. Searches are stored in a MySQL database through a PHP backend.

## Features
- Search weather by city name
- Current temperature, weather description and icon
- Pressure, humidity, wind speed and wind direction
- PHP backend that calls the OpenWeatherMap API
- MySQL storage of searched cities (prepared statements to prevent SQL injection)
- Last search saved in the browser (localStorage)

## Built With
HTML, CSS, JavaScript, PHP, MySQL, OpenWeatherMap API

## Screenshots
![Home page](screenshots/home.png)
![Search result](screenshots/search.png)

## Project Structure
| File | Purpose |
|---|---|
| `index.html` | Page layout |
| `style.css` | Styling |
| `script.js` | Fetches data from the backend and updates the page |
| `weather.php` | Backend: calls the weather API and stores results in MySQL |
| `config.example.php` | Template for credentials (copy to `config.php`) |
| `database.sql` | Database structure with sample data |

## How to Run
1. Install [XAMPP](https://www.apachefriends.org/) and start Apache and MySQL.
2. Create a database called `weather_app` in phpMyAdmin and import `database.sql`.
3. Copy `config.example.php` to `config.php` and enter your database details and a free [OpenWeatherMap](https://openweathermap.org/api) API key.
4. Put the project files in `htdocs`.
5. In `script.js`, set `API_URL` to `http://localhost/your-folder/weather.php`.
6. Open `index.html` through `http://localhost/your-folder/`.

## Security Notes
- Database credentials and the API key are kept in `config.php`, which is excluded from the repository.
- User input is URL-encoded and database queries use prepared statements.

## What I Learned
- Connecting a PHP backend to a MySQL database
- Working with an external REST API and JSON
- Connecting a frontend to a backend with `fetch`
- Keeping secrets out of source code
