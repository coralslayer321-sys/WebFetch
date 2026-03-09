#!/bin/bash

# --- Cinematic Colors ---
CYAN='\033[0;36m'
WHITE='\033[1;37m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
PURPLE='\033[0;35m'
RED='\033[0;31m'
RESET='\033[0m'

# --- The "Professional Delay" Function ---
slow_log() {
    local message=$1
    local count=$2
    echo -e "${PURPLE}[ CACHE ] ${message}...${RESET}"
    for ((i=1; i<=count; i++)); do
        echo -e "${CYAN}  └─> Processing Data Packet #$((RANDOM % 900 + 100))X-${i}... [OK]${RESET}"
        sleep 1.2 # Increased delay for a longer video
    done
}

# --- The Confirmation Gate ---
confirm_step() {
    local step_name=$1
    echo -e "\n${YELLOW}[!] PENDING: ${step_name}${RESET}"
    read -p "Are You Sure To Continue [Y/n]: " choice < /dev/tty
    case "$choice" in 
      y|Y ) echo -e "${GREEN}[+] Step Confirmed.${RESET}\n";;
      * ) echo -e "${RED}[-] Deployment Aborted by User.${RESET}"; exit 1;;
    esac
}

clear
echo -e "${CYAN}================================================================${RESET}"
echo -e "${WHITE}              WEBFETCH v9.8: ENTERPRISE GATEKEEPER              ${RESET}"
echo -e "${CYAN}================================================================${RESET}"

# --- Configuration Phase ---
read -p "[CONFIG] Brand Name: " U_NAME < /dev/tty
read -p "[CONFIG] Discord Link: " DURL < /dev/tty
read -p "[CONFIG] Home Page YT Link: " HOME_BG < /dev/tty
read -p "[CONFIG] Pricing Page Image Link: " PRICE_BG < /dev/tty

# Extract YouTube ID safely
VID=$(echo $HOME_BG | sed -n 's/.*v=\([^&]*\).*/\1/p')
[ -z "$VID" ] && VID=$(echo $HOME_BG | sed -n 's/.*youtu.be\/\([^?]*\).*/\1/p')

echo -e "\n${RED}[ WARNING ] INITIALIZING ROOT DEPLOYMENT PROTOCOL...${RESET}"
confirm_step "System Kernel Access"

# --- Phase 1: Storage & Logic ---
slow_log "Scanning NVMe Partition Clusters" 6
confirm_step "Commit Changes to Disk"

# --- Phase 2: Runtime Optimization ---
slow_log "Optimizing Node.js V8 Cluster Performance" 8
confirm_step "Verify Runtime Environment"

# --- Phase 3: Network Handshake ---
slow_log "Establishing Encrypted Handshake with Discord CDN" 5
slow_log "Synchronizing YouTube Global Video Buffers" 7
confirm_step "Finalize Network Configuration"

# --- Phase 4: UI Injection ---
slow_log "Injecting Custom CSS Glassmorphism Engine" 10
confirm_step "Apply Visual Styles"

echo -e "\n${WHITE}WRITING CORE APPLICATION FILES...${RESET}"

# --- File Generation ---
cat << EOF > package.json
{
  "name": "webfetch-enterprise",
  "version": "1.0.0",
  "main": "index.js",
  "scripts": { "start": "node index.js" }
}
EOF

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
            body { margin:0; font-family: 'Poppins', sans-serif; background:#080808; color:white; display: flex; flex-direction: column; min-height: 100vh; }
            nav { display:flex; justify-content:space-between; align-items:center; padding: 20px 10%; background: rgba(0,0,0,0.9); position:fixed; width:80%; z-index:100; border-bottom: 1px solid #222; }
            .logo { font-weight:900; font-size:24px; color:#fff; text-decoration:none; }
            .nav-links a { margin-left:25px; text-decoration:none; color:#bbb; font-size:12px; text-transform:uppercase; font-weight:600; }
            .hero { height:90vh; display:flex; align-items:center; justify-content:center; position:relative; overflow:hidden; flex: 1; }
            .video-bg iframe { position:absolute; top:50%; left:50%; width:100vw; height:56.25vw; min-height:100vh; min-width:177.77vh; transform:translate(-50%, -50%); filter:brightness(25%); pointer-events:none; }
            .pricing-section { 
                background: linear-gradient(rgba(0,0,0,0.7), rgba(0,0,0,0.7)), url('$PRICE_BG'); 
                background-size: cover; background-position: center; background-attachment: fixed;
                min-height: 85vh; padding: 150px 5% 50px; flex: 1;
            }
            .pricing-grid { display: flex; flex-wrap: wrap; justify-content: center; gap: 20px; }
            .card { background: rgba(10, 10, 10, 0.9); backdrop-filter: blur(15px); border: 1px solid rgba(255,255,255,0.1); border-radius: 15px; width: 240px; padding: 35px 20px; text-align: center; }
            .card h2 { font-size: 36px; color: #38bdf8; }
            .btn { display:block; margin-top:20px; padding:14px; background:#38bdf8; color:#000; text-decoration:none; font-weight:900; border-radius:8px; }
            footer { background: #000; padding: 30px; text-align: center; border-top: 1px solid #111; color: #555; font-size: 14px; }
        </style>
    </head>
    <body>
        <nav>
            <a href="/" class="logo">$U_NAME</a>
            <div class="nav-links"><a href="/">Home</a><a href="/pricing">Pricing</a><a href="$DURL">Discord</a></div>
        </nav>
\`;

const footer = \`
        <footer>
            <p>© All Rights Reserved 2026 WebFetch</p>
        </footer>
    </body></html>\`;

app.get('/', (req, res) => {
    res.send(header('Home') + \`
        <div class="hero">
            <div class="video-bg" style="position:absolute; top:0; left:0; width:100%; height:100%; z-index:-1;">
                <iframe src="https://www.youtube.com/embed/$VID?autoplay=1&mute=1&loop=1&playlist=$VID&controls=0" frameborder="0"></iframe>
            </div>
            <div style="z-index:1; text-align:center;">
                <h1 style="font-size:90px; margin:0; font-weight:900; letter-spacing:-3px;">$U_NAME</h1>
                <p style="color:#38bdf8; font-size:24px; text-transform:uppercase; letter-spacing:5px;">Premium Hosting</p>
            </div>
        </div>
    \` + footer);
});

app.get('/pricing', (req, res) => {
    res.send(header('Pricing') + \`
        <div class="pricing-section">
            <h2 style="text-align:center; font-size:40px; margin-bottom:50px; font-weight:900;">CHOOSE YOUR PLAN</h2>
            <div class="pricing-grid">
                <div class="card"><h3>Starter</h3><h2>₹200</h2><a href="$DURL" class="btn">Order Now</a></div>
                <div class="card" style="border-color:#38bdf8"><h3>Growth</h3><h2>₹300</h2><a href="$DURL" class="btn">Order Now</a></div>
                <div class="card"><h3>Pro</h3><h2>₹500</h2><a href="$DURL" class="btn">Order Now</a></div>
            </div>
        </div>
    \` + footer);
});

app.listen(3000);
EOF

# --- Final Dependency Injection ---
echo -e "${YELLOW}Injecting final dependencies...${RESET}"
npm install express --quiet

echo -e "\n----------------------------------------------------------------"
echo -e "${GREEN}DEPLOYMENT SUCCESSFUL: System ID: WEB-$(date +%s)${RESET}"
echo -e "Run: ${WHITE}npm start${RESET}"
echo -e "----------------------------------------------------------------"
