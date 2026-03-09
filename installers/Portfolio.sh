#!/bin/bash

# --- Cinematic UI ---
CYAN='\033[0;36m'
WHITE='\033[1;37m'
GREEN='\033[0;32m'
RESET='\033[0m'

clear
echo -e "${CYAN}================================================================${RESET}"
echo -e "${WHITE}              WEB-FETCH: PORTFOLIO DEPLOYER v8.5                ${RESET}"
echo -e "${CYAN}================================================================${RESET}"

# --- Forced Inputs ---
read -p "[?] Enter Full Name: " P_NAME < /dev/tty
read -p "[?] Enter Profession: " P_JOB < /dev/tty
read -p "[?] GitHub Profile Link: " P_GH < /dev/tty
read -p "[?] Enter Logo Image Link: " P_LOGO < /dev/tty
read -p "[?] Background Image Link: " P_BG < /dev/tty

echo -e "\n${WHITE}Deploying Files...${RESET}"

# --- Create Package.JSON ---
cat << EOF > package.json
{
  "name": "webfetch-portfolio",
  "version": "1.0.0",
  "main": "index.js",
  "scripts": { "start": "node index.js" }
}
EOF

# --- Portfolio Generation ---
cat << EOF > index.js
const express = require('express');
const app = express();

app.get('/', (req, res) => {
    res.send(\`
    <!DOCTYPE html>
    <html>
    <head>
        <title>$P_NAME | Portfolio</title>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;900&display=swap');
            body { 
                margin:0; font-family: 'Poppins', sans-serif; 
                background: linear-gradient(rgba(0,0,0,0.7), rgba(0,0,0,0.7)), url('$P_BG');
                background-size: cover; background-position: center; background-repeat: no-repeat;
                height: 100vh; display: flex; align-items: center; justify-content: center; color: white;
            }
            .box { text-align: center; backdrop-filter: blur(20px); background: rgba(255,255,255,0.05); padding: 50px; border-radius: 30px; border: 1px solid rgba(255,255,255,0.1); width: 400px; }
            .logo-img { width: 100px; height: 100px; border-radius: 50%; border: 3px solid #38bdf8; margin-bottom: 20px; object-fit: cover; }
            h1 { font-size: 50px; margin: 0; font-weight: 900; letter-spacing: -2px; line-height: 1; }
            p { font-size: 18px; color: #38bdf8; text-transform: uppercase; letter-spacing: 5px; margin: 15px 0; }
            .btn { display: inline-block; margin-top: 25px; padding: 15px 35px; background: #38bdf8; color: black; text-decoration: none; font-weight: 900; border-radius: 50px; transition: 0.3s; }
            .btn:hover { transform: scale(1.05); box-shadow: 0 0 20px rgba(56,189,248,0.4); }
            footer { position: absolute; bottom: 30px; width: 100%; text-align: center; font-size: 14px; color: rgba(255,255,255,0.3); }
        </style>
    </head>
    <body>
        <div class="box">
            <img src="$P_LOGO" class="logo-img" alt="Logo">
            <h1>$P_NAME</h1>
            <p>$P_JOB</p>
            <a href="$P_GH" class="btn">PORTFOLIO GITHUB</a>
        </div>
        <footer>© 2026 WebFetch. All Rights Reserved</footer>
    </body>
    </html>\`);
});

app.listen(3000);
EOF

# --- Modules ---
echo -e "${WHITE}Installing modules...${RESET}"
npm install express --quiet

echo -e "\n----------------------------------------------------------------"
echo -e "${GREEN}SUCCESS! Portfolio v8.5 is ready.${RESET}"
echo -e "Run: ${WHITE}npm start${RESET}"
echo -e "----------------------------------------------------------------"
