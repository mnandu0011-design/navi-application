// ==========================================
// SUPABASE CONNECTION
// ==========================================

const SUPABASE_URL = "YOUR_SUPABASE_PROJECT_URL";

const SUPABASE_KEY = "YOUR_SUPABASE_PUBLISHABLE_KEY";

const supabaseClient = window.supabase.createClient(
    SUPABASE_URL,
    SUPABASE_KEY
);


// ==========================================
// CURRENT USER
// ==========================================

let currentUser = null;


// ==========================================
// DEMO BALANCE
// ==========================================

let balance = 25000;


let transactions = [
    {
        title: "Welcome to NaviPay",
        amount: 25000,
        type: "credit",
        date: new Date().toLocaleDateString()
    }
];


// ==========================================
// LOGIN PAGE
// ==========================================

function showLogin() {

    document.getElementById("signupBox").style.display = "none";

    document.getElementById("loginBox").style.display = "block";
}


function showSignup() {

    document.getElementById("loginBox").style.display = "none";

    document.getElementById("signupBox").style.display = "block";
}


// ==========================================
// SIGN UP
// ==========================================

async function signup(event) {

    event.preventDefault();


    const name =
        document.getElementById("signupName").value.trim();


    const phone =
        document.getElementById("signupPhone").value.trim();


    const email =
        document.getElementById("signupEmail").value.trim();


    const password =
        document.getElementById("signupPassword").value;


    if (!name || !phone || !email || !password) {

        alert("Please fill all fields.");

        return;
    }


    if (password.length < 6) {

        alert("Password must contain at least 6 characters.");

        return;
    }


    // Convert phone into international format.
    // Change +91 if you are using another country.

    let phoneNumber = phone;

    if (!phone.startsWith("+")) {

        phoneNumber = "+91" + phone;
    }


    // Create Supabase Auth account

    const {
        data,
        error
    } = await supabaseClient.auth.signUp({

        phone: phoneNumber,

        password: password,

        options: {

            data: {

                full_name: name,

                email: email

            }

        }

    });


    if (error) {

        console.error(error);

        alert(error.message);

        return;
    }


    if (!data.user) {

        alert("Account could not be created.");

        return;
    }


    currentUser = data.user;


    // Create profile

    const {
        error: profileError
    } = await supabaseClient
        .from("profiles")
        .insert({

            id: data.user.id,

            full_name: name,

            phone: phoneNumber,

            email: email

        });


    if (profileError) {

        console.error(profileError);

        alert(
            "Account created, but profile could not be saved: " +
            profileError.message
        );

        return;
    }


    alert(
        "Account created successfully!"
    );


    document
        .getElementById("signupForm")
        .reset();


    openDashboard();
}


// ==========================================
// LOGIN
// ==========================================

async function login(event) {

    event.preventDefault();


    const phone =
        document.getElementById("loginPhone").value.trim();


    const password =
        document.getElementById("loginPassword").value;


    if (!phone || !password) {

        alert("Please enter phone number and password.");

        return;
    }


    let phoneNumber = phone;


    if (!phone.startsWith("+")) {

        phoneNumber = "+91" + phone;
    }


    const {
        data,
        error
    } = await supabaseClient.auth.signInWithPassword({

        phone: phoneNumber,

        password: password

    });


    if (error) {

        console.error(error);

        alert(error.message);

        return;
    }


    currentUser = data.user;


    await loadUserDetails();


    openDashboard();
}


// ==========================================
// OPEN DASHBOARD
// ==========================================

function openDashboard() {

    document.getElementById("authPage").style.display = "none";

    document.getElementById("appPage").style.display = "flex";


    loadUserDetails();


    showPage("home");


    updateBalance();


    displayRecentTransactions();
}


// ==========================================
// LOAD ONLY CURRENT USER PROFILE
// ==========================================

