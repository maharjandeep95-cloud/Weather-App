<?php
error_reporting(0);
ini_set('display_errors', 0);
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

// Credentials live in config.php (not stored in the repository)
require __DIR__ . '/config.php';

function fail($code, $message) {
    http_response_code($code);
    echo json_encode(["error" => $message]);
    exit;
}

$conn = mysqli_connect(DB_HOST, DB_USER, DB_PASS);
if (!$conn) {
    fail(500, "Database connection failed");
}
if (!mysqli_select_db($conn, DB_NAME)) {
    fail(500, "Database not found");
}

$create_table = "CREATE TABLE IF NOT EXISTS weather (
    cityName VARCHAR(100) NOT NULL UNIQUE,
    timedate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    temperature FLOAT NOT NULL,
    description VARCHAR(255) NOT NULL,
    humidity FLOAT NOT NULL,
    pressure FLOAT NOT NULL,
    windspeed FLOAT NOT NULL,
    direction VARCHAR(100) NOT NULL
)";
if (!mysqli_query($conn, $create_table)) {
    fail(500, "Table creation failed");
}

// Read and validate the city name
$city = isset($_GET['q']) ? trim($_GET['q']) : "Dudley";
if ($city === "" || strlen($city) > 100) {
    fail(400, "Invalid city name");
}

// Request weather data from OpenWeatherMap (city is URL-encoded)
$url = "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=" . urlencode(API_KEY) . "&q=" . urlencode($city);
$response = @file_get_contents($url);
if ($response === false) {
    fail(404, "City not found");
}
$data = json_decode($response, true);
if (!isset($data['name'], $data['main'], $data['weather'][0], $data['wind'])) {
    fail(404, "Weather data not found");
}

// Save or update the record using a prepared statement (prevents SQL injection)
$name        = $data['name'];
$temperature = $data['main']['temp'];
$description = $data['weather'][0]['description'];
$humidity    = $data['main']['humidity'];
$pressure    = $data['main']['pressure'];
$windspeed   = $data['wind']['speed'];
$direction   = (string)($data['wind']['deg'] ?? 0);

$sql = "INSERT INTO weather (cityName, temperature, description, humidity, pressure, windspeed, direction)
        VALUES (?, ?, ?, ?, ?, ?, ?)
        ON DUPLICATE KEY UPDATE
            temperature = VALUES(temperature),
            description = VALUES(description),
            humidity    = VALUES(humidity),
            pressure    = VALUES(pressure),
            windspeed   = VALUES(windspeed),
            direction   = VALUES(direction),
            timedate    = CURRENT_TIMESTAMP";
$stmt = mysqli_prepare($conn, $sql);
mysqli_stmt_bind_param($stmt, "sdsddds", $name, $temperature, $description, $humidity, $pressure, $windspeed, $direction);
if (!mysqli_stmt_execute($stmt)) {
    fail(500, "Could not save weather data");
}

echo json_encode($data);
