-- easel session "fog": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ engine 2

--@ chunk 1

canvas{size=600, aspect=1.5, linen={20,18}, seed=4417,
  ground={{pile={{"lead white",8},{"raw umber",0.35},{"yellow ochre",0.35}}, um=150, apply="knife", texture=0.35},
          {pile={{"lead white",9},{"bone black",0.08},{"yellow ochre",0.2}}, um=35, apply="brush"}}}
h = pencil("3H")
h:sketch({{380,330},{700,330},{1000,330}}, {pressure=0.18})
h:sketch({{0,560},{200,460},{380,382},{520,342},{600,333}}, {pressure=0.2})
h:sketch({{245,395},{262,300},{300,240},{360,228},{410,262},{425,330},{430,372}}, {pressure=0.15})
h:sketch({{535,444},{560,452},{620,452},{640,443}}, {pressure=0.22})
print(W, H)

--@ chunk 2

fogA  = pile{{"lead white",6},{"raw umber",0.15},{"yellow ochre",0.15},{"bone black",0.05}}
fogB  = pile{{"lead white",6},{"bone black",0.12},{"smalt",0.25}}
fogW  = pile{{"lead white",6},{"yellow ochre",0.3},{"red earth",0.06}}
greyM = pile{{"lead white",3},{"raw umber",0.4},{"bone black",0.25}}
greyD = pile{{"lead white",1.5},{"raw umber",0.8},{"bone black",0.4}}
bankP = pile{{"raw umber",2},{"bone black",0.3},{"lead white",1},{"yellow ochre",0.4},{"green earth",0.6}}
boatP = pile{{"bone black",1},{"raw umber",1},{"lead white",0.15}}
local b = brush("flat", 12)
for i, p in ipairs({fogA, fogB, fogW, greyM, greyD, bankP, boatP}) do
  b:reload(p, 0.9)
  b:stroke({{12 + (i-1)*26, 640}, {30 + (i-1)*26, 640}}, {pressure={0.9,0.9}})
end

--@ chunk 3

local sky = rect(-20, -20, 1040, 358)
work(sky, {hand="broad", pile=fogA, angle=0.0, coverage=1.6, fill=true, length={140,300}, angle_jitter=0.08, clip=true})
local cool = (ellipse(120, 60, 420, 240):soften(80)) * sky
work(cool, {hand="broad", pile=fogB, angle=-0.05, coverage=1.0, length={120,240}, angle_jitter=0.1, clip=true, pressure={0.3,0.6}})
local glow = (ellipse(770, 150, 170, 120):soften(60)) * sky
work(glow, {hand="broad", pile=fogW, angle=0.1, coverage=1.2, length={80,180}, angle_jitter=0.2, clip=true, pressure={0.3,0.6}})

--@ chunk 4

waterA = pile{{"lead white",6},{"raw umber",0.22},{"bone black",0.14},{"smalt",0.12}}
waterB = pile{{"lead white",5},{"raw umber",0.35},{"bone black",0.25},{"smalt",0.15}}
land_m = poly({{-20,331},{600,333},{520,343},{380,384},{200,470},{90,560},{30,640},{-20,690}})
water_m = rect(-20, 326, 1040, 360) - land_m:shrink(2)
local band = function(y0, y1, s) return rect(-20, y0, 1040, y1 - y0):roughen(12, 240, s) * water_m end
work(band(322, 470, 5), {hand="broad", pile=waterA, angle=0.0, coverage=1.6, fill=true, length={140,300}, angle_jitter=0.02, clip=water_m})
work(band(450, 690, 6), {hand="broad", pile=waterB, angle=0.0, coverage=1.6, fill=true, length={140,300}, angle_jitter=0.02, clip=water_m})
local gl = ellipse(770, 520, 120, 70):soften(50) * water_m
work(gl, {hand="broad", pile=fogW, angle=0.0, coverage=1.0, length={60,160}, angle_jitter=0.03, pressure={0.3,0.55}, clip=water_m})

--@ chunk 5

blend(water_m:shrink(1), {angle=0.0})
blend(rect(-20, -20, 1040, 350), {angle=0.03})

--@ chunk 6

