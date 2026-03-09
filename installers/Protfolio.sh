
#!/bin/bash



# --- Styling & Colors ---

CYAN='\033[0;36m'

GREEN='\033[0;32m'

YELLOW='\033[1;33m'

RED='\033[0;31m'

WHITE='\033[1;37m'

RESET='\033[0m'



clear

echo -e "${CYAN}"

echo "  __      __      ___.   ___________         __         .__     "

echo " /  \    /  \ ____\_ |__ \_   _____/_____  _/  |_  ____ |  |__  "

echo " \   \/\/   // __ \| __ \ |    __) \____ \ \   __\/ ___\|  |  \ "

echo "  \        /|  ___/| \_\ \|     \  |  |_> > |  | \  \___|   Y  \\"

echo "   \__/\  /  \___  >___  /\___  /  |   __/  |__|  \___  >___|  /"

echo "        \/       \/    \/     \/   |__|               \/     \/ "

echo -e "${WHITE}                      WEB-FETCH MULTI-DEPLOYER${RESET}"

echo "----------------------------------------------------------------"



# --- 1. Selection Menu ---

echo -e "${YELLOW}Select project to deploy:${RESET}"

echo -e "1) Portfolio Website"

echo -e "2) Reset Workspace"

read -p "Choice [1-2]: " choice



if [ "$choice" == "2" ]; then

    rm -rf node_modules package.json index.js server.js views public

    echo -e "${RED}Workspace Cleaned.${RESET}"

    exit

fi



# --- 2. Configuration ---

echo -e "\n${CYAN}[?] Configuration:${RESET}"

read -p "Your Name/Brand: " U_NAME

read -p "Your Role: " U_ROLE

read -p "Discord User ID: " U_DISCORD_ID

read -p "Discord Server Link: " U_SERVER_LINK

read -p "Animated Tab Title: " TAB_NAME

read -p "Logo/Image URL: " U_IMG

read -p "YouTube Video ID or Link: " BG_LINK



# Extract YouTube ID

if [[ "$BG_LINK" == *"v="* ]]; then

    VID_ID=$(echo $BG_LINK | sed -n 's/.*v=\([^&]*\).*/\1/p')

elif [[ "$BG_LINK" == *"youtu.be/"* ]]; then

    VID_ID=$(echo $BG_LINK | sed -n 's/.*youtu.be\/\([^?]*\).*/\1/p')

else

    VID_ID=$BG_LINK

fi



# --- 3. Deployment Logic ---

echo -e "${GREEN}Deploying Files...${RESET}"



cat << PACKAGE_EOF > package.json

{

  "name": "eaglenodes-deploy",

  "version": "1.0.0",

  "main": "index.js",

  "scripts": { "start": "node index.js" },

  "dependencies": { "express": "^4.18.2" }

}

PACKAGE_EOF



cat << INDEX_EOF > index.js

const express = require('express');

const app = express();

const port = 3000;