async function loadUserDetails() {

    if (!currentUser) {

        return;
    }


    const {
        data,
        error
    } = await supabaseClient
        .from("profiles")
        .select("*")
        .eq("id", currentUser.id)
        .single();


    if (error) {

        console.error(error);

        return;
    }


    const name = data.full_name || "User";

    const email = data.email || "";

    const phone = data.phone || "";


    // Name

    document
        .querySelectorAll(".user-name")
        .forEach(function(element) {

            element.textContent = name;

        });


    // Phone

    document
        .querySelectorAll(".user-phone")
        .forEach(function(element) {

            element.textContent = phone;

        });


    // Email

    document
        .querySelectorAll(".user-email")
        .forEach(function(element) {

            element.textContent = email;

        });


    // Avatar

    document
        .querySelectorAll(".user-avatar")
        .forEach(function(element) {

            element.textContent =
                name.charAt(0).toUpperCase();

        });


    // Welcome name

    const welcomeName =
        document.getElementById("welcomeName");


    if (welcomeName) {

        welcomeName.textContent = name;
    }


    // Profile name

    const profileName =
        document.getElementById("profileName");


    if (profileName) {

        profileName.textContent = name;
    }


    // Profile email

    const profileEmail =
        document.getElementById("profileEmail");


    if (profileEmail) {

        profileEmail.textContent = email;
    }


    // Profile phone

    const profilePhone =
        document.getElementById("profilePhone");


    if (profilePhone) {

        profilePhone.textContent = phone;
    }
}


// ==========================================
// LOGOUT
// ==========================================

async function logout() {

    const {
        error
    } = await supabaseClient.auth.signOut();


    if (error) {

        alert(error.message);

        return;
    }


    currentUser = null;


    document.getElementById("appPage").style.display = "none";

    document.getElementById("authPage").style.display = "flex";


    document
        .getElementById("loginForm")
        .reset();


    showLogin();
}


// ==========================================
// PAGE NAVIGATION
// ==========================================

function showPage(pageName) {

    const pages =
        document.querySelectorAll(".page");


    pages.forEach(function(page) {

        page.style.display = "none";

    });


    const selectedPage =
        document.getElementById(pageName);


    if (selectedPage) {

        selectedPage.style.display = "block";
    }


    const menuItems =
        document.querySelectorAll(".menu-item");


    menuItems.forEach(function(item) {

        item.classList.remove("active");

    });


    const activeItem =
        document.querySelector(
            `[data-page="${pageName}"]`
        );


    if (activeItem) {

        activeItem.classList.add("active");
    }


    if (pageName === "transactions") {

        displayTransactions();
    }


    if (pageName === "home") {

        updateBalance();

        displayRecentTransactions();
    }


    if (pageName === "profile") {

        loadUserDetails();
    }
}


function openPage(pageName) {

    showPage(pageName);
}


// ==========================================
// BALANCE
// ==========================================

function updateBalance() {

    document
        .querySelectorAll(".wallet-balance")
        .forEach(function(element) {

            element.textContent =
                "₹" + balance.toLocaleString("en-IN");

        });
}


// ==========================================
// RECHARGE
// ==========================================

function recharge() {

    const mobile =
        document
            .getElementById("rechargeMobile")
            .value.trim();


    const amount =
        Number(
            document
                .getElementById("rechargeAmount")
                .value
        );


    if (!mobile || !amount) {

        alert("Please enter mobile number and amount.");

        return;
    }


    if (amount <= 0) {

        alert("Enter a valid amount.");

        return;
    }


    if (amount > balance) {

        alert("Insufficient balance.");

        return;
    }


    balance -= amount;


    transactions.unshift({

        title: "Mobile Recharge",

        amount: amount,

        type: "debit",

        date: new Date().toLocaleDateString()

    });


    updateBalance();


    alert("Recharge successful!");



    document
        .getElementById("rechargeMobile")
        .value = "";


    document
        .getElementById("rechargeAmount")
        .value = "";


    displayRecentTransactions();
}


// ==========================================
// BILL PAYMENT
// ==========================================

function payBill() {

    const billType =
        document.getElementById("billType").value;


    const amount =
        Number(
            document.getElementById("billAmount").value
        );


    if (!amount || amount <= 0) {

        alert("Enter a valid amount.");

        return;
    }


    if (amount > balance) {

        alert("Insufficient balance.");

        return;
    }


    balance -= amount;


    transactions.unshift({

        title: billType + " Bill",

        amount: amount,

        type: "debit",

        date: new Date().toLocaleDateString()

    });


    updateBalance();


    alert("Bill payment successful!");


    document
        .getElementById("billAmount")
        .value = "";


    displayRecentTransactions();
}


// ==========================================
// SEND MONEY
// ==========================================

