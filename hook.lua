[ENABLE]
{$LUA}
fatal = 0
norecoil = 0
_G.noclip = 0
local vehicleASM = [==[
  alloc(mycode,4096)
  CREATETHREAD(mycode);

  mycode:
  jmp 0043A530
]==]
function createVehicle()
autoAssemble(vehicleASM)
end

local hydraASM = [==[
  0043A530:
  push 00000208
]==]
function setHydra()
autoAssemble(hydraASM)
end

local carASM = [==[
  0043A530:
  push 0000022F
]==]
function setCar()
autoAssemble(carASM)
end

function setFatal()
 if fatal == 0 then
  writeFloat("[0xB6F5F0]+0x540", "999999")
  d3dhook_textcontainer_setText(Option1,'HP: ' .. readFloat('[0xB6F5F0]+0x540'));
  d3dhook_textcontainer_setText(Option2,'[FATAL*]');
  --setProperty(font,"color",0x000000)
  fatal = 1
  --print(fatal)
  return
 elseif fatal == 1 then
  writeFloat("[0xB6F5F0]+0x540", "100")
  d3dhook_textcontainer_setText(Option1,'HP: ' .. readFloat('[0xB6F5F0]+0x540'));
  d3dhook_textcontainer_setText(Option2,'[FATAL]');
  fatal = 0
  --print(fatal)
  return
 end
end

function setNorecoil()
 if norecoil == 0 then
  writeInteger(0x969178, 1)
  norecoil = 1
  d3dhook_textcontainer_setText(Option4,'[NORECOIL*]');
  return
 elseif norecoil == 1 then
  writeInteger(0x969178, 0)
  norecoil = 0
  d3dhook_textcontainer_setText(Option4,'[NORECOIL]');
  return
 end
end

function setNoclip()
 if _G.noclip == 0 then
 -- print("noclip 0")
  writeInteger('[0xB6F5F0]+0x42',2)
  d3dhook_textcontainer_setText(Option3,'[DROSE*]');
  writeInteger('[0xB6F5F0]+0x15C',102)
  --writeFloat('[[0xB6F5F0]+0x14]+0x38', readFloat('[[0xB6F5F0]+0x14]+0x38')+0.5)
  --hUp = createHotkey(tUp, VK_UP)
  _G.noclip = 1
  return
 elseif _G.noclip == 1 then
  --print("noclip 1")
  writeInteger('[0xB6F5F0]+0x42',0)
  writeFloat('[[0xB6F5F0]+0x14]+0x38', readFloat('[[0xB6F5F0]+0x14]+0x38')+0.3)
  writeInteger('[0xB6F5F0]+0x15C',102)
  d3dhook_textcontainer_setText(Option3,'[DROSE]');
  --writeFloat('[[0xB6F5F0]+0x14]+0x38', readFloat('[[0xB6F5F0]+0x14]+0x38')+1)
  --bindNoclip(noclip)
  _G.noclip = 0
  return
 end
end

function createDirect3D()
--create a background image
background=createPicture()
bmp=picture_getBitmap(background);
graphic_setHeight(bmp,1)
graphic_setWidth(bmp,1)
c=rasterimage_getCanvas(bmp)
canvas_setPixel(c,0,0,0x000000)
--do i need that?
highlighter=createPicture()
bmp=picture_getBitmap(highlighter);
graphic_setHeight(bmp,1)
graphic_setWidth(bmp,1)
c=rasterimage_getCanvas(bmp)
canvas_setPixel(c,0,0,0x000000) -- black bg
--directx
d3dhook_initializeHook()
barsize = 30
bgtexture=d3dhook_createTexture(background)
bgsprite=d3dhook_createSprite(bgtexture);
d3dhook_renderobject_setX(bgsprite, 0)
d3dhook_renderobject_setY(bgsprite, getScreenHeight() - barsize)
d3dhook_sprite_setWidth(bgsprite,getScreenWidth())
d3dhook_sprite_setHeight(bgsprite,barsize)
--font
font=createFont()
setProperty(font,"color",0xdff2)
fontmap=d3dhook_createFontmap(font)
lineheight=d3dhook_texture_getHeight(fontmap)
--health = readFloat("0xB6F5F0+0x540")
health = readFloat('[0xB6F5F0]+0x540')
--print(health)
Option1=d3dhook_createTextContainer(fontmap,5,getScreenHeight() - barsize,[[HP: ]] .. health)
Option2=d3dhook_createTextContainer(fontmap,5*20,getScreenHeight() - barsize,"[FATAL]")
Option3=d3dhook_createTextContainer(fontmap,5*40,getScreenHeight() - barsize,"[DROSE]")
Option4=d3dhook_createTextContainer(fontmap,5*60,getScreenHeight() - barsize,"[NORECOIL]")
--Option2=d3dhook_createTextContainer(fontmap,5,10+lineheight,'FPS: OFF')
--Option3=d3dhook_createTextContainer(fontmap,5,10+lineheight*2,'ESP-BOX: OFF')
d3dhook_onKey(keydown)
end

function keydown(key, char)
 if _G.noclip == 1 then
  camerarot = readFloat(0xB6F178)
  if (camerarot > -0.75 and camerarot < 0.75) then
   --forward =
   forward = VK_D
   back = VK_A
   right = VK_W
   left = VK_S
   --print(1)
  elseif (camerarot > -2.55 and camerarot < -0.75) then
   back = VK_W
   forward = VK_S
   left = VK_A
   right = VK_D
  elseif (camerarot > -3.14 and camerarot < -2.55) then
   forward = VK_A
   back = VK_D
   right = VK_S
   left = VK_W
  elseif (camerarot > 2.55 and camerarot < 3.14) then
   forward = VK_A
   back = VK_D
   right = VK_S
   left = VK_W
  elseif (camerarot > 0.75 and camerarot < 2.55) then
   forward = VK_W
   back = VK_S
   right = VK_A
   left = VK_D
  end
 end
 if (key == VK_UP and _G.noclip == 1) then
    writeFloat('[[0xB6F5F0]+0x14]+0x38', readFloat('[[0xB6F5F0]+0x14]+0x38')+0.5)
 elseif (key == VK_DOWN and _G.noclip == 1) then
    writeFloat('[[0xB6F5F0]+0x14]+0x38', readFloat('[[0xB6F5F0]+0x14]+0x38')-0.5)
 elseif (key == forward and  _G.noclip == 1) then
    writeFloat('[[0xB6F5F0]+0x14]+0x30', readFloat('[[0xB6F5F0]+0x14]+0x30')+1)
 elseif (key == back and  _G.noclip == 1) then
    writeFloat('[[0xB6F5F0]+0x14]+0x30', readFloat('[[0xB6F5F0]+0x14]+0x30')-1)
 elseif (key == right and  _G.noclip == 1) then
    writeFloat('[[0xB6F5F0]+0x14]+0x34', readFloat('[[0xB6F5F0]+0x14]+0x34')+1)
 elseif (key == left and  _G.noclip == 1) then
    writeFloat('[[0xB6F5F0]+0x14]+0x34', readFloat('[[0xB6F5F0]+0x14]+0x34')-1)
 end
end

hk = createHotkey(createVehicle, VK_END)
hk2 = createHotkey(setHydra, VK_L)
hk3 = createHotkey(setCar, VK_K)
hk4 = createHotkey(setFatal, VK_INSERT)
hk5 = createHotkey(setNoclip, VK_RSHIFT)
hk6 = createHotkey(setNorecoil, VK_RCONTROL)
createDirect3D()
{$ASM}
[DISABLE]