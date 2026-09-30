
// =====================================================
// NAVIPAY SUPABASE CONNECTION
// =====================================================

const SUPABASE_URL = "https://ytidrdltibyycxuwmafy.supabase.co";
const SUPABASE_KEY = "sb_publishable_9iIiH9tiXuDEXt6F5yliCg_OMU4N1wq";

const supabaseClient = window.supabase.createClient(
    SUPABASE_URL,
    SUPABASE_KEY
);


// =====================================================
// GLOBAL VARIABLES
// =====================================================

let currentUser = null;


// =====================================================
// PAGE LOAD
// =====================================================

document.addEventListener("DOMContentLoaded", async () => {

    setupForms();

    const {
        data: {
            session
        }
    } = await supabaseClient.auth.getSession();

    if (session) {

        currentUser = session.user;

        await loadApplication();

    } else {

        showAuthPage();

    }
});


// =====================================================
// AUTH PAGE
// =====================================================

function showAuthPage() {

    document.getElementById("authPage").classList.remove("hidden");
    document.getElementById("appPage").classList.add("hidden");

}

function showAppPage() {

    document.getElementById("authPage").classList.add("hidden");
    document.getElementById("appPage").classList.remove("hidden");

}

function showLogin() {

    document.getElementById("loginBox").classList.remove("hidden");
    document.getElementById("signupBox").classList.add("hidden");
    document.getElementById("otpBox").classList.add("hidden");

    clearAuthMessage();

}

function showSignup() {

    document.getElementById("loginBox").classList.add("hidden");
    document.getElementById("signupBox").classList.remove("hidden");
    document.getElementById("otpBox").classList.add("hidden");

    clearAuthMessage();

}


// =====================================================
// PHONE FORMAT
// =====================================================

function formatPhone(phone) {

    phone = phone.trim();

    if (phone.startsWith("+91")) {
        return phone;
    }

    if (phone.length === 10) {
        return "+91" + phone;
    }

    return phone;
}


// =====================================================
// LOGIN
// =====================================================

async function loginUser(event) {

    event.preventDefault();

    const phone = formatPhone(
        document.getElementById("loginPhone").value
    );

    const password =
        document.getElementById("loginPassword").value;

    setAuthMessage("Logging in...");

    const {
        data,
        error
    } = await supabaseClient.auth.signInWithPassword({
        phone: phone,
        password: password
    });

    if (error) {

        setAuthMessage(error.message, true);
        return;

    }

    currentUser = data.user;

    await loadApplication();

}


// =====================================================
// SIGNUP
// =====================================================

async function signupUser(event) {

    event.preventDefault();

    const name =
        document.getElementById("signupName").value.trim();

    const phone =
        formatPhone(
            document.getElementById("signupPhone").value
        );

    const email =
        document.getElementById("signupEmail").value.trim();

    const password =
        document.getElementById("signupPassword").value;

    if (password.length < 6) {

        setAuthMessage(
            "Password must contain at least 6 characters.",
            true
        );

        return;
    }

    setAuthMessage("Creating account...");

    const {
        data,
        error
    } = await supabaseClient.auth.signUp({

        phone: phone,

        password: password,

        options: {

            data: {
                full_name: name,
                email: email
            }

        }

    });

    if (error) {

        setAuthMessage(error.message, true);
        return;

    }


    // OTP verification enabled

    if (!data.session) {

        localStorage.setItem(
            "pending_signup_phone",
            phone
        );

        localStorage.setItem(
            "pending_signup_name",
            name
        );

        localStorage.setItem(
            "pending_signup_email",
            email
        );

        document.getElementById("loginBox")
            .classList.add("hidden");

        document.getElementById("signupBox")
            .classList.add("hidden");

        document.getElementById("otpBox")
            .classList.remove("hidden");

        setAuthMessage(
            "OTP sent to your mobile number."
        );

        return;
    }


    // If phone verification is disabled

    currentUser = data.user;

    await loadApplication();

}


// =====================================================
// OTP
// =====================================================

async function verifyOTP() {

    const token =
        document.getElementById("otpCode").value.trim();

    const phone =
        localStorage.getItem("pending_signup_phone");

    if (!token || !phone) {

        setAuthMessage(
            "Enter the OTP.",
            true
        );

        return;
    }

    setAuthMessage("Verifying OTP...");

    const {
        data,
        error
    } = await supabaseClient.auth.verifyOtp({

        phone: phone,

        token: token,

        type: "sms"

    });

    if (error) {

        setAuthMessage(error.message, true);
        return;

    }

    currentUser = data.user;

    localStorage.removeItem("pending_signup_phone");
    localStorage.removeItem("pending_signup_name");
    localStorage.removeItem("pending_signup_email");

    await loadApplication();

}