app.get('/', (req, res) => {

    res.send(\`

        <!DOCTYPE html>

        <html>

        <head>

            <title>$TAB_NAME</title>

            <style>

                body { margin:0; padding:0; overflow:hidden; font-family: 'Segoe UI', sans-serif; background:#000; color:white; }

                #entry-overlay { position:fixed; top:0; left:0; width:100%; height:100%; background:#000; z-index:1000; display:flex; align-items:center; justify-content:center; cursor:pointer; transition: 1s; }

                .pulse { font-size: 14px; letter-spacing: 5px; color: #38bdf8; text-transform: uppercase; animation: pulse 2s infinite; }

                @keyframes pulse { 0%, 100% { opacity: 0.3; } 50% { opacity: 1; } }



                .video-bg { position:fixed; top:0; left:0; width:100%; height:100%; z-index:-1; pointer-events:none; }

                .video-bg iframe { position:absolute; top:50%; left:50%; width:100vw; height:56.25vw; min-height:100vh; min-width:177.77vh; transform:translate(-50%, -50%); filter:brightness(30%) blur(5px); }



                .container { display:flex; align-items:center; justify-content:center; height:100vh; }

                .card { text-align:center; background:rgba(10, 10, 10, 0.5); backdrop-filter: blur(20px); padding:50px; border-radius:30px; width:380px; border:1px solid rgba(255,255,255,0.1); box-shadow: 0 0 50px #000; }

                .profile-img { position:relative; width:130px; height:130px; margin:0 auto; }

                .profile-img img { width:100%; height:100%; border-radius:50%; border:3px solid #38bdf8; object-fit: cover; }

                .dot { position:absolute; bottom:8px; right:10px; width:22px; height:22px; border-radius:50%; border:4px solid #000; background: #747f8d; transition: 0.5s; }



                #status { font-size:11px; color:#38bdf8; margin-top:15px; letter-spacing:2px; font-weight:bold; }

                .btn { display:inline-block; margin-top:25px; padding:12px 30px; background:transparent; border:1px solid #38bdf8; color:white; text-decoration:none; border-radius:8px; font-weight:bold; transition: 0.3s; }

                .btn:hover { background:#38bdf8; color:#000; box-shadow: 0 0 20px #38bdf8; }

            </style>

            <script>

                function enter() {

                    document.getElementById('entry-overlay').style.opacity = '0';

                    setTimeout(() => document.getElementById('entry-overlay').style.display='none', 1000);

                    const vid = document.getElementById('bg-vid');

                    vid.src += "&autoplay=1&mute=0";

                }

                async function updateStatus() {

                    const r = await fetch('https://api.lanyard.rest/v1/users/$U_DISCORD_ID');

                    const d = await r.json();

                    const s = d.data.discord_status;

                    const colors = { online:'#43b581', dnd:'#f04747', idle:'#faa61a', offline:'#747f8d' };

                    document.getElementById('status-dot').style.backgroundColor = colors[s] || '#747f8d';



                    const activities = d.data.activities;

                    if(activities.length > 0) {

                        const game = activities.find(a => a.type !== 4);

                        document.getElementById('status').innerText = game ? "PLAYING " + game.name.toUpperCase() : activities[0].state.toUpperCase();

                    } else {

                        document.getElementById('status').innerText = s.toUpperCase();

                    }

                }

                setInterval(updateStatus, 5000);

                window.onload = updateStatus;



                function openLink() {

                    let url = "$U_SERVER_LINK";

                    if(!url.startsWith('http')) url = 'https://' + url;

                    window.open(url, '_blank');

                }

            </script>

        </head>

        <body>

            <div id="entry-overlay" onclick="enter()"><div class="pulse">CLICK TO ENTER</div></div>

            <div class="video-bg">

                <iframe id="bg-vid" src="https://www.youtube.com/embed/$VID_ID?controls=0&mute=1&loop=1&playlist=$VID_ID" frameborder="0"></iframe>

            </div>

            <div class="container">

                <div class="card">

                    <div class="profile-img">

                        <img src="$U_IMG">

                        <div id="status-dot" class="dot"></div>

                    </div>

                    <div id="status">LOADING...</div>

                    <h1 style="margin:20px 0 5px 0; letter-spacing:3px;">$U_NAME</h1>

                    <p style="color:#666; font-size:12px; margin:0; letter-spacing:4px;">$U_ROLE</p>

                    <button onclick="openLink()" class="btn" style="cursor:pointer; font-family:inherit;">DISCORD SERVER</button>

                </div>

            </div>

        </body>

        </html>

    \`);

});

app.listen(port);

INDEX_EOF



echo -e "${YELLOW}Installing modules...${RESET}"

npm install --quiet



echo -e "\n----------------------------------------------------------------"

echo -e "${GREEN}SUCCESS!${RESET} $U_NAME is ready."

echo -e "Run: ${WHITE}npm start${RESET}"

echo "----------------------------------------------------------------"

