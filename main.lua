

function love.load()
    soundMove=love.audio.newSource('selection.wav',"static")
    soundGameover=love.audio.newSource('gameover.wav',"static")
    soundScore=love.audio.newSource('line.wav',"static")
    soundFall=love.audio.newSource('fall.wav',"static")
    boardWidth=10
    boardHeight = 18
    shapeIndex = 1
    shapeRotation = 1
    horizontalOffset = 3
    verticalOffset = 0
    fallingTime = 0
    windowWidth, windowHeight = love.graphics.getDimensions()
    local font = love.graphics.setNewFont(20)
    fontHeight = font:getHeight()
    lume = require "lume"
    randomizedShape={}
    love.graphics.setBackgroundColor(0,0,0)
    board={}
    for i=1,boardHeight do
        board[i]={}
        for j=1,boardWidth do
            board[i][j]= ' '
        end
    end

    shapes = 
    {
        {
            {
                {' ',' ',' ',' '},
                {'x','x','x',' '},
                {' ','x',' ',' '},
                {' ',' ',' ',' '},
            },
            {
                {' ','x',' ',' '},
                {'x','x',' ',' '},
                {' ','x',' ',' '},
                {' ',' ',' ',' '},
            },
            {
                {' ','x',' ',' '},
                {'x','x','x',' '},
                {' ',' ',' ',' '},
                {' ',' ',' ',' '},
            },
            {
                {' ','x',' ',' '},
                {' ','x','x',' '},
                {' ','x',' ',' '},
                {' ',' ',' ',' '},
            },
        },
        {
            {
                {' ','x',' ',' '},
                {' ','x',' ',' '},  
                {' ','x',' ',' '},
                {' ','x',' ',' '},
            },
            {
                {' ',' ',' ',' '},
                {'x','x','x','x'},
                {' ',' ',' ',' '},
                {' ',' ',' ',' '},
            },
        },
        {
            {
                {'x',' ',' ',' '},
                {'x','x','x',' '},
                {' ',' ',' ',' '},
                {' ',' ',' ',' '},
            },
            {
                {' ','x','x',' '},
                {' ','x',' ',' '},
                {' ','x',' ',' '},
                {' ',' ',' ',' '},
            },
            {
                {' ',' ',' ',' '},
                {'x','x','x',' '},
                {' ',' ','x',' '},
                {' ',' ',' ',' '},
            },
            {
                {' ','x',' ',' '},
                {' ','x',' ',' '},
                {'x','x',' ',' '},
                {' ',' ',' ',' '},
            },
        },
        {
            {
                {' ',' ','x',' '},
                {'x','x','x',' '},
                {' ',' ',' ',' '},
                {' ',' ',' ',' '},
            },
            {
                {' ','x',' ',' '},
                {' ','x',' ',' '},
                {' ','x','x',' '},
                {' ',' ',' ',' '},
            },
            {
                {' ',' ',' ',' '},
                {'x','x','x',' '},
                {'x',' ',' ',' '},
                {' ',' ',' ',' '},
            },
            {
                {'x','x',' ',' '},
                {' ','x',' ',' '},
                {' ','x',' ',' '},
                {' ',' ',' ',' '},
            },
        },
        {
            {
                {' ',' ',' ',' '},
                {' ','x','x',' '},
                {' ','x','x',' '},
                {' ',' ',' ',' '},
            }
        },
        {
            {
                {' ',' ',' ',' '},
                {'z','z',' ',' '},  
                {' ','z','z',' '},
                {' ',' ',' ',' '},
            },
            {
                {' ','z',' ',' '},
                {'z','z',' ',' '},
                {'z',' ',' ',' '},
                {' ',' ',' ',' '},
            },
        },
    }


        colors = {
       i = {1,0,0},
       j = {0,1,0},
       k = {0,0,1},
       l = {.5,.5,0},
       m = {.5,0,.5},
       n = {0,.5,.5},
       o = {.43, .2,.73},
       p = {.20,.60,.80},
       r = {.33,.7 ,0},
       s = {.10,.20,.5},
       [' '] = {255,255,255},
    }

    colorLetters = {
        'i','j','k','l','m','n','o','p','r','s'
    }
     randomizedShape=randomizeShape()
end

function randomizeShape()
    horizontalOffset = 3
    verticalOffset = 0
    shapeRotation=1
    randomShape = math.random(1,6)
    --randomizedShape=2
    shapeIndex=randomShape
    --randomShape = 1
    randomColor = math.random(1,10)
    randomColorLetter = colorLetters[randomColor]
    local shape = {
    }
    shape = shapes[shapeIndex]

    for k=1,#shapes[shapeIndex] do
        --shape[k]={}
        for i=1, 4 do
            --shape[k][i]={}
            for j=1, 4 do
                --shape[k][i][j]=shapes[shapeIndex][k][i][j];

                if shapes[shapeIndex][k][i][j] ~= ' ' then
                    shape[k][i][j]=randomColorLetter
                end
            end
        end
    end
    print (shape)
    return shape