// =====================================================
// LOAD APPLICATION
// =====================================================

async function loadApplication() {

    if (!currentUser) {
        showAuthPage();
        return;
    }

    showAppPage();

    await createProfileIfNeeded();

    await createWalletIfNeeded();

    await loadUserProfile();

    await loadWallet();

    await loadTransactions();

}


// =====================================================
// CREATE PROFILE IF NEEDED
// =====================================================

async function createProfileIfNeeded() {

    const {
        data,
        error
    } = await supabaseClient
        .from("profiles")
        .select("id")
        .eq("id", currentUser.id)
        .maybeSingle();

    if (error) {

        console.error(error);
        return;
    }

    if (!data) {

        const metadata =
            currentUser.user_metadata || {};

        const profile = {

            id: currentUser.id,

            full_name:
                metadata.full_name ||
                "User",

            phone:
                currentUser.phone || "",

            email:
                metadata.email ||
                currentUser.email ||
                null

        };

        const {
            error: insertError
        } = await supabaseClient
            .from("profiles")
            .insert(profile);

        if (insertError) {
            console.error(insertError);
        }

    }

}


// =====================================================
// CREATE WALLET
// =====================================================

async function createWalletIfNeeded() {

    const {
        data,
        error
    } = await supabaseClient
        .from("wallets")
        .select("id")
        .eq("user_id", currentUser.id)
        .maybeSingle();

    if (error) {

        console.error(error);
        return;

    }

    if (!data) {

        const {
            error: insertError
        } = await supabaseClient
            .from("wallets")
            .insert({

                user_id: currentUser.id,

                balance: 0

            });

        if (insertError) {
            console.error(insertError);
        }

    }

}


// =====================================================
// LOAD USER PROFILE
// =====================================================

async function loadUserProfile() {

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

    const phone = data.phone || "-";

    const email = data.email || "-";

    const initials =
        getInitials(name);


    document.getElementById("welcomeName")
        .textContent = name;

    document.getElementById("topUserName")
        .textContent = name;

    document.getElementById("userAvatar")
        .textContent = initials;

    document.getElementById("profileAvatar")
        .textContent = initials;

    document.getElementById("largeAvatar")
        .textContent = initials;

    document.getElementById("dashboardProfileName")
        .textContent = name;

    document.getElementById("dashboardProfilePhone")
        .textContent = phone;

    document.getElementById("dashboardProfileEmail")
        .textContent = email;

    document.getElementById("profileName")
        .textContent = name;

    document.getElementById("profilePhone")
        .textContent = phone;

    document.getElementById("profileEmail")
        .textContent = email;

    document.getElementById("profileID")
        .textContent = currentUser.id;

}


// =====================================================
// INITIALS
// =====================================================

function getInitials(name) {

    return name
        .split(" ")
        .filter(word => word.length > 0)
        .slice(0, 2)
        .map(word => word[0].toUpperCase())
        .join("");

}


// =====================================================
// LOAD WALLET
// =====================================================

async function loadWallet() {

    const {
        data,
        error
    } = await supabaseClient
        .from("wallets")
        .select("balance")
        .eq("user_id", currentUser.id)
        .single();

    if (error) {

        console.error(error);
        return;

    }

    document.getElementById("walletBalance")
        .textContent =
        Number(data.balance || 0).toFixed(2);

}


// =====================================================
// NAVIGATION
// =====================================================

function showSection(sectionID) {

    document.querySelectorAll(".section")
        .forEach(section => {

            section.classList.remove(
                "active-section"
            );

        });


    const selected =
        document.getElementById(sectionID);

    if (selected) {

        selected.classList.add(
            "active-section"
        );

    }


    document.querySelectorAll(".nav-btn")
        .forEach(button => {

            button.classList.remove("active");

        });


    const button =
        [...document.querySelectorAll(".nav-btn")]
            .find(btn =>
                btn.getAttribute("onclick") &&
                btn.getAttribute("onclick")
                    .includes(sectionID)
            );

    if (button) {

        button.classList.add("active");

    }


    const titles = {

        dashboard: "Dashboard",
        payments: "Payments",
        recharge: "Recharge",
        bills: "Bills",
        loans: "Loans",
        insurance: "Insurance",
        investments: "Investments",
        transactions: "Transactions",
        profile: "My Profile"

    };

    document.getElementById("pageTitle")
        .textContent =
        titles[sectionID] || "Dashboard";

}


