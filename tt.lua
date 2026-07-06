local mat, snd, timestart, step

local function switchStep(f) 
    timestart = CurTime()
    step = f
end

local function getTimeGoing() 
    return CurTime() - timestart
end

local function scaleX(x) 
    return x * ScrW() / 1920
end

local function scaleY(y) 
    return y * ScrH() / 1080
end

local function fadeOut()
    local tg = getTimeGoing()

    if tg < 2 then
        surface.SetDrawColor(0, 0, 0, (1-tg/2) * 255)
        surface.DrawRect(0, 0, ScrW(), ScrH())
    else
        switchStep()
    end
end

local function main() 
    local tg = getTimeGoing()
    
    if tg < 6 then
        surface.SetDrawColor(255, 255, 255, 255)
        surface.DrawRect(0, 0, ScrW(), ScrH())
        surface.SetMaterial(mat)
        surface.DrawTexturedRect(0, 0, ScrW() , ScrH())
    else 
        switchStep(fadeOut)
        fadeOut()
    end
end

local function fadeIn() 
    local tg = getTimeGoing()
    
    if tg < 2 then
        surface.SetDrawColor(0, 0, 0, (tg / 2) * 255)
        surface.DrawRect(0, 0, ScrW(), ScrH())
    else
        snd:Play()
        switchStep(main)
        step()
    end
end

http.Fetch("https://github.com/InfernoLua1337/snippets/blob/main/images.jpg?raw=true", function(img)
    file.Write("bobbysanya.png", img)
    mat = Material("../data/bobbysanya.png")

    sound.PlayURL("https://github.com/InfernoLua1337/snippets/raw/refs/heads/main/bobby.mp3", "noplay", function(sound)
		sound:SetVolume(2)
        snd = sound
        switchStep(fadeIn)
    end)
end)

hook.Add("DrawOverlay", "stepbystepiwillbecomeachampion", function()
    if not snd then return end
    local tg = getTimeGoing()
    
    if step then step() end
end)

