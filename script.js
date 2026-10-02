// URL of the PHP backend (change this if you host weather.php somewhere else)
const API_URL = "http://deep-maharjan.infinityfree.me/weather.php";

let temperature = document.getElementById("temperature");
let weatherCondition = document.getElementById("weathercondition");
let mainWeather = document.getElementById("mainweather");
let cityDisplay = document.getElementById("city");
let dateDisplay = document.getElementById("date");
let dayDisplay = document.getElementById("day");
let iconDisplay = document.getElementById("icon");
let button = document.getElementById("searchbtn");
let searchBar = document.getElementById("searchbar");

let detailBoxes = document.getElementsByClassName("detail-box");
let pressureDetail = detailBoxes[0];
let humidityDetail = detailBoxes[1];
let windDetail = detailBoxes[2];
let directionDetail = detailBoxes[3];

button.addEventListener("click", function () {
  weatherData(searchBar.value);
});

async function weatherData(city) {
  try {
    let response = await fetch(`${API_URL}?q=${encodeURIComponent(city)}`);

    if (!response.ok) {
      throw new Error("City not found");
    }

    let data = await response.json();
    console.log(data);

    let cityKey = data.name.toLowerCase();
    let record = {
      id: data.id,
      weather: data.weather[0].icon,
      city_name: data.name,
      temp: data.main.temp,
      description: data.weather[0].description,
      humidity: data.main.humidity,
      pressure: data.main.pressure,
      windspeed: data.wind.speed,
      direction: data.wind.deg
    };
    localStorage.setItem(cityKey, JSON.stringify(record));

    temperature.textContent = data.main.temp + "°C";
    weatherCondition.textContent = data.weather[0].main;
    mainWeather.textContent = data.weather[0].description;
    cityDisplay.textContent = data.name;

    let currentDate = new Date();
    dateDisplay.textContent = "Date: " + currentDate.toLocaleDateString();
    dayDisplay.textContent = "Day: " + currentDate.toLocaleDateString(undefined, { weekday: "long" }).split(",")[0];

    if (data.weather[0].icon) {
      iconDisplay.src = "https://openweathermap.org/img/wn/" + data.weather[0].icon + "@2x.png";
      iconDisplay.alt = data.weather[0].description;
    } else {
      iconDisplay.src = "default-icon.png";
      iconDisplay.alt = "No icon available";
    }

    pressureDetail.querySelector("p").textContent = "Pressure: " + data.main.pressure + " hPa";
    humidityDetail.querySelector("p").textContent = "Humidity: " + data.main.humidity + "%";
    windDetail.querySelector("p").textContent = "Windspeed: " + data.wind.speed + " m/s";
    directionDetail.querySelector("p").textContent = "Direction: " + data.wind.deg + "°";

  } catch (error) {
    alert("Error: " + error.message);
  }
}

weatherData("Dudley");