// =====================================================
// SEND MONEY
// =====================================================

async function sendMoney(event) {

    event.preventDefault();

    const receiverName =
        document.getElementById("receiverName")
            .value.trim();

    const receiverPhone =
        document.getElementById("receiverPhone")
            .value.trim();

    const receiverUPI =
        document.getElementById("receiverUPI")
            .value.trim();

    const amount =
        Number(
            document.getElementById("paymentAmount")
                .value
        );

    const note =
        document.getElementById("paymentNote")
            .value.trim();


    const {
        error
    } = await supabaseClient
        .from("money_transfers")
        .insert({

            user_id: currentUser.id,

            receiver_name: receiverName,

            receiver_phone: receiverPhone,

            receiver_upi: receiverUPI,

            amount: amount,

            transfer_note: note,

            status: "completed"

        });


    if (error) {

        alert(error.message);
        return;

    }


    await addTransaction(
        "Money Transfer",
        receiverName,
        amount,
        "debit"
    );


    alert("Money transfer saved successfully.");

    document.getElementById("paymentForm")
        .reset();

    await loadTransactions();

}


// =====================================================
// RECHARGE
// =====================================================

async function rechargeMobile(event) {

    event.preventDefault();

    const mobile =
        document.getElementById("rechargePhone")
            .value.trim();

    const operator =
        document.getElementById("operator")
            .value;

    const plan =
        document.getElementById("planName")
            .value.trim();

    const amount =
        Number(
            document.getElementById("rechargeAmount")
                .value
        );


    const {
        error
    } = await supabaseClient
        .from("recharges")
        .insert({

            user_id: currentUser.id,

            mobile_number: mobile,

            operator: operator,

            plan_name: plan,

            amount: amount,

            status: "completed"

        });


    if (error) {

        alert(error.message);
        return;

    }


    await addTransaction(
        "Mobile Recharge",
        operator + " - " + mobile,
        amount,
        "debit"
    );


    alert("Recharge saved successfully.");

    document.getElementById("rechargeForm")
        .reset();

    await loadTransactions();

}


// =====================================================
// BILL PAYMENT
// =====================================================

async function payBill(event) {

    event.preventDefault();

    const billType =
        document.getElementById("billType")
            .value;

    const provider =
        document.getElementById("providerName")
            .value.trim();

    const consumer =
        document.getElementById("consumerNumber")
            .value.trim();

    const amount =
        Number(
            document.getElementById("billAmount")
                .value
        );


    const {
        error
    } = await supabaseClient
        .from("bill_payments")
        .insert({

            user_id: currentUser.id,

            bill_type: billType,

            provider_name: provider,

            consumer_number: consumer,

            amount: amount,

            status: "completed"

        });


    if (error) {

        alert(error.message);
        return;

    }


    await addTransaction(
        "Bill Payment",
        billType,
        amount,
        "debit"
    );


    alert("Bill payment saved successfully.");

    document.getElementById("billForm")
        .reset();

    await loadTransactions();

}


// =====================================================
// CASH LOAN
// =====================================================

async function applyCashLoan(event) {

    event.preventDefault();

    const amount =
        Number(
            document.getElementById("cashLoanAmount")
                .value
        );

    const interest =
        Number(
            document.getElementById("cashInterest")
                .value
        ) || null;

    const tenure =
        Number(
            document.getElementById("cashTenure")
                .value
        ) || null;

    const purpose =
        document.getElementById("cashPurpose")
            .value.trim();


    const {
        error
    } = await supabaseClient
        .from("cash_loans")
        .insert({

            user_id: currentUser.id,

            loan_amount: amount,

            interest_rate: interest,

            tenure_months: tenure,

            purpose: purpose,

            status: "applied"

        });


    if (error) {

        alert(error.message);
        return;

    }


    alert("Cash loan application saved.");

    document.getElementById("cashLoanForm")
        .reset();

}


// =====================================================
// HOME LOAN
// =====================================================