end

function love.draw()

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf("Strzalki: prawo, lewo - zmiana polozenia| gora, doł - zmiana orientajci, spacja - szybkie polozenia klocka, s - zapis, l - wczytanie", 0, fontHeight / 30, windowWidth, 'right')



    local function drawRectangle(localRectangle,x,y)
        local color = colors[localRectangle]
        love.graphics.setColor(color)
        local boardPartSize = 32
        local boardPartDrawSize = boardPartSize -3
        love.graphics.rectangle("fill",(x-1)*boardPartSize,(y-1)*boardPartSize+30,boardPartDrawSize,boardPartDrawSize)
    end


    for y=1, boardHeight do
        for x=1, boardWidth do
            drawRectangle(board[y][x],x,y)
        end
    end



    for y=1,4 do
        for x=1,4 do
        local rect = randomizedShape[shapeRotation][y][x]
        if rect ~= ' ' then
            drawRectangle(rect,x  + horizontalOffset ,y + verticalOffset)
            end
        end
    end
end

function save()
    local savegameFile = {}
    savegameFile = { board = board, randomShape=randomizedShape, shapeRotation=shapeRotation, shapeIndex=shapeIndex}
    love.filesystem.write("savegameFile.txt",lume.serialize(savegameFile))
end

function load()
    if love.filesystem.getInfo("savegameFile.txt") then
        local savegameFile = {}
        savegameFile = lume.deserialize(love.filesystem.read("savegameFile.txt"))
        board = savegameFile.board
        randomizedShape = savegameFile.randomShape
        shapeRotation = savegameFile.shapeRotation
        shapeIndex = savegameFile.shapeIndex
        horizontalOffset=3
        verticalOffset=0
    end
end

function love.keypressed(key)
    if key == 'up' then --shape rotation change
        local newRotation = shapeRotation + 1
        if newRotation > #shapes[shapeIndex] then
            newRotation = 1
        end
        if movementAvaliable(horizontalOffset,verticalOffset,newRotation) then
            shapeRotation = newRotation
            soundMove:play()
        end

    elseif key =='down' then --shape rotation change
        local newRotation = shapeRotation- 1
        if newRotation < 1 then
            newRotation = #shapes[shapeIndex]
        end
        if movementAvaliable(horizontalOffset,verticalOffset,newRotation) then
            shapeRotation = newRotation
             soundMove:play()
        end

    elseif key=='right' then -- movement right
        local newHorizontal = horizontalOffset + 1
        if movementAvaliable(newHorizontal,verticalOffset,shapeRotation) then
            horizontalOffset = newHorizontal
             soundMove:play()
        end
    elseif key=='left' then -- movement left
        local newHorizontal = horizontalOffset - 1
        if movementAvaliable(newHorizontal,verticalOffset,shapeRotation) then
             horizontalOffset = newHorizontal
             soundMove:play()
        end
    elseif key=='space' then
        while movementAvaliable(horizontalOffset,verticalOffset+1,shapeRotation) do
            verticalOffset = verticalOffset+1
        end
    elseif key== 's' then
        save()
    elseif key== 'l' then
        load()
    end
end

function love.update(dt)
    fallingTime = fallingTime + dt
    if fallingTime >=0.5 then
        fallingTime = 0
        local newVertical = verticalOffset + 1
        if movementAvaliable(horizontalOffset, newVertical, shapeRotation) then
            verticalOffset = newVertical
        else
            soundFall:play()
            for y=1, 4 do
                for x=1, 4 do
                    local rect = randomizedShape[shapeRotation][y][x]
                    if rect ~= ' ' then
                        board[verticalOffset + y][horizontalOffset + x] = rect
                    end
                end
            end

            for y = 1, boardHeight do
                local fullRow = true
                for x = 1, boardWidth do
                    if board[y][x] == ' 'then
                        fullRow = false
                        break;
                    end
                end

                if fullRow then
                    soundScore:play()
                    for fullRowY=y, 2, -1 do
                        for fullRowX = 1, boardWidth do
                        board[fullRowY][fullRowX] = board[fullRowY-1][fullRowX]
                        end
                    end
                    for fullRowX=1,boardWidth do
                        board[1][fullRowX]=' '
                    end
                end
            end
            randomizedShape=randomizeShape()

            if not movementAvaliable(horizontalOffset,verticalOffset,shapeRotation) then
                soundGameover:play()
                love.load()
            end
        end
    end
end

function movementAvaliable(newHorizontal, newVertical, newRotation)
    for y=1, 4 do
        for x=1, 4 do
            if shapes[shapeIndex][newRotation][y][x] ~=' ' 
                and ((newHorizontal+x) < 1 or (newHorizontal + x) > boardWidth or (newVertical + y) > boardHeight or (board[newVertical + y][newHorizontal + x]~=' ')) then
                return false
            end
        end
    end
    return true
end