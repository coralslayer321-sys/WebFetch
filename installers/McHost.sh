#!/bin/bash

# --- Cinematic Colors ---
CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
WHITE='\033[1;37m'
RESET='\033[0m'

clear
echo -e "${CYAN}================================================================${RESET}"
echo -e "${WHITE}              WEBFETCH v8.0: STABLE INJECTION                   ${RESET}"
echo -e "${CYAN}================================================================${RESET}"

# --- Phase 1: Reliable Inputs ---
read -p "Brand Name: " U_NAME
read -p "Discord Link: " DURL
read -p "Home Page YT Link: " HOME_BG
read -p "Pricing Page Image Link: " PRICE_BG

# Extract YouTube ID safely
VID=$(echo $HOME_BG | sed -n 's/.*v=\([^&]*\).*/\1/p')
[ -z "$VID" ] && VID=$(echo $HOME_BG | sed -n 's/.*youtu.be\/\([^?]*\).*/\1/p')

# --- Phase 2: Building the Script with Variables Directly ---
# This method is better than sed because it doesn't break on special characters in URLs
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
            .spec { background: rgba(255,255,255,0.03); margin: 10px 0; padding: 12px; border-radius: 8px; font-size: 13px; color: #ccc; }
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
                <div class="card"><h3>Starter</h3><h2>₹200</h2><div class="spec">4GB RAM</div><a href="$DURL" class="btn">Order Now</a></div>
                <div class="card" style="border-color:#38bdf8"><h3>Growth</h3><h2>₹300</h2><div class="spec">6GB RAM</div><a href="$DURL" class="btn">Order Now</a></div>
                <div class="card"><h3>Pro</h3><h2>₹500</h2><div class="spec">12GB RAM</div><a href="$DURL" class="btn">Order Now</a></div>
                <div class="card"><h3>Advanced</h3><h2>₹900</h2><div class="spec">24GB RAM</div><a href="$DURL" class="btn">Order Now</a></div>
                <div class="card"><h3>Ultra</h3><h2>₹1100</h2><div class="spec">32GB RAM</div><a href="$DURL" class="btn">Order Now</a></div>
            </div>
        </div>
    \` + footer);
});

app.listen(3000);
EOF

# --- Phase 3: Finalizing ---
cat << 'EOF' > package.json
{
  "name": "webfetch-fix",
  "version": "8.0.0",
  "main": "index.js",
  "scripts": { "start": "node index.js" },
  "dependencies": { "express": "^4.18.2" }
}
EOF

npm install --quiet
echo -e "\n${GREEN}FIX APPLIED! Run 'npm start' now.${RESET}"