async function applyHomeLoan(event) {

    event.preventDefault();

    const amount =
        Number(
            document.getElementById("homeLoanAmount")
                .value
        );

    const propertyValue =
        Number(
            document.getElementById("propertyValue")
                .value
        ) || null;

    const interest =
        Number(
            document.getElementById("homeInterest")
                .value
        ) || null;

    const tenure =
        Number(
            document.getElementById("homeTenure")
                .value
        ) || null;

    const location =
        document.getElementById("propertyLocation")
            .value.trim();


    const {
        error
    } = await supabaseClient
        .from("home_loans")
        .insert({

            user_id: currentUser.id,

            loan_amount: amount,

            property_value: propertyValue,

            interest_rate: interest,

            tenure_years: tenure,

            property_location: location,

            status: "applied"

        });


    if (error) {

        alert(error.message);
        return;

    }


    alert("Home loan application saved.");

    document.getElementById("homeLoanForm")
        .reset();

}


// =====================================================
// INSURANCE
// =====================================================

async function addInsurance(event) {

    event.preventDefault();

    const type =
        document.getElementById("insuranceType")
            .value;

    const policy =
        document.getElementById("policyName")
            .value.trim();

    const premium =
        Number(
            document.getElementById("premiumAmount")
                .value
        ) || null;

    const coverage =
        Number(
            document.getElementById("coverageAmount")
                .value
        ) || null;

    const startDate =
        document.getElementById("insuranceStart")
            .value || null;

    const endDate =
        document.getElementById("insuranceEnd")
            .value || null;


    const policyNumber =
        "NP-" +
        Date.now();


    const {
        error
    } = await supabaseClient
        .from("insurance_policies")
        .insert({

            user_id: currentUser.id,

            insurance_type: type,

            policy_name: policy,

            policy_number: policyNumber,

            premium_amount: premium,

            coverage_amount: coverage,

            start_date: startDate,

            end_date: endDate,

            status: "active"

        });


    if (error) {

        alert(error.message);
        return;

    }


    alert(
        "Insurance saved.\nPolicy No: " +
        policyNumber
    );

    document.getElementById("insuranceForm")
        .reset();

}


// =====================================================
// MUTUAL FUND INVESTMENT
// =====================================================

async function makeInvestment(event) {

    event.preventDefault();

    const fund =
        document.getElementById("fundName")
            .value.trim();

    const category =
        document.getElementById("fundCategory")
            .value;

    const type =
        document.getElementById("investmentType")
            .value;

    const amount =
        Number(
            document.getElementById("investmentAmount")
                .value
        );

    const units =
        Number(
            document.getElementById("investmentUnits")
                .value
        ) || null;

    const nav =
        Number(
            document.getElementById("investmentNAV")
                .value
        ) || null;


    const {
        error
    } = await supabaseClient
        .from("investments")
        .insert({

            user_id: currentUser.id,

            fund_name: fund,

            fund_category: category,

            investment_type: type,

            amount: amount,

            units: units,

            nav: nav,

            status: "active"

        });


    if (error) {

        alert(error.message);
        return;

    }


    await addTransaction(
        "Mutual Fund",
        fund,
        amount,
        "debit"
    );


    alert("Investment saved successfully.");

    document.getElementById("investmentForm")
        .reset();

    await loadTransactions();

}


// =====================================================
// SIP
// =====================================================

async function startSIP(event) {

    event.preventDefault();

    const fund =
        document.getElementById("sipFundName")
            .value.trim();

    const amount =
        Number(
            document.getElementById("sipAmount")
                .value
        );

    const sipDate =
        Number(
            document.getElementById("sipDate")
                .value
        ) || null;

    const startDate =
        document.getElementById("sipStartDate")
            .value || null;

    const nextDate =
        document.getElementById("sipNextDate")
            .value || null;


    const {
        error
    } = await supabaseClient
        .from("sips")
        .insert({

            user_id: currentUser.id,

            fund_name: fund,

            monthly_amount: amount,

            sip_date: sipDate,

            start_date: startDate,

            next_payment_date: nextDate,

            status: "active"

        });


    if (error) {

        alert(error.message);
        return;

    }


    alert("SIP created successfully.");

    document.getElementById("sipForm")
        .reset();

}


// =====================================================
// ADD GENERAL TRANSACTION
// =====================================================

async function addTransaction(
    type,
    description,
    amount,
    direction
) {

    const reference =
        "TXN-" + Date.now();


    const {
        error
    } = await supabaseClient
        .from("transactions")
        .insert({

            user_id: currentUser.id,

            transaction_type: type,

            description: description,

            amount: amount,

            direction: direction,

            reference_id: reference,

            status: "completed"

        });


    if (error) {

        console.error(
            "Transaction error:",
            error
        );

    }

}


// =====================================================
// LOAD TRANSACTIONS
// =====================================================

