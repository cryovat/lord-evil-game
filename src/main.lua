local state = require "state"
local util = require "util"
local sprite = require "sprite"
local opt = require "options"

a = {}

local function newGame()
   error "Game not implemented"
end

local function quit()
   love.event.push("quit")
end

local function options(prev)

   local optItems = a.options:createMenuItems()

   return util.makeMenu(prev, unpack(optItems))

end

local function credits(prev)

   return util.makeMenu(prev,
			{ "Copyright, etc", nil }
		       )
end

local function mainMenu(prev)

   return util.makeMenu(nil,
			{ "New Game", mainMenu },
			{ "Options", options },
			{ "Credits", credits },
			{ "Quit", quit }
		       )

end

function love.load()

   local o = opt.Options:new()
   o:addBoolean("musicOn", "Music enabled", true)
   o:addBoolean("soundOn", "Sound effects enabled", true)
   o:addNumber("conts", "Continues", 1, 1, 5, 1)
   o:addList("diff", "Difficulty", "Easy", "Easy", "Medium", "Hard")
   o:addList("color", "Player color", "green", "red", "blue")
   a.options = o

   a.bg = love.graphics.newImage("gfx/external/winter.png")
   a.dude = love.graphics.newImage("gfx/external/dynamiteguy.png")

   a.flake = love.graphics.newImage("gfx/snowflake.png")
   a.snow = love.graphics.newParticleSystem(a.flake, 100)
   a.batch = love.graphics.newSpriteBatch(a.dude)

   a.snow:setEmissionRate(1)
   a.snow:setLifetime(-1)
   a.snow:setPosition(320, -100)
   a.snow:setParticleLife(10,15)
   a.snow:setSizes(0.1, 0.2, 0.3)
   a.snow:setGravity(5)
   a.snow:setSpread(80)
   a.snow:setTangentialAcceleration(-5,5)
   a.snow:setSpeed(10, 0)
   a.snow:start()

   a.atlas = sprite.Atlas:new(a.dude:getWidth(),a.dude:getHeight(),4,1)
   a.atlas:addSeq("boom",1,1,2,3,4)

   a.dudeSprite = sprite.Sprite:new(a.atlas)
   a.dudeSprite:setAnim("boom")

   love.graphics.setMode(640,480,false,false,4)
   gs = state.fadeIn(mainMenu(nil), 1)
end

function love.update(e)
   a.snow:update(e)
   a.dudeSprite:update(e)

   local nextState = gs:update(e)

   gs = nextState or gs
end

function love.draw()
   love.graphics.setColor(255,255,255,255)
   love.graphics.draw(a.bg, 0, 0)
   love.graphics.setColor(255,255,255,50)
   love.graphics.draw(a.snow)
   love.graphics.setColor(255,255,255,255)
   gs:draw(255)

   love.graphics.setColor(255,255,255,255)
   a.batch:clear()
   a.dudeSprite:draw(a.batch, 50, 50, 0, 2)
   love.graphics.draw(a.batch)
end

function love.keypressed(key, u)
   if key == "rctrl" then
      debug.debug()
   end
end