landFar  = pile{{"lead white",5},{"raw umber",0.3},{"yellow ochre",0.2},{"green earth",0.35},{"bone black",0.05}}
landMid  = pile{{"lead white",3.2},{"raw umber",0.45},{"yellow ochre",0.25},{"green earth",0.5},{"bone black",0.1}}
landNear = pile{{"lead white",1.8},{"raw umber",0.65},{"green earth",0.6},{"yellow ochre",0.3},{"bone black",0.16}}
local L = land_m:grow(1.5)
local band = function(y0, y1, s) return rect(-20, y0, 1040, y1 - y0):roughen(10, 160, s) * L end
work(band(328, 420, 11), {hand="broad", pile=landFar, angle=-0.1, coverage=1.6, fill=true, length={60,160}, angle_jitter=0.08, clip=L})
work(band(405, 540, 12), {hand="broad", pile=landMid, angle=-0.2, coverage=1.6, fill=true, length={60,160}, angle_jitter=0.1, clip=L})
work(band(520, 700, 13), {hand="broad", pile=landNear, angle=-0.3, coverage=1.6, fill=true, length={60,160}, angle_jitter=0.12, clip=L})
blend(L:shrink(2), {angle=-0.15})

--@ chunk 7

farP  = pile{{"lead white",5},{"raw umber",0.3},{"bone black",0.18},{"smalt",0.08}}
farP2 = pile{{"lead white",4},{"raw umber",0.38},{"bone black",0.26},{"smalt",0.06}}
local strip = (below({{540,327},{640,322},{760,320},{900,318},{1020,321}}) * above({{540,333},{1020,333}})):roughen(2, 30, 21)
local m = strip
-- a low rounded group and a stand of poplars
for _, c in ipairs({{665,305,22,20},{700,300,26,24},{735,308,20,16},{955,306,22,18},{985,300,30,24}}) do
  m = m + ellipse(c[1], c[2] + 10, c[3], c[4] + 10)
end
for _, p in ipairs({{825,258,8},{842,250,9},{858,262,8},{874,268,7},{892,276,7}}) do
  m = m + poly({{p[1], p[2]}, {p[1] - p[3], 326}, {p[1] + p[3], 326}}, true)
end
far_m = m:roughen(3, 14, 22)
local fade = far_m:times(function(x, y) return smoothstep(540, 680, x) end)
work(fade, {hand="body", pile=farP, angle=-1.5708, angle_jitter=0.25, coverage=1.5, fill=true, length={10,30}, pressure={0.3,0.55},
  edge={soft=0.5, lost=0.5, period=40}})

--@ chunk 8

local wl = 332
local refl = mask(function(x, y) if y < wl then return 0 end return far_m:at(x, 2 * wl - y) * smoothstep(540, 700, x) * clamp(1 - (y - wl) / 90, 0, 1) end)
work(refl:soften(3) * water_m, {hand="body", pile=farP, angle=1.5708, angle_jitter=0.1, coverage=1.2, fill=true, length={8,24}, pressure={0.2,0.45}, clip=water_m})
blend((refl:grow(6):soften(6)) * water_m, {angle=0.0, tool={kind="badger", width=16}})

--@ chunk 9

treeP  = pile{{"lead white",3.5},{"raw umber",0.4},{"bone black",0.22},{"green earth",0.2}}
treeP2 = pile{{"lead white",2.6},{"raw umber",0.5},{"bone black",0.3},{"green earth",0.25}}
local crowns = {
  {255, 318, 58, 62, 31}, {312, 300, 50, 72, 32}, {200, 345, 42, 50, 33}, {345, 350, 26, 34, 34}
}
local m = nil
for _, c in ipairs(crowns) do
  local e = ellipse(c[1], c[2], c[3], c[4]):roughen(10, 26, c[5])
  -- willows droop: the lower edge hangs in fringes
  e = e + (ellipse(c[1], c[2] + c[4] * 0.55, c[3] * 0.95, c[4] * 0.55):roughen(6, 9, c[5] + 7))
  m = m and (m + e) or e
end
trees_m = m * above({{150,440},{400,400}})
work(trees_m, {hand="body", pile=treeP, angle=-1.5708, angle_jitter=0.35, coverage=1.6, fill=true, length={12,34}, pressure={0.35,0.6},
  edge={soft=0.5, lost=0.4, found=0.1, period=40}})
-- the denser hearts of the crowns, a shade darker
local hearts = nil
for _, c in ipairs(crowns) do
  local e = ellipse(c[1] + 4, c[2] + c[4] * 0.2, c[3] * 0.5, c[4] * 0.5):roughen(8, 20, c[5] + 3)
  hearts = hearts and (hearts + e) or e
end
work(hearts * trees_m, {hand="body", pile=treeP2, angle=-1.5708, angle_jitter=0.4, coverage=1.0, length={8,24}, pressure={0.25,0.5},
  edge={soft=0.4, lost=0.6, period=30}})

--@ chunk 10

blend(trees_m:grow(3), {angle=1.5708, tool={kind="badger", width=14}})

--@ chunk 11

