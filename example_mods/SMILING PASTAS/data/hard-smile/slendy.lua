local timeLeft = 15

local isSpacePressed = false

local screenWidth = 1280
local barMaxHeight = 430
local barWidth = 35
local barX = screenWidth - barWidth - 30
local barY = 560

local barColor = 'F5F5F5'
local barColorWarn = 'FF2D00'

luaDebugMode = true

local fadeDuration = 0.6
local fadeTimer = 0
local fadeIn = false
local fadeOut = false

local animsA = {'singLEFT-alt', 'singDOWN-alt', 'singUP-alt', 'singRIGHT-alt'}
local animsB = {'singLEFT', 'singDOWN', 'singUP', 'singRIGHT'}

addCharacterToList('charlieHide', 'bf')
precacheImage('Eye')

function onCreate()
    makeLuaSprite('bg', 'slendyBar', 1206.48, 120)
    scaleObject('bg', 0.5, 0.71)
    setObjectCamera('bg', 'hud')
    addLuaSprite('bg', true)

    makeLuaSprite('timeBar', '', barX, barY - barMaxHeight)
    makeGraphic('timeBar', barWidth, barMaxHeight, barColor)
    setObjectCamera('timeBar', 'hud')
    addLuaSprite('timeBar', true)

    makeLuaSprite('icon', 'slendyBarIcon', 1175, 500)
    scaleObject('icon', 0.6, 0.6)
    setObjectCamera('icon', 'hud')
    addLuaSprite('icon', true)

    makeLuaSprite('fadeImage', 'screenFade', -50, 0)
    scaleObject('fadeImage', 0.7, 0.7)
    setObjectCamera('fadeImage', 'hud')
    setProperty('fadeImage.alpha', 0)
    setBlendMode('fadeImage', 'subtract')
    addLuaSprite('fadeImage', true)

    setProperty('gf.visible', false)
end

function onUpdate(elapsed)
    isSpacePressed = getPropertyFromClass('flixel.FlxG', 'keys.pressed.SPACE')
    local health = getProperty('health')

    -- Eye fade stuff
    if isSpacePressed and not (fadeIn or fadeOut) then
        fadeIn = true
        fadeTimer = 0
        triggerEvent('Change Character', 0, 'charlieHide')
    end

    if fadeIn then
        fadeTimer = fadeTimer + elapsed
        if isSpacePressed then
            setProperty('fadeImage.alpha', math.min(fadeTimer / fadeDuration, 1))
            if fadeTimer >= fadeDuration then
                fadeIn = false
                fadeOut = true
                fadeTimer = 0
            end
        end
    elseif fadeOut then
        fadeTimer = fadeTimer + elapsed
        if not isSpacePressed then
            setProperty('fadeImage.alpha', 1 - math.min(fadeTimer / fadeDuration, 1))
            if fadeTimer >= fadeDuration then
                fadeOut = false
                triggerEvent('Change Character', 0, 'charlie')
            end
        end
    end

    -- TRADE TIME FOR HEALTH and RECOVERY
    if isSpacePressed then
        if health > 0 then
            setProperty('health', health - 0.0007 * elapsed) -- Health drain
        end
        timeLeft = math.min(timeLeft + elapsed / 2, 15) -- Recovers the Bar
        if timeLeft >= 15 then
            timeLeft = timeLeft - 0.01 * elapsed -- Caps bar at 14.999
            setProperty('health', health - 0.001 * elapsed)
        end
    else
        timeLeft = math.max(timeLeft - elapsed, 0) -- Lowers the Bar
    end

    -- Kills player
    if timeLeft <= 0.1 then
        timeLeft = 0.1
        setProperty('health', -5)
    end

    -- Bar Stuff and Color switch
    setProperty('timeBar.color', getColorFromHex(timeLeft <= 7.5 and barColorWarn or barColor))
    local barHeight = (timeLeft / 15) * barMaxHeight
    setGraphicSize('timeBar', barWidth, barHeight)
    setProperty('timeBar.y', barY - barHeight)

    -- Closes the game if you suck lol
    if timeLeft == 0.1 or botPlay or inGameOver then
        os.exit()
    end
end

function opponentNoteHit()
    -- Prevents the player from holding the bar on opponent's notes (ANTI-CHEESE)
    if isSpacePressed and timeLeft >= 14.9 then
        setProperty('health', getProperty('health') - 0.04 * elapsed)
    end
end

-- StrBrst ^_^ !!