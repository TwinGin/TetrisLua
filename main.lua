

function love.load()
    boardWidth=10
    boardHeight = 18
    shapeIndex = 1
    shapeRotation = 1
    horizontalOffset = 0
    verticalOffset = 0
    fallingTime = 0
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
end

local function randomizeShape()
    --randomShape = math.random(1,6)
    --randomShape = 1
    randomColor = math.random(1,10)
    randomColorLetter = colorLetters[randomColor]
    local shape = {
        {' ',' ',' ',' '},
        {' ',' ',' ',' '},
        {' ',' ',' ',' '},
        {' ',' ',' ',' '},
    }
    for i=1, 4 do
        for j=1, 4 do
            if shapes[shapeIndex][shapeRotation][i][j] ~= ' ' then
                shape[i][j]=randomColorLetter
            end
        end
    end
    return shape
end

function love.draw()
    local function drawRectangle(localRectangle,x,y)
        local color = colors[localRectangle]
        love.graphics.setColor(color)
        local boardPartSize = 32
        local boardPartDrawSize = boardPartSize -3
        love.graphics.rectangle("fill",(x-1)*boardPartSize,(y-1)*boardPartSize,boardPartDrawSize,boardPartDrawSize)
    end


    for y=1, boardHeight do
        for x=1, boardWidth do
            drawRectangle(board[y][x],x,y)
        end
    end

    local randomizedShape=randomizeShape()

    for y=1,4 do
        for x=1,4 do
        local rect = randomizedShape[x][y]
        if rect ~= ' ' then
            drawRectangle(rect,x  + horizontalOffset ,y + verticalOffset)
            end
        end
    end
end

function love.keypressed(key)
    if key == 'up' then
        shapeRotation = shapeRotation + 1
        if shapeRotation > #shapes[shapeIndex] then
            shapeRotation = 1
        end

    elseif key =='down' then
        shapeRotation = shapeRotation - 1 
        if shapeRotation < 1 then
            shapeRotation = #shapes[shapeIndex]
        end
    elseif key == 'n' then
        shapeIndex = shapeIndex + 1
        if shapeIndex >#shapes then
            shapeIndex=1
        end
        shapeRotation=1
    elseif key=='m' then
        shapeIndex = shapeIndex - 1
        if shapeIndex < 1 then
            shapeIndex = #shapes
        shapeRotation = 1
        end
    elseif key=='right' then
        horizontalOffset = horizontalOffset + 1
    elseif key=='left' then
        horizontalOffset = horizontalOffset -1
    end
end

function love.update(dt)
    fallingTime = fallingTime + dt
    if fallingTime >=0.5 then
        fallingTime = 0
        verticalOffset = verticalOffset + 1
    end
end
