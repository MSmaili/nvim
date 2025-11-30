-- Open Brave
-- Usage: `osascript path/to/brave.scpt [url]`

on run argv
    if (argv is not {}) then
        -- command line URL
        set targetUrl to item 1 of argv
    else
        -- clipboard URL
        set targetUrl to the clipboard as string
    end if

    -- validate URL (bare minimum)
    if targetUrl starts with "http://" or targetUrl starts with "https://" then
        set isValid to true
    else
        set isValid to false
    end if

    tell application "Brave Browser"
        if isValid then
            if (count of windows) = 0 then
                make new window
            end if

            tell window 1
                make new tab with properties {URL:targetUrl}
            end tell
        else
            -- invalid URL → open a new blank window or tab
            if (count of windows) = 0 then
                make new window
            else
                tell window 1 to make new tab
            end if
        end if

        activate
    end tell
end run