local notch1 = poly({{218,270},{236,262},{240,300},{232,330},{224,315}}, true)
local notch2 = poly({{276,250},{292,238},{296,262},{290,282},{282,276}}, true)
work((notch1 + notch2):roughen(3, 10, 41), {hand="detail", pile=fogA, angle=1.5708, coverage=2, fill=true, edge={soft=0.6, lost=0.4}})
local gap1 = poly({{218,428},{226,392},{238,388},{240,410},{236,432}}, true)
local gap2 = poly({{272,420},{278,386},{292,380},{296,400},{292,420}}, true)
local gap3 = poly({{326,410},{330,388},{336,384},{338,402}}, true)
work((gap1 + gap2 + gap3):roughen(2, 8, 42), {hand="detail", pile=landFar, angle=1.5708, coverage=2, fill=true, edge={soft=0.6, lost=0.4}})

--@ chunk 12

blend(trees_m:grow(2), {angle=1.5708, tool={kind="badger", width=10}})
blend(rect(200, 380, 150, 55):soften(6), {angle=0.0, tool={kind="badger", width=10}})

--@ chunk 13

trunkP = pile{{"lead white",2},{"raw umber",0.6},{"bone black",0.35}}
local r = brush{kind="round", width=4, point=0.4, stiffness=0.55}
local trunks = {
  {{204,428},{206,410},{203,392},{198,375}},
  {{252,422},{249,404},{246,388},{240,370}},
  {{258,420},{262,402},{270,385}},
  {{312,414},{314,396},{318,378},{322,362}},
  {{344,404},{343,390},{346,378}},
}
for i, t in ipairs(trunks) do
  r:load(trunkP, rand(0.5, 0.7))
  r:stroke(t, {pressure={rand(0.55, 0.7), 0.15}, ramps={0.02, 0.6}, shake=0.8})
end

--@ chunk 14

local r = brush{kind="filbert", width=7, stiffness=0.55}
local trunks = {
  {{204,428},{205,412},{203,398}},
  {{251,423},{250,408},{247,394}},
  {{313,416},{314,402},{317,388}},
  {{344,405},{344,394}},
}
for i, t in ipairs(trunks) do
  r:load(trunkP, 0.6)
  r:stroke(t, {pressure={0.55, 0.25}, ramps={0.05, 0.5}, shake=0.8, orient="across"})
end
blend(rect(195, 380, 160, 50):soften(4), {angle=1.5708, tool={kind="badger", width=8}})

--@ chunk 15

