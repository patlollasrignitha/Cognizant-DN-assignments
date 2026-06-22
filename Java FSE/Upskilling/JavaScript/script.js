// =====================================
// 1. JavaScript Basics & Setup
// =====================================

console.log("Welcome to the Community Portal");

window.onload = function () {
    alert("Community Portal Loaded Successfully!");
};

// =====================================
// 2. Syntax, Data Types & Operators
// =====================================

const eventName = "Community Workshop";
const eventDate = "2026-06-30";
let availableSeats = 50;

console.log(`Event: ${eventName} | Date: ${eventDate}`);

availableSeats--;
availableSeats++;

console.log("Available Seats:", availableSeats);

// =====================================
// 3. Conditionals, Loops & Error Handling
// =====================================

const events = [
    { name: "Workshop", seats: 20, upcoming: true },
    { name: "Health Camp", seats: 0, upcoming: true },
    { name: "Sports Meet", seats: 15, upcoming: false }
];

events.forEach(event => {
    if (event.upcoming && event.seats > 0) {
        console.log(event.name);
    }
});

try {
    let registration = true;

    if (!registration) {
        throw "Registration Failed";
    }

    console.log("Registration Successful");
}
catch (error) {
    console.error(error);
}

// =====================================
// 4. Functions, Scope, Closures
// =====================================

function addEvent(name) {
    console.log(`${name} added successfully`);
}

function registerUser(name) {
    console.log(`${name} registered`);
}

function filterEventsByCategory(category) {
    return events.filter(event => event.name === category);
}

function registrationCounter() {
    let count = 0;

    return function () {
        count++;
        return count;
    };
}

const totalRegistrations = registrationCounter();

console.log(totalRegistrations());
console.log(totalRegistrations());

// =====================================
// 5. Objects & Prototypes
// =====================================

class Event {
    constructor(name, seats) {
        this.name = name;
        this.seats = seats;
    }
}

Event.prototype.checkAvailability = function () {
    return this.seats > 0;
};

const workshop = new Event("Workshop", 25);

console.log(workshop.checkAvailability());

Object.entries(workshop).forEach(([key, value]) => {
    console.log(`${key}: ${value}`);
});

// =====================================
// 6. Arrays & Methods
// =====================================

let communityEvents = [
    "Workshop",
    "Music Festival",
    "Health Camp"
];

communityEvents.push("Sports Meet");

const musicEvents = communityEvents.filter(event =>
    event.includes("Music")
);

const formattedEvents = communityEvents.map(event =>
    `Upcoming Event: ${event}`
);

console.log(formattedEvents);

// =====================================
// 7. DOM Manipulation
// =====================================

const homeSection = document.querySelector("#home");

if (homeSection) {
    const card = document.createElement("div");
    card.innerHTML = "<h3>New Event Added</h3>";
    homeSection.appendChild(card);
}

// =====================================
// 8. Event Handling
// =====================================

function showConfirmation() {
    alert("Registration Confirmed!");
}

function displayFee() {
    console.log("Event Selected");
}

function countCharacters() {
    console.log("Typing Feedback...");
}

function validatePhone() {
    console.log("Phone Validation Triggered");
}

function enlargeImage() {
    console.log("Image Double Clicked");
}

function videoReady() {
    console.log("Video Ready To Play");
}

function findLocation() {
    console.log("Finding Nearby Events");
}

function savePreference() {
    console.log("Preference Saved");
}

function clearPreferences() {
    console.log("Preferences Cleared");
}

// =====================================
// 9. Async JS, Promises, Async/Await
// =====================================

function fetchEvents() {
    return new Promise((resolve) => {
        setTimeout(() => {
            resolve(["Workshop", "Health Camp"]);
        }, 2000);
    });
}

fetchEvents()
    .then(data => console.log(data))
    .catch(error => console.error(error));

async function loadEvents() {
    try {
        const data = await fetchEvents();
        console.log(data);
    }
    catch (error) {
        console.error(error);
    }
}

loadEvents();

// =====================================
// 10. Modern JavaScript Features
// =====================================

function createEvent(name = "Community Event") {
    console.log(name);
}

createEvent();

const eventDetails = {
    title: "Workshop",
    location: "Community Hall"
};

const { title, location } = eventDetails;

console.log(title, location);

// =====================================
// 11. Working with Forms
// =====================================

const form = document.querySelector("form");

if (form) {
    form.addEventListener("submit", function (event) {

        event.preventDefault();

        const formData = new FormData(form);

        console.log("Form Submitted");

        for (let pair of formData.entries()) {
            console.log(pair[0], pair[1]);
        }
    });
}

// =====================================
// 12. AJAX & Fetch API
// =====================================

function submitRegistration() {

    fetch("https://jsonplaceholder.typicode.com/posts", {
        method: "POST",
        body: JSON.stringify({
            name: "User Registration"
        }),
        headers: {
            "Content-Type": "application/json"
        }
    })
        .then(response => response.json())
        .then(data => {
            console.log("Registration Submitted", data);
        })
        .catch(error => {
            console.error(error);
        });

    setTimeout(() => {
        console.log("Server Response Received");
    }, 2000);
}

// =====================================
// 13. Debugging & Testing
// =====================================

console.log("Debugging Started");
console.log("Check Console & Network Tabs");

// =====================================
// 14. jQuery & JS Frameworks
// =====================================

// Example jQuery Syntax:
//
// $("#registerBtn").click(function(){
//     alert("Registered");
// });
//
// $(".card").fadeIn();
// $(".card").fadeOut();
//
// Benefit of React/Vue:
// Better component-based architecture and UI reusability.