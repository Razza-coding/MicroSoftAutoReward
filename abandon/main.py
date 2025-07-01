import os
import subprocess
import time
import random
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys

# === 使用者設定 ===
NUM_SEARCHES = 20  # 搜尋次數（可自訂）
SEARCH_KEYWORDS = [
    "python", "machine learning", "台灣旅遊", "chatGPT", "AI 應用",
    "投資理財", "黑洞", "遊戲排行", "氣候變遷", "電動車", "F1 賽事",
    "空拍機", "股市走勢", "歐洲旅遊", "人工智慧", "深度學習", "貓咪可愛圖片",
    "電影上映", "健身計畫", "歷史知識"
]

# === Edge 資料夾設定 ===
EDGE_USER_CLONE = "C:\\EdgeBotProfile"  # ← 你事先手動複製一份 User Data 到這裡

# === 關閉所有 Edge 執行程序（背景與前景）===
def kill_edge_processes():
    print("🔄 關閉所有 Edge 執行程序...")
    os.system("taskkill /f /im msedge.exe >nul 2>&1")
    os.system("taskkill /f /im msedgedriver.exe >nul 2>&1")
    time.sleep(2)  # 等待關閉穩定

# === 啟動 Selenium with Edge ===
def start_edge_driver():
    options = webdriver.EdgeOptions()
    options.add_argument(f"user-data-dir={EDGE_USER_CLONE}")
    options.add_argument("profile-directory=Default")  # 使用複製資料夾中的預設 Profile
    options.add_experimental_option("detach", True)  # 不會在執行完後自動關閉視窗
    return webdriver.Edge(options=options)

# === 主程式 ===
def main():
    kill_edge_processes()  # Step 1: 關閉 Edge

    driver = start_edge_driver()  # Step 2: 啟動 Driver
    try:
        # Step 3: 開啟 Microsoft Rewards 儀錶板
        driver.get("https://rewards.bing.com/")
        time.sleep(5)

        # Step 4: 開啟 Bing 首頁
        driver.execute_script("window.open('https://www.bing.com', '_blank');")
        driver.switch_to.window(driver.window_handles[-1])
        time.sleep(3)

        # Step 5: 執行搜尋流程
        used_keywords = set()
        for i in range(NUM_SEARCHES):
            keyword = random.choice([k for k in SEARCH_KEYWORDS if k not in used_keywords])
            used_keywords.add(keyword)

            # 開新分頁並搜尋
            driver.execute_script("window.open('https://www.bing.com', '_blank');")
            driver.switch_to.window(driver.window_handles[-1])
            time.sleep(2)

            search_box = driver.find_element(By.NAME, "q")
            search_box.clear()
            search_box.send_keys(keyword)
            search_box.send_keys(Keys.RETURN)

            print(f"[{i+1}/{NUM_SEARCHES}] 搜尋：{keyword}")
            time.sleep(random.uniform(3, 5))

        print("✅ 搜尋任務完成，請回 Reward 查看點數變化。")

    finally:
        input("👉 請按 Enter 關閉程式（不會自動關閉瀏覽器）...")

if __name__ == "__main__":
    main()
