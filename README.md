
# 📘 MicrosoftAutoReward (AHK Version)

A lightweight AutoHotKey script that simulates human behavior to automate Microsoft Bing searches, helping you earn Microsoft Rewards points safely and naturally.

## ⚠️ Disclaimer

This tool is intended **for educational and personal automation purposes only**.  
By using this script, you acknowledge and agree that:

> **You are solely responsible for any consequences resulting from the use of this tool, including but not limited to the suspension, restriction, or termination of your Microsoft Rewards account.**

We do not guarantee the safety or compliance of automated actions with Microsoft's terms of service. Use at your own risk.

## 📂 Files Included

| File Name             | Purpose                                               |
|------------------------|--------------------------------------------------------|
| `MicrosoftAutoReward.ahk` | Main AutoHotKey script                                 |
| `config.txt`              | Customizable parameters (search count, input file)     |
| `keyword.txt`             | List of search keywords (one per line)                 |

## 🔧 Requirements

- ✅ [AutoHotKey v1.1](https://www.autohotkey.com/) installed

## 🗊 How to Use

### 1. Install AutoHotKey

Download and install from the official site:  
👉 https://www.autohotkey.com/

Make sure you install version **v1.1** (not v2).

### 2. Prepare the files

Place the following files in the same folder:

- `MicrosoftAutoReward.ahk`
- `config.txt`
- `keyword.txt`

Edit `keyword.txt` and add your search terms (one per line).  
Edit `config.txt` if you want to change settings.

### 3. Run the script

- Make sure you already **login** in Microsoft Edge, otherwise you will not get reward points
- Make sure Edge is set to use **Bing** as the default search engine.

Double-click `MicrosoftAutoReward.ahk` to start.  
It will:

- Open Microsoft Edge
- Simulate Bing searches from `keyword.txt`
- Randomize timing and scroll to mimic human behavior
- Display progress in a console window

## ⚙️ Config Options (`config.txt`)

```
searchCount=3
inputFile="keyword.txt"
```

- `searchCount` – Number of search cycles per run
- `inputFile` – File that contains your search keywords

## 🛡 Security Notice

- This script does **not** access any system files, registry, or network.
- It only simulates basic user behavior like typing, scrolling, and pressing keys.