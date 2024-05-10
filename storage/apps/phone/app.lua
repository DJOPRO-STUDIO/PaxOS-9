function hangOn()
    gui:setWindow(win)
    print("hang on")
end

function checkHangOn()
    print("hang on check" .. tostring(gsm.getCallState()))
    if (gsm.getCallState() == 0) then
        hangOn()
    else
        time:setTimeout(checkHangOn, 500)
    end
end

function quit()
    gsm:endCall()
end

function callPage()
    print("call page")
    if win2 ~= nil then
        gui:setWindow(win2)
        time:setTimeout(checkHangOn, 500)
        return
    end

    win2=gui:window()

    num=gui:label(win2, 16, 83, 288, 41)
    num:setHorizontalAlignment(CENTER_ALIGNMENT)
    num:setFontSize(36)
    num:setText(gsm.getNumber())

    hangOnB=gui:button(win2, 35, 394, 250, 38)
    hangOnB:setText("Raccrocher")
    hangOnB:onClick(function() gsm:endCall() end)
    
    time:setTimeout(checkHangOn, 5000)

    gui:setWindow(win2)
    print("end callpage")
end

function run()
    if win ~= nil then
        gui:setWindow(win)
        return
    end

    win=gui:window()

    i=gui:label(win, 16, 83, 288, 41)
    i:setHorizontalAlignment(CENTER_ALIGNMENT)
    i:setFontSize(36)
    i:setText("+33")

    -- Create a table for the buttons
    buttons = {}

    -- Create a loop to generate the number buttons
    for row = 1, 3 do
        for col = 1, 3 do
            local num = (row - 1) * 3 + col
            buttons[num] = gui:label(win, 51 + 72 * (col - 1), 174 + 68 * (row - 1), 72, 68)
            buttons[num]:setVerticalAlignment(CENTER_ALIGNMENT)
            buttons[num]:setHorizontalAlignment(CENTER_ALIGNMENT)
            buttons[num]:setText(tostring(num))
            buttons[num]:setFontSize(24)

            -- Add onClick event to each button
            buttons[num]:onClick(function()
                i:setText(i:getText() .. num)
            end)
        end
    end

    -- Create the 0 button
    buttons[0] = gui:label(win, 123, 378, 72, 68)
    buttons[0]:setText("0")
    buttons[0]:setVerticalAlignment(CENTER_ALIGNMENT)
    buttons[0]:setHorizontalAlignment(CENTER_ALIGNMENT)
    buttons[0]:setFontSize(24)

    -- Add onClick event to the 0 button
    buttons[0]:onClick(function()
        i:setText(i:getText() .. "0")
    end)

    buttons[11] = gui:label(win, 51, 378, 72, 68)
    buttons[11]:setText("Effacer")
    buttons[11]:setVerticalAlignment(CENTER_ALIGNMENT)
    buttons[11]:setHorizontalAlignment(CENTER_ALIGNMENT)
    buttons[11]:setFontSize(16)

    buttons[11]:onClick(function()
        i:setText("+33")
    end)

    call = gui:label(win, 195, 378, 72, 68)
    call:setText("Appeler")
    call:setVerticalAlignment(CENTER_ALIGNMENT)
    call:setHorizontalAlignment(CENTER_ALIGNMENT)
    call:setFontSize(16)

    call:onClick(function()
        gsm.newCall(i:getText())
        print("Success")
        callPage()
    end)

    gui:setWindow(win)
end