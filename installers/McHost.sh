#!/bin/bash

# --- Cinematic Colors ---
CYAN='\033[0;36m'
GREEN='\033[0;32m'
WHITE='\033[1;37m'
RESET='\033[0m'

clear
echo -e "${CYAN}================================================================${RESET}"
echo -e "${WHITE}              WEBFETCH v8.2: Hosting Installer                 ${RESET}"
echo -e "${CYAN}================================================================${RESET}"

# --- Phase 1: Forced Interactive Inputs ---
# We use < /dev/tty to ensure it asks for input even when piped
read -p "Brand Name: " U_NAME < /dev/tty
read -p "Discord Link: " DURL < /dev/tty
read -p "Home Page YT Link: " HOME_BG < /dev/tty
read -p "Pricing Page Image Link: " PRICE_BG < /dev/tty

# Extract YouTube ID safely
VID=$(echo $HOME_BG | sed -n 's/.*v=\([^&]*\).*/\1/p')
[ -z "$VID" ] && VID=$(echo $HOME_BG | sed -n 's/.*youtu.be\/\([^?]*\).*/\1/p')

echo -e "\n${CYAN}CONFIGURING WEB SERVER FOR $U_NAME...${RESET}\n"

# --- Phase 2: Building the App ---
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
            .spec { background: rgba(255