print(wait(2*24*60))
for _, p in ipairs({{500,150},{270,330},{270,410},{600,500},{100,520}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 16

glazeG = pile{{"raw umber",1},{"bone black",0.3},{"lead white",0.6}, medium=0.75}
local m = (poly({{182,372},{360,360},{365,412},{340,425},{260,432},{190,440}}, true):roughen(6, 30, 51)):soften(10)
m = m:times(function(x, y) return smoothstep(360, 425, y) * 0.9 + 0.1 end)
work(m, {hand="glaze", pile=glazeG, tool={kind="filbert", width=12, stiffness=0.3}, length={20,50}, angle=1.5708, angle_jitter=0.3, coverage=1.2, pressure={0.2,0.45}, clip=true})

--@ chunk 17

local m = (poly({{176,366},{368,354},{372,416},{344,432},{260,440},{184,448}}, true)):soften(8)
blend(m, {angle=1.5708, tool={kind="badger", width=16}})
blend(m, {angle=1.35, tool={kind="badger", width=16}})

--@ chunk 18

print(wait(26*60))
print(drying(270, 410), drying(270, 300))

--@ chunk 19

local area = ellipse(268, 330, 150, 150):roughen(14, 80, 61):soften(25)
local sky_part = area * above({{-20,337},{1020,337}})
local land_near = area * land_m:shrink(1) * below({{-20,329},{1020,329}})
work(sky_part, {hand="broad", pile=fogA, angle=0.0, coverage=1.8, fill=true, length={60,140}, angle_jitter=0.06,
  edge={lost=0.7, soft=0.3, period=60}})
work(land_near * above({{-20,395},{1020,395}}):soften(10), {hand="body", pile=landFar, angle=-0.1, coverage=1.8, fill=true, length={30,70}, angle_jitter=0.08,
  edge={lost=0.6, soft=0.4}})
work(land_near * below({{-20,390},{1020,390}}):soften(10), {hand="body", pile=landMid, angle=-0.2, coverage=1.8, fill=true, length={30,70}, angle_jitter=0.08,
  edge={lost=0.6, soft=0.4}})

--@ chunk 20

local cx, cy = 198, 362
local dome = ellipse(cx, cy, 88, 72)
local skirt = poly({{cx - 92, cy}, {cx + 90, cy}, {cx + 84, 438}, {cx + 40, 446}, {cx - 10, 449}, {cx - 60, 446}, {cx - 90, 438}}, true)
willow_m = (dome + skirt):roughen(7, 18, 71)
-- fringe: the lower edge in hanging strands
local fringe = mask(function(x, y) local v = math.sin(x * 0.55) * 0.5 + math.sin(x * 0.23 + 1.3) * 0.5; return (y < 436 + 9 * v) and 1 or 0 end)
willow_m = willow_m * fringe
local upper = willow_m * above({{-20,385},{400,385}}):soften(20)
local lower = willow_m * below({{-20,375},{400,375}}):soften(20)
work(upper, {hand="body", pile=treeP, angle=1.5708, angle_jitter=0.3, coverage=1.6, fill=true, length={14,40}, pressure={0.35,0.6},
  edge={soft=0.5, lost=0.4, found=0.1, period=30}})
work(lower, {hand="body", pile=treeP2, angle=1.5708, angle_jitter=0.15, coverage=1.6, fill=true, length={16,44}, pressure={0.35,0.6},
  edge={soft=0.6, lost=0.2, found=0.2, period=30}})

--@ chunk 21

blend(willow_m:grow(3):soften(3), {angle=1.5708, tool={kind="badger", width=12}})

--@ chunk 22

strandP = pile{{"lead white",1.8},{"raw umber",0.6},{"bone black",0.35},{"green earth",0.25}, medium=0.2}
local cx, cy = 198, 362
local rg = brush{kind="rigger", width=2.0, point=1, stiffness=0.4}
for k = 1, 16 do
  local side = (k % 2 == 0) and 1 or -1
  local spread = rand(0.25, 1.0)
  local x0, y0 = cx + randn(0, 12), cy - rand(30, 60)
  local px = x0 + side * spread * rand(30, 50)
  local py = y0 - rand(5, 18)
  local qx = x0 + side * spread * rand(55, 85)
  local qy = y0 + rand(10, 30)
  local ex = qx + side * rand(0, 8)
  local ey = rand(410, 440)
  rg:load(strandP, rand(0.35, 0.6))
  rg:stroke({{x0, y0}, {px, py}, {qx, qy}, {lerp(qx, ex, 0.5), lerp(qy, ey, 0.5)}, {ex, ey}},
    {pressure={rand(0.25, 0.45), 0.02}, ramps={0.1, 0.5}, shake=1.0})
end
-- trunk in the gap
local t = brush{kind="filbert", width=8, stiffness=0.6}
t:load(trunkP, 0.8)
t:stroke({{196,456},{197,440},{195,424},{192,408}}, {pressure={0.75, 0.2}, ramps={0.02, 0.6}, shake=0.8, orient="across"})
t:load(trunkP, 0.5)
t:stroke({{197,430},{208,412},{214,396}}, {pressure={0.4, 0.05}, ramps={0.0, 0.6}, shake=0.8})

--@ chunk 23

blend(willow_m:grow(4):soften(4), {angle=1.5708, tool={kind="badger", width=10}, pressure={0.15, 0.3}})

--@ chunk 24

bankMid = pile{{"raw umber",1.5},{"bone black",0.25},{"lead white",2.2},{"yellow ochre",0.3},{"green earth",0.4}}
local near = {{-20,694},{10,662},{40,628},{70,590},{100,552},{140,515}}
local mid  = {{140,515},{200,471},{260,440},{320,410},{370,388}}
local lipN = ribbon(near, {9, 8, 7, 6, 5, 4.5}):roughen(2, 12, 81)
local lipM = ribbon(mid, {4.5, 3.5, 2.6, 1.8, 1.2}):roughen(1.2, 10, 82)
work(lipN, {hand="detail", pile=bankP, angle=-0.9, coverage=2, fill=true, edge={found=0.5, soft=0.5}})
work(lipM:times(function(x, y) return smoothstep(385, 450, y) end), {hand="detail", pile=bankMid, angle=-0.5, coverage=1.6, fill=true, edge={soft=0.6, lost=0.4}})

--@ chunk 25

reedP = pile{{"raw umber",2},{"green earth",0.8},{"bone black",0.45},{"yellow ochre",0.35},{"lead white",0.3}}
reedL = pile{{"yellow ochre",1},{"lead white",2},{"raw umber",0.5},{"bone black",0.08}}
reeds = {}
function reed_clump(x, y, n, hmax, pile, wscale)
  local rg = brush{kind="rigger", width=math.max(1.2, 2.6 * wscale), point=1, stiffness=0.5}
  for i = 1, n do
    local bx = x + randn(0, hmax * 0.12)
    local by = y + randn(0, hmax * 0.02)
    local h = hmax * rand(0.45, 1.0)
    local lean = randn(0, 0.18) + 0.08
    local bend = randn(0, 0.15)
    local pts = {}
    for k = 0, 4 do
      local t = k / 4
      local a = lean + bend * t * t
      pts[#pts+1] = {bx + math.sin(a) * h * t, by - math.cos(a) * h * t}
    end
    if rg:fullness() < 0.35 then rg:load(pile, rand(0.5, 0.8)) end
    local p0 = clamp(rand(0.55, 0.85), 0.05, 1)
    rg:stroke(pts, {pressure={p0, 0.0}, ramps={0.03, 0.7}, shake=0.7})
    reeds[#reeds+1] = {pts=pts, w=wscale}
  end
end
-- foreground clump in the shallows (over the old swatches) and along the near bank
reed_clump(135, 646, 22, 120, reedP, 1.0)
reed_clump(60, 628, 18, 110, reedP, 1.0)
reed_clump(28, 668, 14, 130, reedP, 1.1)
reed_clump(95, 575, 12, 70, reedP, 0.75)
reed_clump(150, 520, 10, 48, reedP, 0.6)
reed_clump(122, 600, 8, 80, reedL, 0.8)
print(#reeds)

--@ chunk 26

reedD = pile{{"raw umber",2},{"bone black",0.7},{"green earth",0.6},{"lead white",0.15}}
local bases = {{135,648,40,12},{60,632,36,12},{24,670,34,14},{95,578,24,8},{150,522,18,6},{122,602,18,7}}
local m = nil
for i, b in ipairs(bases) do
  local e = ellipse(b[1], b[2] - b[4] * 0.6, b[3] * 0.6, b[4]):roughen(4, 10, 90 + i)
  m = m and (m + e) or e
end
-- blades of the reed base, as a mass of short upright strokes
work(m, {hand="hatch", pile=reedD, angle=-1.45, angle_jitter=0.25, coverage=2.2, length={8,22}, fill=true, edge={found=0.3, soft=0.4, lost=0.3, period=20}})
-- more blades from the bases, darker
reed_clump(135, 646, 26, 130, reedD, 1.0)
reed_clump(60, 630, 20, 115, reedD, 1.0)
reed_clump(24, 668, 16, 140, reedD, 1.15)
reed_clump(95, 576, 12, 75, reedP, 0.75)
-- small tufts breaking the bank line in the middle distance
for _, t in ipairs({{176,490,8,26},{212,466,7,20},{248,447,6,15},{285,428,6,12},{330,404,5,9}}) do
  reed_clump(t[1], t[2], t[3], t[4], bankMid, 0.45)
end

--@ chunk 27

reedMid = pile{{"raw umber",1.6},{"bone black",0.4},{"green earth",0.5},{"lead white",0.6},{"yellow ochre",0.2}}
local bases = {{135,648,40,12},{60,632,36,12},{24,670,34,14},{95,578,24,8},{150,522,18,6},{122,602,18,7}}
local m = nil
for i, b in ipairs(bases) do
  local e = ellipse(b[1], b[2] - b[4] * 0.6, b[3] * 0.6 + 4, b[4] + 4)
  m = m and (m + e) or e
end
-- break the knots up: drag blades up out of each base, and pull its bottom edge into the water
local rg = brush{kind="rigger", width=2.8, point=1, stiffness=0.55}
for i, b in ipairs(bases) do
  for k = 1, 18 do
    local bx = b[1] + rand(-b[3] * 0.65, b[3] * 0.65)
    local by = b[2] + rand(-b[4] * 1.2, b[4] * 0.2)
    local h = rand(0.5, 1.2) * b[3]
    local a = randn(0, 0.22) + 0.05
    if rg:fullness() < 0.35 then rg:load(reedMid, rand(0.5, 0.75)) end
    rg:stroke({{bx, by + 4}, {bx + math.sin(a) * h * 0.5, by - h * 0.5}, {bx + math.sin(a * 1.4) * h, by - h}},
      {pressure={rand(0.6, 0.9), 0.0}, ramps={0.0, 0.6}, shake=0.8})
  end
end
-- dissolve the lowest edges of the bases into the water
local feet = nil
for i, b in ipairs(bases) do
  local e = ellipse(b[1], b[2] + 2, b[3] * 0.75, 7)
  feet = feet and (feet + e) or e
end
blend(feet, {angle=1.5708, tool={kind="badger", width=8}})

--@ chunk 28

print(wait(8*60))
print(drying(135,640), drying(60,625))
local inWater = {{135,646,30,16},{122,598,16,12},{150,518,14,9}}
local onLand  = {{60,628,26,14},{95,574,18,10},{24,666,24,14}}
local wm, lm = nil, nil
for _, b in ipairs(inWater) do local e = ellipse(b[1], b[2], b[3], b[4]) wm = wm and (wm + e) or e end
for _, b in ipairs(onLand) do local e = ellipse(b[1], b[2], b[3], b[4]) lm = lm and (lm + e) or e end
work(wm:roughen(3, 10, 101), {hand="body", tool="filbert 6", pile=waterB, angle=0.0, angle_jitter=0.1, coverage=2.4, fill=true, length={10,24}, edge={soft=0.6, lost=0.4}})
work(lm:roughen(3, 10, 102), {hand="body", tool="filbert 6", pile=landNear, angle=-0.6, angle_jitter=0.2, coverage=2.4, fill=true, length={10,24}, edge={soft=0.6, lost=0.4}})

--@ chunk 29

print(wait(30*60))
print(drying(135,646), drying(60,628))

--@ chunk 30

local bases = {{135,650,30,12},{60,632,26,12},{24,670,24,14},{95,578,18,8},{150,522,14,6},{122,603,16,7}}
local rg = brush{kind="rigger", width=2.2, point=1, stiffness=0.5}
-- a thin dark waterline under the water clumps, broken
for _, b in ipairs({{135,650,30},{122,603,16},{150,522,14}}) do
  local f = brush{kind="round", width=2.2, point=0.3, stiffness=0.6}
  f:load(reedD, 0.5)
  f:stroke({{b[1] - b[3], b[2] + 1}, {b[1] - b[3] * 0.3, b[2] + 2}, {b[1] + b[3] * 0.4, b[2] + 1}, {b[1] + b[3], b[2] + 2}}, {pressure={0.5, 0.2}, swell={1, 0.4, 1.1, 0.5}, shake=1.2})
end
-- dense blades rising from every base, the lower third of each blade inside the old patch
for i, b in ipairs(bases) do
  local n = math.floor(b[3] * 1.4)
  for k = 1, n do
    local bx = b[1] + rand(-b[3], b[3]) * rand(0.4, 1.0)
    local by = b[2] + rand(-2, 2)
    local h = b[3] * rand(1.2, 3.6)
    local a = randn(0, 0.2) + 0.06
    local bend = randn(0, 0.25)
    local pts = {}
    for s = 0, 4 do
      local t = s / 4
      local aa = a + bend * t * t
      pts[#pts+1] = {bx + math.sin(aa) * h * t, by - math.cos(aa) * h * t}
    end
    if rg:fullness() < 0.4 then rg:load((k % 3 == 0) and reedP or reedD, rand(0.55, 0.8)) end
    rg:stroke(pts, {pressure={rand(0.7, 0.95), 0.0}, ramps={0.0, 0.65}, shake=0.7})
  end
end

--@ chunk 31

hullP = pile{{"bone black",1},{"raw umber",1.2},{"lead white",0.9}}
figP  = pile{{"bone black",1},{"raw umber",1},{"lead white",1.3},{"red earth",0.1}}
hull_m = poly({{543,440},{552,445},{600,446.5},{636,445},{649,437.5},{646,443},{634,452},{596,454.5},{560,453},{548,448}}, true)
work(hull_m, {hand="detail", pile=hullP, angle=0.02, coverage=2.6, fill=true, clip=true, tool={kind="round", width=2.4, stiffness=0.6}})
-- the gunwale catches a little of the sky
local g = brush{kind="round", width=1.3, point=0.6, stiffness=0.6}
g:load(greyM, 0.5)
g:stroke({{548,444},{575,445.6},{605,446},{632,444.6},{646,438.5}}, {pressure={0.35, 0.3}, swell={0.6, 1, 0.8, 1, 0.5}, shake=0.6})

--@ chunk 32

local o = body_of{spine={{567,446},{567.5,432},{568,420},{569,413}}, widths={7.2, 6.4, 5.4, 4.6}, char="soft", amount=0.4}
fig_m = o:mask() + ellipse(569.5, 408.5, 2.9, 3.3)
work(fig_m, {hand="detail", pile=figP, angle=-1.5708, coverage=2.6, fill=true, clip=true, tool={kind="round", width=1.8, stiffness=0.6}})
-- the pole, held at chest height, its foot in the water ahead of the stern
local p = brush{kind="rigger", width=1.3, point=0.7, stiffness=0.6}
p:load(figP, 0.7)
p:stroke({{585,386},{580,404},{575,420},{570,437},{566,452}}, {pressure={0.55, 0.6}, ramps={0.05, 0.1}, shake=0.4})
p:load(greyM, 0.5)
p:stroke({{566,453},{564.5,459},{563.5,463}}, {pressure={0.4, 0.05}, ramps={0.0, 0.8}, shake=0.4})

--@ chunk 33

local coat = poly({{562,446},{572,446},{573,436},{574,426},{575.5,419},{573,415.5},{567,415},{562.5,417},{561.5,425},{561,436}}, true)
local head = ellipse(570.5, 410.5, 3.1, 3.4)
local hat  = ellipse(570.2, 408.2, 3.6, 1.6)
fig2_m = (coat + head + hat):roughen(0.5, 4, 111)
work(fig2_m, {hand="detail", pile=figP, angle=-1.5708, coverage=2.8, fill=true, clip=true, tool={kind="round", width=2.0, stiffness=0.6}})
local a = brush{kind="round", width=2.2, point=0.5, stiffness=0.6}
a:load(figP, 0.7)
a:stroke({{573.5,418},{576.5,414.5},{579.5,411}}, {pressure={0.7, 0.55}, shake=0.4})
a:load(figP, 0.7)
a:stroke({{571,424},{574.5,424.5},{577,423}}, {pressure={0.7, 0.55}, shake=0.4})

--@ chunk 34

reflP = pile{{"lead white",2.6},{"raw umber",0.55},{"bone black",0.35}}
local ax = 453
local src = fig2_m + hull_m
local refl = mask(function(x, y)
  if y < ax then return 0 end
  local sy = 2 * ax - y
  local v = src:at(x + (y - ax) * 0.02, sy)
  local fall = clamp(1 - (y - ax) / 60, 0, 1)
  -- broken by the slight swell of the water
  local band = 0.65 + 0.35 * math.sin(y * 0.9 + x * 0.03)
  return v * fall * band
end)
work(refl:soften(1.2), {hand="detail", pile=reflP, angle=0.0, coverage=2.0, fill=true, tool={kind="round", width=2.0, stiffness=0.5}})
blend(refl:grow(5):soften(4), {angle=0.0, tool={kind="badger", width=8}})

--@ chunk 35

blend(ellipse(645, 469, 18, 7):soften(3), {angle=0.0, tool={kind="badger", width=8}})
local c = brush{kind="round", width=1.6, point=0.5, stiffness=0.6}
c:load(hullP, 0.5)
c:stroke({{556,454.5},{590,456},{620,455.2},{636,453}}, {pressure={0.45, 0.25}, swell={0.5, 1, 1, 0.4}, shake=0.6})
-- ripples spreading from the pole and the stern, long and faint
local rip = {
  {{520,462},{545,463.5},{570,464}},
  {{586,468},{625,469.5},{668,468.5}},
  {{498,474},{530,476},{560,476.5}},
  {{600,481},{650,482.5},{712,481}},
  {{470,489},{520,491},{556,491.5}},
}
for i, r in ipairs(rip) do
  local b = brush{kind="round", width=1.4, point=0.6, stiffness=0.5}
  b:load((i % 2 == 0) and fogW or greyM, 0.35)
  b:stroke(r, {pressure={0.05, 0.05}, swell={0.2, 1.0, 0.2}, ramps={0.4, 0.4}, shake=0.5})
end

--@ chunk 36

print(wait(36*60))
for _, p in ipairs({{567,430},{600,450},{340,415},{770,150},{850,300}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 37

local zone = ellipse(345, 408, 42, 26):roughen(4, 20, 121)
local lipline = {{280,430},{320,410},{370,388},{420,370}}
local landz = zone * above(lipline)
local waterz = zone * below(lipline)
work(landz, {hand="body", tool="filbert 6", pile=landFar, angle=-0.4, angle_jitter=0.15, coverage=2.4, fill=true, length={12,30}, edge={soft=0.6, lost=0.4}})
work(waterz, {hand="body", tool="filbert 6", pile=waterA, angle=0.0, angle_jitter=0.06, coverage=2.4, fill=true, length={14,34}, edge={soft=0.6, lost=0.4}})
local l = brush{kind="round", width=1.6, point=0.5, stiffness=0.6}
l:load(bankMid, 0.4)
l:stroke({{300,421},{322,410},{346,399},{372,388}}, {pressure={0.3, 0.1}, swell={1, 0.6, 0.9, 0.3}, shake=0.8})

--@ chunk 38

veil = pile{{"lead white",6},{"raw umber",0.12},{"yellow ochre",0.12}, medium=0.45}
local nz = noise{seed=17, period=120, octaves=3, stretch={0, 2.5}}
local zone = rect(560, 230, 460, 150):soften(30) * mask(function(x, y) return smoothstep(0.3, 0.6, nz:at01(x, y)) end)
work(zone, {hand="scumble", pile=veil, angle=0.0, angle_jitter=0.2, length={20,50}, pressure={0.15,0.35}, coverage=1.0, dips={5, 0.4, 0.5}})
blend(rect(560, 230, 460, 150):soften(30), {angle=0.0})

--@ chunk 39

sunP = pile{{"lead white",8},{"chrome yellow",0.12},{"yellow ochre",0.08}}
local disc = ellipse(742, 168, 24, 24)
work(disc, {hand="detail", pile=sunP, angle=0.0, coverage=2.4, fill=true, clip=true, tool={kind="round", width=3, stiffness=0.5}})
blend(ellipse(742, 168, 34, 34):soften(8), {angle=0.0, tool={kind="badger", width=18}})

--@ chunk 40

sunP2 = pile{{"lead white",8},{"chrome yellow",0.18},{"vermilion",0.01}}
local disc = ellipse(742, 168, 22, 22):soften(1.5)
work(disc, {hand="detail", pile=sunP2, angle=0.6, angle_jitter=0.5, coverage=3, fill=true, clip=true, tool={kind="round", width=3.5, stiffness=0.5}})

--@ chunk 41

fogR = pile{{"lead white",6},{"raw umber",0.22},{"yellow ochre",0.2},{"bone black",0.06}}
local ring = ellipse(742, 168, 46, 46):soften(12) - ellipse(742, 168, 22.5, 22.5):soften(0.8)
work(ring, {hand="body", tool="filbert 6", pile=fogR, angle=function(x, y) return math.atan(y - 168, x - 742) + 1.5708 end,
  angle_jitter=0.2, coverage=2.2, fill=true, length={10,24}, clip=true})

--@ chunk 42

haloP = pile{{"lead white",8},{"yellow ochre",0.16},{"raw umber",0.04}}
local ring = ellipse(742, 168, 50, 50):soften(14) - ellipse(742, 168, 23, 23):soften(0.8)
work(ring, {hand="body", tool="filbert 6", pile=haloP, angle=function(x, y) return math.atan(y - 168, x - 742) + 1.5708 end,
  angle_jitter=0.2, coverage=2.4, fill=true, length={10,24}, clip=true})
local outer = ellipse(742, 168, 64, 64):soften(14) - ellipse(742, 168, 30, 30):soften(4)
blend(outer, {angle=function(x, y) return math.atan(y - 168, x - 742) + 1.5708 end, tool={kind="badger", width=14}})

--@ chunk 43

shadeG = pile{{"raw umber",1},{"bone black",0.25},{"green earth",0.3},{"lead white",0.5}, medium=0.7}
local under = poly({{100,400},{300,395},{310,445},{280,462},{200,470},{110,460}}, true):soften(16)
under = under:times(function(x, y) return smoothstep(395, 450, y) end)
local corner = poly({{-20,470},{150,500},{260,560},{300,690},{-20,690}}, true):soften(40)
corner = corner:times(function(x, y) return smoothstep(470, 680, y) * smoothstep(320, 0, x) end)
work(under + corner, {hand="glaze", pile=shadeG, coverage=1.0, pressure={0.15,0.3}, angle=0.0, angle_jitter=0.2, clip=true})
blend((under + corner):grow(6):soften(10), {angle=0.0, tool={kind="badger", width=30}})

--@ chunk 44

print(drying(200,430), drying(150,600))
local b = brush{kind="flat", width=14, stiffness=0.7, pickup=1.0}
b:wipe(1)
local n = 0
for pass = 1, 2 do
  for y = 405, 470, 6 do
    b:wipe(1)
    b:stroke({{80, y + randn(0,1)}, {200, y + randn(0,1.5)}, {330, y + randn(0,1)}}, {pressure={0.7, 0.7}, ramps={0.05,0.05}, shake=0.4})
    n = n + 1
  end
end
for y = 480, 690, 7 do
  b:wipe(1)
  b:stroke({{-20, y + randn(0,1)}, {140, y + randn(0,1.5)}, {300, y + randn(0,1)}}, {pressure={0.7, 0.7}, ramps={0.05,0.05}, shake=0.4})
  n = n + 1
end
print(n)

--@ chunk 45

local low = rect(160, 555, 170, 120):soften(10)
local up  = rect(270, 395, 75, 85):soften(8) - willow_m
blend(low, {angle=1.5708, tool={kind="badger", width=20}})
blend(low, {angle=0.2, tool={kind="badger", width=20}})
blend(up, {angle=1.5708, tool={kind="badger", width=14}})
blend(up, {angle=-0.3, tool={kind="badger", width=14}})
