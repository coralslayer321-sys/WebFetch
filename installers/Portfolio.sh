#!/bin/bash

# --- Cinematic UI ---
CYAN='\033[0;36m'
WHITE='\033[1;37m'
GREEN='\033[0;32m'
RESET='\033[0m'

clear
echo -e "${CYAN}================================================================${RESET}"
echo -e "${WHITE}              WEB-FETCH: PORTFOLIO DEPLOYER v8.9                ${RESET}"
echo -e "${CYAN}================================================================${RESET}"

# --- Forced Inputs for VPS ---
read -p "[?] Enter Full Name: " P_NAME < /dev/tty
read -p "[?] Enter Profession: " P_JOB < /dev/tty
read -p "[?] GitHub Profile Link: " P_GH < /dev/tty
read -p "[?] Enter PFP Image Link: " P_PFP < /dev/tty
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
            .box { text-align: center; backdrop-filter: blur(25px); background: rgba(255,255,255,0.03); padding: 60px; border-radius: 40px; border: 1px solid rgba(255,255,255,0.1); width: 450px; box-shadow: 0 20px 50px rgba(0,0,0,0.5); }
            .pfp-img { width: 120px; height: 120px; border-radius: 50%; border: 4px solid #38bdf8; margin-bottom: 25px; object-fit: cover; box-shadow: 0 0 20px rgba(56,189,248,0.3); }
            h1 { font-size: 55px; margin: 0; font-weight: 900; letter-spacing: -2px; line-height: 1; }
            p { font-size: 18px; color: #38bdf8; text-transform: uppercase; letter-spacing: 6px; margin: 20px 0; font-weight: 300; }
            .btn { display: inline-block; margin-top: 30px; padding: 18px 60px; background: #38bdf8; color: black; text-decoration: none; font-weight: 900; border-radius: 50px; transition: 0.4s ease; text-transform: uppercase; font-size: 16px; letter-spacing: 2px; }
            .btn:hover { transform: translateY(-5px); box-shadow: 0 10px 30px rgba(56,189,248,0.6); background: #fff; }
            footer { position: absolute; bottom: 30px; width: 100%; text-align: center; font-size: 13px; color: rgba(255,255,255,0.2); letter-spacing: 2px; }
        </style>
    </head>
    <body>
        <div class="box">
            <img src="$P_PFP" class="pfp-img" alt="Profile">
            <h1>$P_NAME</h1>
            <p>$P_JOB</p>
            <a href="$P_GH" class="btn">Github</a>
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
echo -e "${GREEN}SUCCESS! Portfolio v8.9 is ready.${RESET}"
echo -e "Run: ${WHITE}npm start${RESET}"
echo -e "----------------------------------------------------------------"
