function love.load()
    WW, WH = love.graphics.getDimensions()
    blobs = {
        {
            x = 0,
            y = 0,
            length = 512
        }
    }
    clickSound = love.audio.newSource("jump.wav", "static")
end

function love.draw()
    love.graphics.setColor(0, 1, 0)
    love.graphics.rectangle("fill", 0, 0, WW, WH)
    love.graphics.setColor(1, 0, 0)
    for _, blob in ipairs(blobs) do 
        love.graphics.rectangle("fill", blob.x, blob.y, blob.length, blob.length)
    end
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("yes this game has an end")
end

function love.update(dt)
end

function love.keypressed(key)
    if key == "escape" then love.event.quit() end
end

function love.mousepressed(_x, _y)
    for index, blob in ipairs(blobs) do 
        if isColliding({x = _x, y = _y, length = 0}, blob) then
            blob.length = blob.length / 2
            if blob.length > 4 then
                local random = math.floor(love.math.random(3))
                local newBlob
                if random == 1 then 
                    newBlob = {x = blob.x + blob.length, y = blob.y, length = blob.length} 
                elseif random == 1 then
                    newBlob = {x = blob.x, y = blob.y + blob.length, length = blob.length} 
                else 
                    newBlob = {x = blob.x + blob.length, y = blob.y + blob.length, length = blob.length} 
                end
                table.insert(blobs, newBlob)
                break
            else
                table.remove(blobs, index)
                if #blobs == 0 then
                    love.system.openURL("https://www.youtube.com/watch?v=dQw4w9WgXcQ")
                end
            end
        end
    end
    clickSound:play()
end

function isColliding(obj1, obj2)
    return (obj1.x + obj1.length > obj2.x and obj1.x < obj2.x + obj2.length and 
    obj1.y + obj1.length > obj2.y and obj1.y < obj2.y + obj2.length)
end