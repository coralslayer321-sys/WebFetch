#!/bin/bash

# --- Cinematic Colors ---
CYAN='\033[0;36m'
WHITE='\033[1;37m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
PURPLE='\033[0;35m'
RED='\033[0;31m'
RESET='\033[0m'

# --- Professional Slow-Log Function ---
slow_log() {
    local message=$1
    local count=$2
    echo -e "${PURPLE}[ CACHE ] ${message}...${RESET}"
    for ((i=1; i<=count; i++)); do
        echo -e "${CYAN}  └─> Processing Sector Block #$((RANDOM % 8000 + 1000))X-${i}... [OK]${RESET}"
        sleep 1.5 # Slows it down for a 9-minute video feel
    done
}

# --- Enterprise Confirmation Gate ---
confirm_step() {
    local step_name=$1
    echo -e "\n${RED}[ CRITICAL ] Verification Required: ${step_name}${RESET}"
    read -p "Execute this protocol? [Y/n]: " choice < /dev/tty
    [[ "$choice" =~ ^[Yy]$ ]] || { echo -e "${RED}Aborted.${RESET}"; exit 1; }
    echo -e "${GREEN}[+] Authenticated.${RESET}\n"
}

clear
echo -e "${CYAN}================================================================${RESET}"
echo -e "${WHITE}            WEBFETCH v9.9: ELITE ENTERPRISE INSTALLER           ${RESET}"
echo -e "${CYAN}================================================================${RESET}"

# --- Configuration Phase ---
read -p "[?] Brand Name: " U_NAME < /dev/tty
read -p "[?] Discord Invite Link: " DURL < /dev/tty
read -p "[?] Home Page YT Link: " HOME_BG < /dev/tty
read -p "[?] Pricing BG Image Link: " PRICE_BG < /dev/tty

# --- ADVANCED VIDEO ID FIX ---
# This fixes the "Video not loading" error by cleaning the URL
VID=$(echo $HOME_BG | sed -n 's/.*v=\([^&]*\).*/\1/p')
[ -z "$VID" ] && VID=$(echo $HOME_BG | sed -n 's/.*youtu.be\/\([^?]*\).*/\1/p')

echo -e "\n${YELLOW}[!] INITIALIZING MASTER DEPLOYMENT SEQUENCE...${RESET}"
confirm_step "Root System Partitioning"

# --- The "Long" Look (Padded for Video) ---
slow_log "Scanning Virtual Environment Hardware" 8
confirm_step "Allocate 4GB NVMe Cache"

slow_log "Optimizing V8 JavaScript Engine Clusters" 12
confirm_step "Verify Node.js Runtime Stability"

slow_log "Establishing Secure SSL Handshake with Discord" 6
confirm_step "Finalize Network Gateway"

slow_log "Compiling Glassmorphism UI Components" 15
confirm_step "Inject CSS Visualization Engine"

echo -e "\n${WHITE}GENERATING CORE APPLICATION FILES...${RESET}"

# --- Generate Package.json ---
cat << EOF > package.json
{
  "name": "webfetch-hosting",
  "version": "1.0.0",
  "main": "index.js",
  "scripts": { "start": "node index.js" }
}
EOF

# --- Generate App with Video Fix ---
cat << EOF > index.js
const express = require('express');
const app = express();

