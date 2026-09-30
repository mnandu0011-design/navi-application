// Create map

const map = L.map("map").setView([12.8406, 80.1534], 13);


// OpenStreetMap

L.tileLayer(
    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
    {
        maxZoom: 19,
        attribution: "&copy; OpenStreetMap contributors"
    }
).addTo(map);


// Current location marker

let currentMarker = L.marker([12.8406, 80.1534])
    .addTo(map)
    .bindPopup("Current Location")
    .openPopup();


// Destination marker

let destinationMarker = null;


// Route line

let routeLine = null;


// PAGE NAVIGATION

function showPage(pageId, button) {

    const pages = document.querySelectorAll(".page");

    pages.forEach(page => {
        page.classList.remove("active-page");
    });

    document.getElementById(pageId).classList.add("active-page");


    const buttons = document.querySelectorAll(".menu");

    buttons.forEach(btn => {
        btn.classList.remove("active");
    });

    button.classList.add("active");


    if (pageId === "mapPage") {
        setTimeout(() => {
            map.invalidateSize();
        }, 200);
    }
}


// CALCULATE ROUTE

function calculateRoute() {

    const destination =
        document.getElementById("end").value ||
        document.getElementById("destination").value;


    if (destination.trim() === "") {

        alert("Please enter a destination.");

        return;
    }


    // Demo destination coordinates

    const destinations = {

        "chennai": [13.0827, 80.2707],

        "sai university": [12.8422, 80.1538],

        "tambaram": [12.9249, 80.1000],

        "chengalpattu": [12.6819, 79.9888],

        "pondicherry": [11.9139, 79.8145],

        "mahabalipuram": [12.6269, 80.1927]

    };


    const key = destination.toLowerCase().trim();


    let destinationLocation;


    if (destinations[key]) {

        destinationLocation = destinations[key];

    } else {

        // Demo location if destination is not in list

        destinationLocation = [13.0827, 80.2707];

    }


    // Remove old marker

    if (destinationMarker) {

        map.removeLayer(destinationMarker);

    }


    // Remove old route

    if (routeLine) {

        map.removeLayer(routeLine);

    }


    destinationMarker = L.marker(destinationLocation)
        .addTo(map)
        .bindPopup(destination)
        .openPopup();


    // Draw demo route

    routeLine = L.polyline(
        [
            [12.8406, 80.1534],
            destinationLocation
        ],
        {
            color: "#2563eb",
            weight: 6
        }
    ).addTo(map);


    map.fitBounds(routeLine.getBounds(), {
        padding: [70, 70]
    });


    // Calculate approximate distance

    const distance =
        map.distance(
            [12.8406, 80.1534],
            destinationLocation
        ) / 1000;


    const time =
        Math.round((distance / 35) * 60);


    document.getElementById("distance").textContent =
        distance.toFixed(1) + " km";


    document.getElementById("time").textContent =
        time + " min";

}


// LOCATE USER

function locateUser() {

    if (!navigator.geolocation) {

        alert("Location is not supported by your browser.");

        return;
    }


    navigator.geolocation.getCurrentPosition(

        function(position) {

            const lat = position.coords.latitude;
            const lng = position.coords.longitude;


            map.setView([lat, lng], 15);


            if (currentMarker) {

                map.removeLayer(currentMarker);

            }


            currentMarker = L.marker([lat, lng])
                .addTo(map)
                .bindPopup("You are here")
                .openPopup();

        },

        function() {

            alert("Unable to get your location.");

        }

    );

}


// ZOOM

function zoomIn() {

    map.zoomIn();

}


function zoomOut() {

    map.zoomOut();

}


// ADD PLACE

function addPlace() {

    const name = prompt("Enter place name:");

    if (name) {

        alert(name + " has been added to your saved places.");

    }

}


// ADD VEHICLE

function addVehicle() {

    const vehicle = prompt("Enter vehicle name:");

    if (vehicle) {

        alert(vehicle + " has been added.");

    }

}


// NEW ROUTE

function openRouteForm() {

    document.querySelectorAll(".menu")[0].click();

    document.getElementById("end").focus();

}
