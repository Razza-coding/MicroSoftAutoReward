#Persistent
#SingleInstance Force
SetTitleMatchMode, 2
SetKeyDelay, 50, 50
SetWorkingDir, %A_ScriptDir%

; === Read config.txt ===
config := {}
FileRead, configText, config.txt
if (ErrorLevel || configText = "")
{
    MsgBox, ❌ config.txt not found or empty.
    ExitApp
}
Loop, Parse, configText, `n, `r
{
    line := Trim(A_LoopField)
    if line =
        continue
    StringSplit, parts, line, =
    key := Trim(parts1)
    value := Trim(parts2)
    StringReplace, value, value, ",, All  ; remove quotes
    config[key] := value
}

; === Load values from config ===
searchCount := config["searchCount"]
bingURL     := "https://www.bing.com"
inputFile   := config["inputFile"]

; === Seed random number generator using current time ===
StringTrimRight, seedStr, A_Now, 0
seed := SubStr(seedStr, -5)
Random,, %seed%

; === Read keywords from file ===
keywords := []
if !FileExist(inputFile) {
    MsgBox, ❌ %inputFile% not found.
    ExitApp
}
FileRead, rawKeywords, %inputFile%
Loop, Parse, rawKeywords, `n, `r
{
    line := Trim(A_LoopField)
    if (line != "")
        keywords.Push(line)
}
if (keywords.Length() = 0) {
    MsgBox, ❌ No keywords found in %inputFile%
    ExitApp
}
if (searchCount > keywords.Length()) {
    searchCount := keywords.Length()
}

; === Shuffle keyword list ===
RandomShuffle(arr) {
    Loop % arr.Length()
    {
        Random, r, 1, % arr.Length()
        temp := arr[A_Index]
        arr[A_Index] := arr[r]
        arr[r] := temp
    }
}
RandomShuffle(keywords)

; === Gaussian random delay ===
GaussianDelay(mean := 1500, stddev := 800) {
    Random, u1, 1, 9999
    Random, u2, 1, 9999
    u1 := u1 / 10000
    u2 := u2 / 10000
    z := Sqrt(-2 * Ln(u1)) * Cos(6.28318530718 * u2)
    delay := Round(mean + stddev * z)
    return (delay < 0) ? 0 : (delay > 3000 ? 3000 : delay)
}

; === Random mouse scroll ===
RandomMouseScroll() {
    Random, scrollCount, 1, 5
    Loop, %scrollCount%
    {
        Random, dir, 0, 1
        delta := dir = 1 ? 120 : -120
        MouseMove, 500, 500, 0
        DllCall("mouse_event", "UInt", 0x0800, "UInt", 0, "UInt", 0, "UInt", delta, "UInt", 0)
        Random, sleepTime, 300, 800
        Sleep, sleepTime
    }
}

; === Switch to English input method (Ctrl + Shift) ===
Send, ^+
Sleep, 500

; === Show console ===
DllCall("AllocConsole")
FileAppend, Bing Rewards Auto Search`nSeed: %seed%`n==========================`n, CONOUT$

; === Main search loop ===
Loop, %searchCount%
{
    keyword := keywords[A_Index]
    FileAppend, [%A_Index%/%searchCount%] Searching: %keyword%`n, CONOUT$

    Run, msedge.exe %bingURL%
    WinWaitActive, Bing
    Sleep, 2500

    ; Force English input again
    Send, ^+
    Sleep, 300

    ; Search using Keyword.
    Send, ^l
    Sleep, 200
    SendRaw, %keyword%
    Sleep, 200
    Send, {Enter}
    Sleep, 3000

    ; Simulate scroll
    FileAppend, >> Scrolling...`n, CONOUT$
    RandomMouseScroll()

    ; Close tab
    Send, ^w

    ; Random delay
    delay := GaussianDelay()
    FileAppend, >> Delay %delay% ms`n, CONOUT$
    Sleep, %delay%
}

; === Final message ===
MsgBox, Search complete. %searchCount% keywords have been searched.
ExitApp