function sendMoney() {

    const recipient =
        document
            .getElementById("recipient")
            .value.trim();


    const amount =
        Number(
            document
                .getElementById("sendAmount")
                .value
        );


    if (!recipient || !amount) {

        alert("Please enter recipient and amount.");

        return;
    }


    if (amount <= 0) {

        alert("Enter a valid amount.");

        return;
    }


    if (amount > balance) {

        alert("Insufficient balance.");

        return;
    }


    balance -= amount;


    transactions.unshift({

        title: "Money Sent to " + recipient,

        amount: amount,

        type: "debit",

        date: new Date().toLocaleDateString()

    });


    updateBalance();


    alert("Money sent successfully!");


    document
        .getElementById("recipient")
        .value = "";


    document
        .getElementById("sendAmount")
        .value = "";


    displayRecentTransactions();
}


// ==========================================
// TRANSACTIONS
// ==========================================

function displayTransactions() {

    const container =
        document.getElementById(
            "transactionList"
        );


    if (!container) {

        return;
    }


    container.innerHTML = "";


    transactions.forEach(function(transaction) {

        const item =
            document.createElement("div");


        item.className =
            "transaction-item";


        const sign =
            transaction.type === "credit"
                ? "+"
                : "-";


        item.innerHTML = `

            <div>

                <strong>
                    ${transaction.title}
                </strong>

                <small>
                    ${transaction.date}
                </small>

            </div>

            <span class="${transaction.type}">

                ${sign}₹${transaction.amount.toLocaleString("en-IN")}

            </span>

        `;


        container.appendChild(item);

    });
}


// ==========================================
// RECENT TRANSACTIONS
// ==========================================

function displayRecentTransactions() {

    const container =
        document.getElementById(
            "recentTransactions"
        );


    if (!container) {

        return;
    }


    container.innerHTML = "";


    transactions
        .slice(0, 5)
        .forEach(function(transaction) {

            const item =
                document.createElement("div");


            item.className =
                "transaction-item";


            const sign =
                transaction.type === "credit"
                    ? "+"
                    : "-";


            item.innerHTML = `

                <div>

                    <strong>
                        ${transaction.title}
                    </strong>

                    <small>
                        ${transaction.date}
                    </small>

                </div>

                <span class="${transaction.type}">

                    ${sign}₹${transaction.amount.toLocaleString("en-IN")}

                </span>

            `;


            container.appendChild(item);

        });
}


// ==========================================
// DEMO SERVICES
// ==========================================

function applyLoan() {

    alert(
        "Loan application feature selected."
    );
}


function buyInsurance() {

    alert(
        "Insurance feature selected."
    );
}


function startInvestment() {

    alert(
        "Investment feature selected."
    );
}


// ==========================================
// EDIT PROFILE
// ==========================================

async function editProfile() {

    if (!currentUser) {

        return;
    }


    const newName =
        prompt(
            "Enter your new name:"
        );


    if (!newName) {

        return;
    }


    const {
        error
    } = await supabaseClient
        .from("profiles")
        .update({

            full_name: newName

        })
        .eq(
            "id",
            currentUser.id
        );


    if (error) {

        console.error(error);

        alert(error.message);

        return;
    }


    await loadUserDetails();


    alert(
        "Profile updated successfully."
    );
}


// ==========================================
// CHECK LOGIN SESSION
// ==========================================

async function checkSession() {

    const {
        data: {
            session
        }
    } = await supabaseClient.auth.getSession();


    if (session) {

        currentUser = session.user;

        await loadUserDetails();

        openDashboard();

    } else {

        document
            .getElementById("authPage")
            .style.display = "flex";


        document
            .getElementById("appPage")
            .style.display = "none";
    }
}


// ==========================================
// START APPLICATION
// ==========================================

document.addEventListener(
    "DOMContentLoaded",
    function() {


        // Login form

        document
            .getElementById("loginForm")
            .addEventListener(
                "submit",
                login
            );


        // Signup form

        document
            .getElementById("signupForm")
            .addEventListener(
                "submit",
                signup
            );


        // Sidebar navigation

        document
            .querySelectorAll(".menu-item")
            .forEach(function(item) {

                item.addEventListener(
                    "click",
                    function() {

                        const page =
                            item.getAttribute(
                                "data-page"
                            );


                        if (page) {

                            showPage(page);

                        }

                    }
                );

            });


        // Check Supabase login

        checkSession();

    }
);