async function loadTransactions() {

    const {
        data,
        error
    } = await supabaseClient
        .from("transactions")
        .select("*")
        .eq("user_id", currentUser.id)
        .order("created_at", {
            ascending: false
        });


    if (error) {

        console.error(error);
        return;

    }


    const list =
        document.getElementById("transactionList");

    const recent =
        document.getElementById("recentTransactions");


    if (!data || data.length === 0) {

        list.innerHTML =
            '<p class="empty">No transactions found.</p>';

        recent.innerHTML =
            '<p class="empty">No transactions yet.</p>';

        return;

    }


    list.innerHTML =
        data.map(transaction =>
            transactionHTML(transaction)
        ).join("");


    recent.innerHTML =
        data
            .slice(0, 5)
            .map(transaction =>
                transactionHTML(transaction)
            )
            .join("");

}


// =====================================================
// TRANSACTION HTML
// =====================================================

function transactionHTML(transaction) {

    const isCredit =
        transaction.direction === "credit";

    const sign =
        isCredit ? "+" : "-";

    const icon =
        getTransactionIcon(
            transaction.transaction_type
        );


    const date =
        new Date(
            transaction.created_at
        ).toLocaleString(
            "en-IN",
            {
                dateStyle: "medium",
                timeStyle: "short"
            }
        );


    return `

        <div class="transaction">

            <div class="transaction-left">

                <div class="transaction-icon">
                    ${icon}
                </div>

                <div>

                    <div class="transaction-title">
                        ${escapeHTML(
                            transaction.transaction_type
                        )}
                    </div>

                    <div class="transaction-date">
                        ${escapeHTML(
                            transaction.description || ""
                        )}
                        <br>
                        ${date}
                    </div>

                </div>

            </div>

            <strong class="${isCredit ? "credit" : "debit"}">

                ${sign} ₹${Number(
                    transaction.amount
                ).toFixed(2)}

            </strong>

        </div>

    `;

}


// =====================================================
// TRANSACTION ICON
// =====================================================

function getTransactionIcon(type) {

    if (type.includes("Recharge")) {
        return "📱";
    }

    if (type.includes("Bill")) {
        return "💡";
    }

    if (type.includes("Transfer")) {
        return "💸";
    }

    if (type.includes("Mutual")) {
        return "📈";
    }

    return "💰";

}


// =====================================================
// HTML SECURITY
// =====================================================

function escapeHTML(value) {

    return String(value)
        .replaceAll("&", "&amp;")
        .replaceAll("<", "&lt;")
        .replaceAll(">", "&gt;")
        .replaceAll('"', "&quot;")
        .replaceAll("'", "&#039;");

}


// =====================================================
// LOGOUT
// =====================================================

async function logout() {

    await supabaseClient.auth.signOut();

    currentUser = null;

    showAuthPage();

    showLogin();

}


// =====================================================
// AUTH STATE
// =====================================================

supabaseClient.auth.onAuthStateChange(
    async (event, session) => {

        if (session) {

            currentUser = session.user;

        } else {

            currentUser = null;

        }

    }
);


// =====================================================
// FORM SETUP
// =====================================================

function setupForms() {

    document.getElementById("loginForm")
        .addEventListener(
            "submit",
            loginUser
        );


    document.getElementById("signupForm")
        .addEventListener(
            "submit",
            signupUser
        );


    document.getElementById("paymentForm")
        .addEventListener(
            "submit",
            sendMoney
        );


    document.getElementById("rechargeForm")
        .addEventListener(
            "submit",
            rechargeMobile
        );


    document.getElementById("billForm")
        .addEventListener(
            "submit",
            payBill
        );


    document.getElementById("cashLoanForm")
        .addEventListener(
            "submit",
            applyCashLoan
        );


    document.getElementById("homeLoanForm")
        .addEventListener(
            "submit",
            applyHomeLoan
        );


    document.getElementById("insuranceForm")
        .addEventListener(
            "submit",
            addInsurance
        );


    document.getElementById("investmentForm")
        .addEventListener(
            "submit",
            makeInvestment
        );


    document.getElementById("sipForm")
        .addEventListener(
            "submit",
            startSIP
        );

}


// =====================================================
// AUTH MESSAGE
// =====================================================

function setAuthMessage(
    message,
    isError = false
) {

    const element =
        document.getElementById("authMessage");

    element.textContent = message;

    element.style.color =
        isError ? "#d73535" : "#087f45";

}


function clearAuthMessage() {

    document.getElementById("authMessage")
        .textContent = "";

}