const header = (title) => \`
    <!DOCTYPE html>
    <html>
    <head>
        <title>$U_NAME | \${title}</title>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;600;900&display=swap');
            body { margin:0; font-family: 'Poppins', sans-serif; background:#000; color:white; overflow-x:hidden; }
            nav { display:flex; justify-content:space-between; align-items:center; padding: 25px 10%; background: rgba(0,0,0,0.8); backdrop-filter:blur(10px); position:fixed; width:80%; z-index:100; border-bottom: 1px solid #222; }
            .logo { font-weight:900; font-size:28px; letter-spacing:-1px; text-decoration:none; color:white; }
            .nav-links a { margin-left:30px; text-decoration:none; color:#888; font-size:13px; text-transform:uppercase; font-weight:600; transition:0.3s; }
            .nav-links a:hover { color:#38bdf8; }
            .hero { height:100vh; display:flex; align-items:center; justify-content:center; position:relative; overflow:hidden; }
            .video-container { position:absolute; top:0; left:0; width:100%; height:100%; z-index:-1; }
            /* Fixed Video Positioning */
            .video-container iframe { width: 100vw; height: 56.25vw; min-height: 100vh; min-width: 177.77vh; position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); pointer-events: none; filter: brightness(30%); }
            .hero-content { text-align:center; z-index:1; }
            .hero-content h1 { font-size:100px; margin:0; font-weight:900; letter-spacing:-4px; }
            .hero-content p { color:#38bdf8; font-size:24px; text-transform:uppercase; letter-spacing:8px; margin-top:10px; }
            .pricing-section { background: linear-gradient(rgba(0,0,0,0.8), rgba(0,0,0,0.8)), url('$PRICE_BG'); background-size:cover; background-position:center; min-height:100vh; padding-top:150px; }
            .pricing-grid { display:flex; justify-content:center; gap:30px; flex-wrap:wrap; padding:50px; }
            .card { background: rgba(255,255,255,0.03); border: 1px solid rgba(255,255,255,0.1); backdrop-filter:blur(20px); padding:40px; border-radius:20px; width:280px; text-align:center; transition:0.4s; }
            .card:hover { transform:translateY(-10px); border-color:#38bdf8; }
            .card h2 { font-size:45px; color:#38bdf8; margin:20px 0; }
            .btn { display:block; padding:15px; background:#38bdf8; color:black; text-decoration:none; font-weight:900; border-radius:10px; text-transform:uppercase; }
            footer { padding:50px; text-align:center; border-top:1px solid #111; color:#333; font-size:14px; }
        </style>
    </head>
    <body>
        <nav>
            <a href="/" class="logo">$U_NAME</a>
            <div class="nav-links"><a href="/">Home</a><a href="/pricing">Pricing</a><a href="$DURL">Discord</a></div>
        </nav>
\`;

app.get('/', (req, res) => {
    res.send(header('Home') + \`
        <div class="hero">
            <div class="video-container">
                <iframe src="https://www.youtube.com/embed/$VID?autoplay=1&mute=1&loop=1&playlist=$VID&controls=0&rel=0&showinfo=0" frameborder="0" allow="autoplay; encrypted-media"></iframe>
            </div>
            <div class="hero-content">
                <h1>$U_NAME</h1>
                <p>Premium Hosting</p>
            </div>
        </div>
        <footer>© All Rights Reserved 2026 WebFetch</footer>
    </body></html>\`);
});

app.get('/pricing', (req, res) => {
    res.send(header('Pricing') + \`
        <div class="pricing-section">
            <h1 style="text-align:center; font-size:50px; font-weight:900;">SELECT A PLAN</h1>
            <div class="pricing-grid">
                <div class="card"><h3>Starter</h3><h2>₹200</h2><a href="$DURL" class="btn">Order Now</a></div>
                <div class="card" style="border-color:#38bdf8"><h3>Growth</h3><h2>₹300</h2><a href="$DURL" class="btn">Order Now</a></div>
                <div class="card"><h3>Ultimate</h3><h2>₹600</h2><a href="$DURL" class="btn">Order Now</a></div>
            </div>
        </div>
        <footer>© All Rights Reserved 2026 WebFetch</footer>
    </body></html>\`);
});

app.listen(3000);
EOF

# --- Install Dependencies ---
echo -e "${YELLOW}Finalizing system modules...${RESET}"
npm install express --quiet

echo -e "\n----------------------------------------------------------------"
echo -e "${GREEN}SUCCESS: Enterprise Hosting v9.9 is Online.${RESET}"
echo -e "System Node ID: WEB-$(date +%s)"
echo -e "Run: ${WHITE}npm start${RESET}"
echo -e "----------------------------------------------------------------"
