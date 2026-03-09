#!/bin/bash

# --- Cinematic Colors ---
CYAN='\033[0;36m'
WHITE='\033[1;37m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
PURPLE='\033[0;35m'
RED='\033[0;31m'
RESET='\033[0m'

# --- 9-Minute Progress Bar Function ---
# This bar moves slowly to fill 9 minutes of video time
draw_progress_bar() {
    local duration=540 # 9 minutes in seconds
    local width=50
    local start_time=$(date +%s)
    
    echo -e "${YELLOW}INITIALIZING SYSTEM FRAGMENTATION...${RESET}"
    
    while true; do
        local current_time=$(date +%s)
        local elapsed=$((current_time - start_time))
        local percent=$((elapsed * 100 / duration))
        local completed=$((elapsed * width / duration))
        local remaining=$((width - completed))
        
        if [ $percent -gt 100 ]; then break; fi
        
        # Draw the bar
        printf "\r${CYAN}[Enterprise] [${RESET}"
        printf "%${completed}s" | tr ' ' '█'
        printf "%${remaining}s" | tr ' ' '-'
        printf "${CYAN}] ${percent}%%${RESET} "
        
        # Add random professional logs every few seconds
        if (( elapsed % 15 == 0 )); then
            echo -e "\n${PURPLE}  └─> Writing Block #$((RANDOM % 9999)) to NVMe Sector... [SUCCESS]${RESET}"
        fi
        
        sleep 1
    done
    echo -e "\n${GREEN}[+] DEPLOYMENT ARCHITECTURE READY.${RESET}\n"
}

# --- Confirmation Gate ---
confirm_step() {
    local step_name=$1
    echo -e "\n${RED}[ CRITICAL ] Verification Required: ${step_name}${RESET}"
    read -p "Execute this protocol? [Y/n]: " choice < /dev/tty
    [[ "$choice" =~ ^[Yy]$ ]] || { echo -e "${RED}Aborted.${RESET}"; exit 1; }
}

clear
echo -e "${CYAN}================================================================${RESET}"
echo -e "${WHITE}            WEBFETCH v10.5: 9-MINUTE ENTERPRISE DEPLOY          ${RESET}"
echo -e "${CYAN}================================================================${RESET}"

# --- Configuration Phase ---
read -p "[?] Brand Name: " U_NAME < /dev/tty
read -p "[?] Discord Invite Link: " DURL < /dev/tty
read -p "[?] Home Page PNG Link: " HOME_BG < /dev/tty
read -p "[?] Pricing Page PNG Link: " PRICE_BG < /dev/tty

confirm_step "Master File System Overwrite"

# --- THE PROGRESS BAR ---
# This is the part that will last 9 minutes for your video
draw_progress_bar

echo -e "${WHITE}GENERATING CORE APPLICATION FILES...${RESET}"

# --- Generate Package.json ---
cat << EOF > package.json
{
  "name": "webfetch-hosting",
  "version": "1.0.0",
  "main": "index.js",
  "scripts": { "start": "node index.js" }
}
EOF

# --- Generate App ---
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
            .nav-links a { margin-left:30px; text-decoration:none; color:#888; font-size:13px; text-transform:uppercase; font-weight:600; }
            .hero { height:100vh; display:flex; align-items:center; justify-content:center; background: linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.6)), url('$HOME_BG'); background-size:cover; background-position:center; }
            .hero-content { text-align:center; z-index:1; }
            .hero-content h1 { font-size:100px; margin:0; font-weight:900; letter-spacing:-4px; }
            .hero-content p { color:#38bdf8; font-size:24px; text-transform:uppercase; letter-spacing:8px; margin-top:10px; }
            .pricing-section { background: linear-gradient(rgba(0,0,0,0.8), rgba(0,0,0,0.8)), url('$PRICE_BG'); background-size:cover; background-position:center; background-attachment: fixed; min-height:100vh; padding-top:150px; }
            .pricing-grid { display:flex; justify-content:center; gap:30px; flex-wrap:wrap; padding:50px; }
            .card { background: rgba(255,255,255,0.03); border: 1px solid rgba(255,255,255,0.1); backdrop-filter:blur(20px); padding:40px; border-radius:20px; width:280px; text-align:center; transition:0.4s; }
            .card h2 { font-size:45px; color:#38bdf8; margin:20px 0; }
            .btn { display:block; padding:15px; background:#38bdf8; color:black; text-decoration:none; font-weight:900; border-radius:10px; text-transform:uppercase; }
            footer { padding:50px; text-align:center; border-top:1px solid #111; color:#333; font-size:14px; }
        </style>
    </head>
    <body>
        <nav><a href="/" class="logo">$U_NAME</a><div class="nav-links"><a href="/">Home</a><a href="/pricing">Pricing</a><a href="$DURL">Discord</a></div></nav>
        <div class="hero"><div class="hero-content"><h1>$U_NAME</h1><p>Premium Hosting</p></div></div>
        <footer>© All Rights Reserved 2026 WebFetch</footer>
    </body></html>\`);

app.get('/', (req, res) => { res.send(header('Home')); });
app.get('/pricing', (req, res) => {
    res.send(header('Pricing') + \`
        <div class="pricing-section">
            <h1 style="text-align:center; font-size:50px; font-weight:900;">SELECT A PLAN</h1>
            <div class="pricing-grid">
                <div class="card"><h3>Starter</h3><h2>₹200</h2><a href="$DURL" class="btn">Order Now</a></div>
                <div class="card" style="border-color:#38bdf8"><h3>Growth</h3><h2>₹300</h2><a href="$DURL" class="btn">Order Now</a></div>
                <div class="card"><h3>Ultimate</h3><h2>₹600</h2><a href="$DURL" class="btn">Order Now</a></div>
            </div>
        </div>\`);
});
app.listen(3000);
EOF

# --- Install Dependencies ---
echo -e "${YELLOW}Finalizing system modules...${RESET}"
npm install express --quiet

echo -e "\n----------------------------------------------------------------"
echo -e "${GREEN}SUCCESS: PNG Enterprise Hosting is Online.${RESET}"
echo -e "System Node ID: WEB-$(date +%s)"
echo -e "Run: ${WHITE}npm start${RESET}"
echo -e "----------------------------------------------------------------"
