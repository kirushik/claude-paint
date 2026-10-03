-- easel session "window": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ engine 2

--@ chunk 1

canvas{size=600, aspect=1.35, linen={18,16}, seed=1203,
  ground={{pile={{"lead white",6},{"yellow ochre",1},{"raw umber",0.3}}, um=140, apply="knife", texture=0.4},
          {pile={{"lead white",8},{"yellow ochre",1},{"red earth",0.3}}, um=40, apply="brush"}}}
print(W, H)

--@ chunk 2

h = pencil("2H")
-- horizon / woods base
h:sketch({{0,470},{200,468},{420,472},{600,476},{800,470},{1000,466}}, {pressure=0.25})
-- woods top
h:sketch({{0,418},{120,412},{250,425},{340,446},{450,448},{520,432},{580,440},{640,452},{760,450},{880,436},{1000,442}}, {pressure=0.2})
-- house gable end and side
h:line({{606,467},{665,416},{726,467}}, {pressure={0.3,0.35}, smooth=false})
h:line({{614,464},{614,502},{718,503},{718,464}}, {pressure=0.3, smooth=false})
h:line({{665,416},{778,423},{792,468}}, {pressure=0.3, smooth=false})
h:line({{718,503},{788,500},{788,468}}, {pressure=0.3, smooth=false})
h:line({{655,470},{675,470},{675,488},{655,488},{655,470}}, {pressure=0.35, smooth=false})
-- tree
h:sketch({{545,494},{548,420},{544,340},{550,262}}, {pressure=0.3})
-- drift line and fence
h:sketch({{0,610},{220,590},{480,560},{700,548},{1000,572}}, {pressure=0.2})
h:sketch({{90,725},{230,650},{360,590},{460,545},{520,515}}, {pressure=0.2})

--@ chunk 3

sky_top = pile{{"Prussian blue",1},{"smalt",2.5},{"lead white",2},{"raw umber",0.4},{"bone black",0.15}, medium=0.1}
sky_mid = pile{{"smalt",3},{"lead white",4},{"Prussian blue",0.35},{"cobalt blue",0.6}, medium=0.1}
sky_low = pile{{"lead white",7},{"pale smalt",1.5},{"red earth",0.15},{"cobalt blue",0.2}, medium=0.08}
glow    = pile{{"lead white",9},{"yellow ochre",1},{"vermilion",0.25},{"chrome yellow",0.35}, medium=0.08}
local hz = function(x, y) return randn(0, 0.03) end
local w = function(y0, y1) return rect(-20, y0, 1040, y1 - y0):roughen(18, 160, 7) end
work(w(-20, 200), {hand="broad", pile=sky_top, angle=0.02, coverage=1.6, angle_jitter=0.1})

--@ chunk 4

sky_deep = pile{{"Prussian blue",1.5},{"smalt",2},{"lead white",1.2},{"raw umber",0.6},{"bone black",0.3}, medium=0.12}
local m = rect(-20, -20, 1040, 150):roughen(20, 180, 11)
work(m, {hand="broad", pile=sky_deep, angle=0.02, coverage=2, fill=true, length={160,320}, angle_jitter=0.06})
local m2 = rect(-20, 120, 1040, 110):roughen(20, 180, 12)
work(m2, {hand="broad", pile=sky_top, angle=0.0, coverage=1.8, fill=true, length={160,320}, angle_jitter=0.06})

--@ chunk 5

local r = function(y0, h, s) return rect(-20, y0, 1040, h):roughen(16, 200, s) end
work(r(215, 110, 21), {hand="broad", pile=sky_mid, angle=0.0, coverage=1.8, fill=true, length={160,320}, angle_jitter=0.05})
work(r(310, 90, 22), {hand="broad", pile=sky_low, angle=0.0, coverage=1.8, fill=true, length={160,320}, angle_jitter=0.05})
work(r(385, 100, 23), {hand="broad", pile=glow, angle=0.0, coverage=1.8, fill=true, length={160,320}, angle_jitter=0.04})

--@ chunk 6

print(drying(500,250), drying(500,100))
blend(rect(-20, 90, 1040, 360):soften(30), {angle=0.0})
blend(rect(-20, 180, 1040, 240):soften(30), {angle=0.03})

--@ chunk 7

woods = pile{{"Prussian blue",0.8},{"raw umber",2},{"bone black",0.4},{"lead white",1.6},{"smalt",1}, medium=0.05}
local top = {{-20,420},{120,412},{250,425},{340,446},{450,448},{520,432},{580,440},{640,452},{760,450},{880,436},{1020,442}}
woods_m = (below(top) * above({{-20,480},{1020,476}})):roughen(9, 22, 31)
work(woods_m, {hand="body", pile=woods, angle=-1.5708, angle_jitter=0.35, coverage=1.8, fill=true,
  edge={found=0.25, soft=0.5, lost=0.25, period=60}})

--@ chunk 8

woods_dk = pile{{"Prussian blue",1},{"raw umber",2.5},{"bone black",0.7},{"lead white",0.7},{"smalt",0.5}}
local m = rect(-20, 455, 1040, 25)
local xs = uneven(46, -10, 1010, 0.7, 0.5, 41)
local base = function(x)
  if x < 260 then return 428 elseif x < 330 then return lerp(428, 448, (x-260)/70)
  elseif x < 470 then return 452 elseif x < 560 then return 440 elseif x < 640 then return 450
  elseif x < 780 then return 456 elseif x < 900 then return 440 else return 446 end end
for i, x in ipairs(xs) do
  local b = base(x) + randn(0, 4)
  local r = rand(10, 26)
  local hgt = rand(0.6, 1.4) * r
  m = m + ellipse(x, b + 10, r, hgt + 10)
end
-- a few conifer spires on the left and right of the band
for _, c in ipairs({{60, 392}, {96, 400}, {178, 404}, {205, 396}, {868, 414}, {905, 420}, {470, 430}}) do
  local cx, ty = c[1], c[2]
  m = m + poly({{cx, ty}, {cx - 13, 470}, {cx + 13, 470}})
end
woods2_m = m:roughen(6, 14, 52)
work(woods2_m, {hand="body", pile=woods_dk, angle=-1.5708, angle_jitter=0.5, coverage=1.6, fill=true, length={10,30},
  edge={found=0.3, soft=0.5, lost=0.2, period=40}})

--@ chunk 9

snow_far  = pile{{"lead white",7},{"pale smalt",1},{"red earth",0.08},{"yellow ochre",0.25}, medium=0.05}
snow_mid  = pile{{"lead white",5},{"smalt",1.2},{"cobalt blue",0.3},{"red earth",0.1}, medium=0.05}
snow_near = pile{{"lead white",4},{"smalt",1.6},{"Prussian blue",0.12},{"raw umber",0.2},{"red earth",0.08}, medium=0.05}
house_m = poly({{604,468},{665,415},{779,422},{793,468},{790,502},{718,505},{612,504},{612,468}})
snow_m = below({{-20,474},{300,476},{600,478},{1020,472}}):roughen(4, 30, 61) - house_m:shrink(3)
local band = function(y0, y1, s) return (rect(-20, y0, 1040, y1 - y0):roughen(14, 200, s)) * snow_m end
work(band(462, 545, 71), {hand="broad", pile=snow_far, angle=0.0, coverage=1.8, fill=true, length={120,260}, angle_jitter=0.04})
work(band(530, 650, 72), {hand="broad", pile=snow_mid, angle=-0.03, coverage=1.8, fill=true, length={120,260}, angle_jitter=0.05})
work(band(630, 760, 73), {hand="broad", pile=snow_near, angle=-0.05, coverage=1.8, fill=true, length={120,260}, angle_jitter=0.06})

--@ chunk 10

snow_mid2  = pile{{"lead white",3},{"smalt",1.7},{"cobalt blue",0.4},{"red earth",0.15},{"raw umber",0.12}, medium=0.05}
snow_near2 = pile{{"lead white",2.4},{"smalt",1.9},{"Prussian blue",0.2},{"raw umber",0.3},{"red earth",0.12}, medium=0.05}
local band = function(y0, y1, s) return (rect(-20, y0, 1040, y1 - y0):roughen(16, 220, s)) * snow_m end
work(band(520, 660, 81), {hand="broad", pile=snow_mid2, angle=-0.02, coverage=1.6, fill=true, length={120,260}, angle_jitter=0.05})
work(band(640, 760, 82), {hand="broad", pile=snow_near2, angle=-0.04, coverage=1.8, fill=true, length={120,260}, angle_jitter=0.06})

--@ chunk 11

print(wait(2*24*60))
for _, p in ipairs({{500,60},{500,250},{500,400},{300,440},{300,490},{300,600},{300,700}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 12

snow_edge = pile{{"lead white",6},{"pale smalt",1.4},{"red earth",0.1},{"yellow ochre",0.15},{"smalt",0.3}}
local top = {{-20,477},{150,478},{330,480},{480,482},{600,481},{800,478},{1020,476}}
local m = (below(top):roughen(2.5, 18, 91) * above({{-20,520},{1020,516}})) - house_m
work(m, {hand="body", pile=snow_edge, angle=0.0, angle_jitter=0.05, coverage=1.8, fill=true, length={40,90},
  edge={found=0.6, soft=0.4, period=50}, clip=true})

--@ chunk 13

blend((rect(-20, 500, 1040, 40):soften(12)) - house_m:grow(4), {angle=-1.45})

--@ chunk 14

wall_front = pile{{"raw umber",2},{"Prussian blue",0.5},{"lead white",0.8},{"red earth",0.3},{"bone black",0.2}}
wall_side  = pile{{"raw umber",2},{"Prussian blue",0.7},{"lead white",0.5},{"bone black",0.4}}
gable_m = poly({{612,466},{665,421},{720,466},{719,504},{612,505}})
side_m  = poly({{718,467},{791,469},{789,501},{718,505}})
work(gable_m:roughen(1.2, 10, 3), {hand="body", tool="filbert 5", pile=wall_front, angle=-1.5708, angle_jitter=0.15, coverage=2, fill=true, length={10,30}, clip=true})
work(side_m:roughen(1.2, 10, 4), {hand="body", tool="filbert 5", pile=wall_side, angle=0.03, angle_jitter=0.1, coverage=2, fill=true, length={15,40}, clip=true})

--@ chunk 15

roof_snow = pile{{"lead white",3},{"smalt",1.2},{"cobalt blue",0.3},{"raw umber",0.15},{"red earth",0.05}}
rake_snow = pile{{"lead white",5},{"pale smalt",1},{"smalt",0.3},{"red earth",0.05}}
dark      = pile{{"raw umber",2},{"Prussian blue",0.8},{"bone black",0.6},{"lead white",0.2}}
roof_m = poly({{665,416},{779,421},{795,469},{723,467}})
work(roof_m:roughen(1, 10, 5), {hand="body", tool="filbert 5", pile=roof_snow, angle=1.25, angle_jitter=0.1, coverage=2, fill=true, length={15,40}, clip=true})
-- chimney
local ch = rect(747, 403, 11, 22)
work(ch, {hand="detail", pile=dark, coverage=2, fill=true, angle=-1.5708, clip=true})
-- eave shadow on side wall
work(poly({{722,467},{795,469},{793,477},{720,474}}), {hand="detail", pile=dark, coverage=2, fill=true, angle=0.03, clip=true})

--@ chunk 16

local r = brush{kind="round", width=3.2, point=0.3, stiffness=0.6}
r:load(rake_snow, 0.8)
r:stroke({{603,470},{634,443},{666,414}}, {pressure={0.75,0.6}, ramps={0.1,0.15}, shake=0.6})
r:load(rake_snow, 0.7)
r:stroke({{666,414},{697,440},{727,469}}, {pressure={0.6,0.7}, ramps={0.1,0.15}, shake=0.6})
-- snow cap on chimney
local s = brush{kind="flat", width=4, stiffness=0.6}
s:load(rake_snow, 0.6)
s:stroke({{745,404},{760,403}}, {pressure={0.7,0.6}})
-- dark fascia just under the left rake
local d = brush{kind="round", width=1.6, point=0.5}
d:load(dark, 0.6)
d:stroke({{608,472},{636,448},{665,421}}, {pressure={0.5,0.4}, shake=0.5})

--@ chunk 17

bark = pile{{"raw umber",2},{"bone black",0.8},{"Prussian blue",0.3},{"lead white",0.15}, medium=0.15}
local rg = brush{kind="rigger", width=2.2, point=1, stiffness=0.45}
local function limb(x, y, ang, len, w, depth)
  if depth == 0 or len < 6 then return end
  local pts = {{x, y}}
  local cx, cy, a = x, y, ang
  local n = 4
  for i = 1, n do
    a = a + randn(0, 0.18)
    cx = cx + math.cos(a) * len / n
    cy = cy + math.sin(a) * len / n
    pts[#pts + 1] = {cx, cy}
  end
  if rg:fullness() < 0.3 then rg:load(bark, 0.7) end
  local p0 = clamp(rg:pressure_for(w), 0.05, 1)
  local p1 = clamp(rg:pressure_for(w * 0.55), 0.02, 1)
  rg:stroke(pts, {pressure={p0, p1}, ramps={0.02, 0.3}, shake=0.8})
  local kids = math.random(2, 3)
  for k = 1, kids do
    local t = rand(0.45, 1.0)
    local idx = math.max(2, math.floor(t * n + 0.5) + 1)
    local px, py = pts[idx][1], pts[idx][2]
    local da = (k % 2 == 0 and 1 or -1) * rand(0.35, 0.8)
    limb(px, py, ang + da + randn(0, 0.1), len * rand(0.5, 0.72), w * 0.62, depth - 1)
  end
end
rg:load(bark, 0.9)
-- trunk
local tb = brush{kind="round", width=6, point=0.4, stiffness=0.6}
tb:load(bark, 0.9)
tb:stroke({{545,497},{546,470},{548,440},{546,418}}, {pressure={0.95,0.75}, ramps={0.02,0.1}, shake=0.6})
tb:load(bark, 0.7)
tb:stroke({{546,420},{540,390},{533,355}}, {pressure={0.7,0.45}, ramps={0.0,0.3}, shake=0.6})
tb:stroke({{546,420},{556,385},{566,352}}, {pressure={0.65,0.4}, ramps={0.0,0.3}, shake=0.6})
limb(533, 356, -1.75, 110, 3.2, 4)
limb(566, 352, -1.35, 115, 3.0, 4)
limb(541, 395, -2.4, 70, 2.2, 3)
limb(553, 392, -0.7, 70, 2.2, 3)
limb(547, 440, -2.7, 45, 1.6, 2)

--@ chunk 18

local tb = brush{kind="round", width=4.5, point=0.5, stiffness=0.55}
tb:load(bark, 1.0)
tb:stroke({{546,422},{541,395},{535,365},{532,340},{528,310}}, {pressure={0.8,0.45}, ramps={0.0,0.35}, shake=0.5})
tb:load(bark, 1.0)
tb:stroke({{546,422},{554,395},{562,368},{570,345},{578,318}}, {pressure={0.75,0.4}, ramps={0.0,0.35}, shake=0.5})
tb:load(bark, 1.0)
tb:stroke({{545,500},{546,470},{547,445},{546,420}}, {pressure={1.0,0.85}, ramps={0.0,0.1}, shake=0.4})

--@ chunk 19

twig = pile{{"raw umber",2},{"bone black",0.5},{"Prussian blue",0.35},{"lead white",0.5}, medium=0.25}
local rg = brush{kind="rigger", width=1.4, point=1, stiffness=0.4}
rg:load(twig, 0.6)
local cx, cy = 528, 268
local count = 0
for i = 1, 260 do
  local th = rand(-math.pi, 0.25)          -- mostly upper half
  local rr = math.sqrt(rand(0.25, 1.0)) * rand(0.85, 1.08)
  local x = cx + math.cos(th) * 128 * rr
  local y = cy + math.sin(th) * 100 * rr
  if y < 395 and y > 150 then
    local out = math.atan(y - cy, x - cx)
    local a = lerp(out, -math.pi/2, rand(0.2, 0.55)) + randn(0, 0.25)
    local len = rand(7, 24)
    local pts = {{x, y}}
    local px, py = x, y
    for k = 1, 3 do
      a = a + randn(0, 0.3)
      px = px + math.cos(a) * len / 3; py = py + math.sin(a) * len / 3
      pts[#pts+1] = {px, py}
    end
    rg:stroke(pts, {pressure={rand(0.25, 0.5), 0.0}, ramps={0.05, 0.6}, shake=0.9})
    count = count + 1
    if count % 14 == 0 then rg:load(twig, rand(0.4, 0.7)) end
  end
end
print(count)

--@ chunk 20

local rg = brush{kind="rigger", width=2.0, point=1, stiffness=0.45}
local paths = {
  {{517,300},{492,272},{463,243},{432,216},{410,200}},
  {{506,252},{482,226},{458,203},{440,188}},
  {{520,272},{527,232},{534,194},{540,166}},
  {{584,298},{610,276},{640,256},{668,240}},
  {{600,252},{624,226},{648,206},{662,196}},
  {{561,262},{566,222},{574,186},{581,160}},
  {{590,330},{620,318},{648,300},{668,292}},
  {{470,302},{442,286},{412,271},{396,264}},
  {{545,235},{555,205},{560,180}},
  {{495,330},{470,322},{448,318}},
}
for i, p in ipairs(paths) do
  rg:load(bark, 0.6)
  local w0 = (i <= 8) and 0.55 or 0.4
  rg:stroke(p, {pressure={w0, 0.02}, ramps={0.0, 0.5}, shake=0.8})
end

--@ chunk 21

haze = pile{{"raw umber",2},{"bone black",0.4},{"Prussian blue",0.4},{"lead white",1.4}, medium=0.35}
local crown = ellipse(530, 255, 130, 100):soften(25) - ellipse(530, 280, 70, 60):soften(30)
crown = crown * above({{300,330},{760,330}}):soften(30)
stipple(crown, {pile=haze, tool={kind="fan", width=7, stiffness=0.4}, coverage=0.35, pressure={0.1, 0.3},
  dips={30, 0.25, 0.6}, drag={6, -1.3}, twist=0.6, cluster={0.6, 30}, feather=0.5})

--@ chunk 22

print(wait(30*60))
for _, p in ipairs({{300,490},{300,560},{300,700},{640,490},{750,490},{700,440},{545,300}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 23

snow_glaze = pile{{"smalt",2},{"Prussian blue",0.12},{"red earth",0.12},{"lead white",0.35}, medium=0.7}
local field = (snow_m - house_m:grow(2)) * below({{-20,492},{1020,488}}):soften(10)
work(field, {hand="glaze", pile=snow_glaze, angle=-0.02, coverage=1.2, clip=true, fill=true})
local near = field * below({{-20,590},{400,575},{1020,560}}):soften(40)
work(near, {hand="glaze", pile=snow_glaze, angle=-0.04, coverage=1.2, clip=true, fill=true})

--@ chunk 24

print(drying(300,600))
local field = (snow_m - house_m:grow(3)) * below({{-20,486},{1020,482}}):soften(6)
blend(field, {angle=0.0})
blend(field, {angle=-0.08})

--@ chunk 25

print(wait(24*60))
for _, p in ipairs({{300,560},{300,700},{640,490},{600,500}}) do print(p[1], p[2], drying(p[1], p[2])) end
print(wait(24*60))
for _, p in ipairs({{300,560},{300,700}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 26

snow_lit  = pile{{"lead white",5},{"pale smalt",1},{"red earth",0.08},{"yellow ochre",0.1},{"raw umber",0.05}, medium=0.1}
snow_mt   = pile{{"lead white",3.5},{"pale smalt",1.2},{"smalt",0.4},{"raw umber",0.18},{"red earth",0.1}, medium=0.1}
snow_shd  = pile{{"lead white",2},{"smalt",1.3},{"raw umber",0.35},{"red earth",0.15},{"Prussian blue",0.08}, medium=0.1}
drift = {{-20,612},{220,592},{480,562},{700,550},{1020,574}}
field = (snow_m - house_m) * below({{-20,483},{1020,479}})
local nz = noise{seed=5, period=180, octaves=3, stretch={0, 3}}
local patches = mask(function(x, y) return smoothstep(0.38, 0.62, nz:at01(x, y)) end)
work(field * above(drift):grow(10) * patches, {hand="scumble", pile=snow_mt, angle=0.0, angle_jitter=0.15,
  length={18,40}, pressure={0.3,0.6}, dips={6,0.5,0.5}, coverage=1.0})
local far = field * above({{-20,535},{500,528},{1020,522}}):soften(18)
work(far, {hand="scumble", pile=snow_lit, angle=0.0, angle_jitter=0.08, coverage=1.0, length={25,60}, pressure={0.35,0.6}})

--@ chunk 27

blend(field * below({{-20,486},{1020,482}}) * above({{-20,640},{1020,600}}):soften(20), {angle=0.0})
tA = pile{{"lead white",2},{"smalt",2},{"raw umber",0.2},{"red earth",0.1}}
tB = pile{{"lead white",2},{"smalt",1.5},{"cobalt blue",0.4},{"raw umber",0.3},{"red earth",0.12}}
tC = pile{{"lead white",2},{"pale smalt",2},{"bone black",0.12},{"red earth",0.1}}
tD = pile{{"lead white",2},{"cobalt blue",0.6},{"raw umber",0.35},{"red earth",0.1},{"bone black",0.05}}
tE = pile{{"lead white",3},{"Prussian blue",0.08},{"raw umber",0.25},{"red earth",0.12},{"smalt",0.5}}
tF = pile{{"lead white",2},{"Prussian blue",0.1},{"raw umber",0.4},{"red earth",0.15},{"smalt",0.8}}
local b = brush("flat", 14)
for i, p in ipairs({tA, tB, tC, tD, tE, tF}) do
  b:reload(p, 0.9)
  b:stroke({{40 + (i-1)*60, 728}, {80 + (i-1)*60, 728}}, {pressure={0.9,0.9}})
end

--@ chunk 28

tG = pile{{"lead white",1},{"smalt",2},{"cobalt blue",0.3},{"raw umber",0.15},{"red earth",0.1}}
tH = pile{{"lead white",1},{"cobalt blue",0.8},{"raw umber",0.3},{"red earth",0.1}}
tI = pile{{"lead white",1.2},{"Prussian blue",0.12},{"raw umber",0.3},{"red earth",0.15},{"smalt",1}}
tJ = pile{{"lead white",1},{"pale smalt",2},{"smalt",1},{"raw umber",0.2}}
tK = pile{{"lead white",1.5},{"cobalt blue",0.6},{"smalt",1},{"red earth",0.2},{"raw umber",0.1}}
tL = pile{{"lead white",1},{"Prussian blue",0.2},{"smalt",1.5},{"raw umber",0.5},{"red earth",0.2}}
local b = brush("flat", 14)
for i, p in ipairs({tG, tH, tI, tJ, tK, tL}) do
  b:reload(p, 0.9)
  b:stroke({{40 + (i-1)*60, 700}, {80 + (i-1)*60, 700}}, {pressure={0.9,0.9}})
end

--@ chunk 29

print(wait(36*60))
for _, p in ipairs({{300,500},{300,540},{100,700},{60,728}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 30

s_far  = pile{{"lead white",2.2},{"pale smalt",2},{"smalt",0.4},{"red earth",0.08},{"yellow ochre",0.06}, medium=0.06}
s_mid  = pile{{"lead white",1.5},{"cobalt blue",0.6},{"smalt",1},{"red earth",0.2},{"raw umber",0.1}, medium=0.06}
s_near = pile{{"lead white",1},{"smalt",2},{"cobalt blue",0.3},{"raw umber",0.15},{"red earth",0.1}, medium=0.06}
s_near2= pile{{"lead white",0.8},{"smalt",2},{"cobalt blue",0.3},{"raw umber",0.3},{"red earth",0.12},{"Prussian blue",0.04}, medium=0.06}
trunk_m = rect(540, 468, 11, 36)
sf = (snow_m - house_m - trunk_m) * below({{-20,480},{1020,477}})
local band = function(y0, y1, s) return rect(-20, y0, 1040, y1 - y0):roughen(14, 220, s) * sf end
work(band(470, 540, 101), {hand="broad", pile=s_far, angle=0.0, coverage=1.8, fill=true, length={100,220}, angle_jitter=0.04, clip=sf})
work(band(525, 622, 102), {hand="broad", pile=s_mid, angle=-0.02, coverage=1.8, fill=true, length={100,220}, angle_jitter=0.05})
work(band(605, 690, 103), {hand="broad", pile=s_near, angle=-0.03, coverage=1.8, fill=true, length={100,220}, angle_jitter=0.05})
work(band(672, 770, 104), {hand="broad", pile=s_near2, angle=-0.04, coverage=1.8, fill=true, length={100,220}, angle_jitter=0.06})

--@ chunk 31

local m = sf * below({{-20,500},{1020,496}}):soften(12)
blend(m, {angle=0.0})
blend(m, {angle=0.04})

--@ chunk 32

s_shd = pile{{"lead white",0.7},{"smalt",2},{"cobalt blue",0.3},{"raw umber",0.35},{"red earth",0.15}, medium=0.08}
local function ridge_shadow(pts, depth, seed)
  local lower = {}
  for i, p in ipairs(pts) do lower[i] = {p[1], p[2] + depth * (0.6 + 0.4 * math.sin(i * 1.7 + seed))} end
  local m = (below(pts) * above(lower)):roughen(5, 60, seed)
  return m
end
drift1 = ridge_shadow({{-20,612},{120,600},{220,592},{350,576},{480,562},{600,553},{700,550},{850,560},{1020,574}}, 38, 3)
drift2 = ridge_shadow({{560,690},{680,672},{800,660},{920,662},{1020,668}}, 30, 7)
work(drift1 * sf, {hand="body", pile=s_shd, angle=-0.05, angle_jitter=0.08, coverage=1.4, length={40,90}, fill=true,
  edge={found=0.4, soft=0.4, lost=0.2, period=80}})
work(drift2 * sf, {hand="body", pile=s_shd, angle=-0.05, angle_jitter=0.08, coverage=1.4, length={40,90}, fill=true,
  edge={found=0.4, soft=0.4, lost=0.2, period=80}})

--@ chunk 33

local function shifted(pts, d) local o = {} for i, p in ipairs(pts) do o[i] = {p[1], p[2] + d} end return o end
local r1 = {{-20,612},{120,600},{220,592},{350,576},{480,562},{600,553},{700,550},{850,560},{1020,574}}
local r2 = {{560,690},{680,672},{800,660},{920,662},{1020,668}}
local m1 = below(shifted(r1, 8)) * above(shifted(r1, 80))
local m2 = below(shifted(r2, 8)) * above(shifted(r2, 65))
blend((m1 + m2):soften(8) * sf, {angle=1.45})

--@ chunk 34

crest = pile{{"lead white",3},{"pale smalt",1.5},{"yellow ochre",0.05},{"red earth",0.04}}
local b = brush{kind="filbert", width=4, stiffness=0.5}
local r1 = {{-20,609},{120,597},{220,589},{350,573},{480,559},{600,550},{700,547},{850,557},{1020,571}}
local r2 = {{560,687},{680,669},{800,657},{920,659},{1020,665}}
for _, r in ipairs({r1, r2}) do
  -- break the crest line into a few overlapping strokes with varying pressure
  local i = 1
  while i < #r do
    b:load(crest, rand(0.5, 0.8))
    local j = math.min(#r, i + 2)
    local seg = {}
    for k = i, j do seg[#seg+1] = {r[k][1] + randn(0, 2), r[k][2] + randn(0, 1)} end
    b:stroke(seg, {pressure={rand(0.3, 0.6), rand(0.1, 0.4)}, ramps={0.2, 0.3}, shake=0.8, orient="along"})
    i = j
  end
end

--@ chunk 35

local r1 = {{-20,609},{120,597},{220,589},{350,573},{480,559},{600,550},{700,547},{850,557},{1020,571}}
local r2 = {{560,687},{680,669},{800,657},{920,659},{1020,665}}
local m = (ribbon(r1, 9) + ribbon(r2, 9)):soften(3)
blend(m, {angle=-0.6, tool={kind="badger", width=12}})

--@ chunk 36

print(wait(40*60))
for _, p in ipairs({{300,500},{300,580},{300,700},{640,505},{545,505}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 37

gable_dk = pile{{"raw umber",2},{"Prussian blue",0.5},{"bone black",0.35},{"red earth",0.3},{"lead white",0.45}}
win_m = rect(654, 469, 22, 20)
local g = (gable_m:shrink(1.5) - win_m)
work(g, {hand="body", tool="filbert 4", pile=gable_dk, angle=-1.5708, angle_jitter=0.12, coverage=2, fill=true, length={8,24}, clip=true})

--@ chunk 38

side_dk = pile{{"raw umber",2},{"Prussian blue",0.8},{"lead white",0.45},{"bone black",0.4},{"smalt",0.3}}
work(side_m:shrink(0.5) - rect(718, 466, 80, 9), {hand="body", tool="filbert 4", pile=side_dk, angle=0.03, angle_jitter=0.1, coverage=2, fill=true, length={12,30}, clip=true})

--@ chunk 39

bank = pile{{"lead white",2},{"cobalt blue",0.5},{"smalt",1},{"red earth",0.15},{"raw umber",0.08}}
local top = {{600,503},{625,499},{650,501},{680,498},{705,500},{725,499},{750,497},{775,498},{800,500}}
local bm = (below(top) * above({{595,515},{805,515}})):roughen(1.5, 12, 9)
local tm = (below({{535,500},{541,497},{546,495},{551,497},{557,501}}) * above({{530,512},{560,512}})):roughen(1.2, 8, 10)
work(bm + tm, {hand="detail", pile=bank, angle=0.0, angle_jitter=0.2, coverage=2.2, fill=true, edge={found=0.5, soft=0.5}})

--@ chunk 40

local tb = brush{kind="round", width=6, point=0.3, stiffness=0.7}
tb:load(bark, 1.0)
tb:stroke({{546,466},{545,480},{545,492},{545,500}}, {pressure={0.95,0.95}, ramps={0.0,0.05}, shake=0.3})
tb:load(bark, 1.0)
tb:stroke({{545,500},{545,488},{546,474}}, {pressure={0.95,0.95}, ramps={0.0,0.05}, shake=0.3})

--@ chunk 41

s_snowlit = pile{{"lead white",2.6},{"pale smalt",2},{"smalt",0.3},{"red earth",0.08},{"yellow ochre",0.05}}
local top = {{596,505},{625,502},{650,503},{680,501},{705,503},{725,502},{750,500},{775,501},{806,503}}
local bm = (below(top) * above({{590,520},{812,520}})):roughen(1.5, 12, 19)
local tm = (below({{528,503},{538,500},{546,498},{553,500},{562,504}}) * above({{524,518},{566,518}})):roughen(1.2, 8, 20)
work(bm + tm, {hand="body", tool="filbert 5", pile=s_snowlit, angle=0.0, angle_jitter=0.15, coverage=2.2, fill=true, length={10,30},
  edge={found=0.35, soft=0.45, lost=0.2, period=30}})

--@ chunk 42

local m = (rect(518, 503, 300, 30):soften(10)) - house_m:grow(1) - rect(541, 460, 10, 42)
blend(m, {angle=0.0, tool={kind="badger", width=18}})

--@ chunk 43

lamp_or = pile{{"chrome yellow",2},{"vermilion",0.9},{"lead white",0.4},{"yellow ochre",0.3}}
lamp_y  = pile{{"chrome yellow",1.2},{"lead white",2.2},{"vermilion",0.08}}
win = rect(655.5, 470.5, 19, 17.5)
work(win, {hand="detail", pile=lamp_or, angle=-1.5708, coverage=2.5, fill=true, clip=true})
local core = ellipse(663, 481, 7, 6):soften(2) * win
work(core, {hand="detail", pile=lamp_y, angle=-1.5708, coverage=2, fill=true, clip=true, tool={kind="round", width=1.6}})

--@ chunk 44

frame = pile{{"raw umber",2},{"bone black",0.6},{"red earth",0.3}}
local r = brush{kind="rigger", width=1.5, point=0.6, stiffness=0.6}
r:load(frame, 0.7)
r:stroke({{665.2,470.5},{665,487.5}}, {pressure={0.6,0.6}, ramps={0.05,0.05}, shake=0.2})
r:load(frame, 0.7)
r:stroke({{655.5,479.3},{674.5,479}}, {pressure={0.55,0.55}, ramps={0.05,0.05}, shake=0.2})
-- frame edges
r:load(frame, 0.7)
r:stroke({{655,470},{675.5,470},{675.5,488},{655,488},{655,470}}, {pressure={0.5,0.5}, ramps={0.02,0.02}, shake=0.2})
-- a sill catching snow
local s = brush{kind="flat", width=2, stiffness=0.6}
s:load(rake_snow, 0.5)
s:stroke({{653,489.5},{677,489.3}}, {pressure={0.6,0.5}})

--@ chunk 45

warm_glaze = pile{{"chrome yellow",1},{"vermilion",0.35},{"yellow ochre",0.5},{"lead white",0.2}, medium=0.85}
local spill = poly({{648,503},{682,503},{712,536},{618,536}}):soften(14)
spill = spill:times(function(x, y) return clamp(1 - (y - 503) / 40, 0, 1) end)
work(spill, {hand="glaze", pile=warm_glaze, tool={kind="filbert", width=10, stiffness=0.3}, length={20,50}, angle=0.0, coverage=1.0, pressure={0.15,0.35}, clip=true, fill=true})

--@ chunk 46

local m = poly({{630,502},{700,502},{735,548},{595,548}}):soften(10) - house_m:grow(1)
blend(m, {angle=0.0, tool={kind="badger", width=20}})
blend(m, {angle=1.2, tool={kind="badger", width=20}})
blend(m, {angle=-0.3, tool={kind="badger", width=20}})

--@ chunk 47

local big = poly({{620,503},{712,503},{742,552},{588,552}}):grow(4) - house_m:grow(0.5)
local keep = ellipse(665, 509, 26, 8):soften(6)
local m = (big - keep)
work(m, {hand="body", tool="filbert 7", pile=s_far, angle=0.0, angle_jitter=0.12, coverage=1.8, fill=true, length={20,50},
  edge={found=0.2, soft=0.5, lost=0.3, period=40}})

--@ chunk 48

local m = rect(570, 503, 200, 70):soften(18) - house_m:grow(1)
blend(m, {angle=0.0, tool={kind="badger", width=24}})
blend(m, {angle=1.5, tool={kind="badger", width=24}})

--@ chunk 49

print(wait(30*60))
print(drying(600,530), drying(665,510))
s_mid_l = pile{{"lead white",2.2},{"cobalt blue",0.6},{"smalt",1},{"red earth",0.2},{"raw umber",0.1}, medium=0.06}
local m = (rect(505, 514, 250, 58):roughen(8, 60, 77)):soften(6)
local top_fade = m:times(function(x, y) return smoothstep(512, 528, y) end)
work(top_fade, {hand="body", tool="filbert 9", pile=s_mid_l, angle=0.0, angle_jitter=0.06, coverage=1.8, fill=true, length={40,90},
  edge={found=0.1, soft=0.5, lost=0.4, period=50}})

--@ chunk 50

local m = rect(470, 508, 320, 75):soften(25) - house_m:grow(1) - rect(538, 460, 16, 45)
blend(m, {angle=0.0, tool={kind="badger", width=30}})
blend(m, {angle=0.25, tool={kind="badger", width=30}})
blend(m, {angle=-0.2, tool={kind="badger", width=30}})

--@ chunk 51

post_p = pile{{"raw umber",2},{"bone black",0.5},{"lead white",0.5},{"Prussian blue",0.2},{"red earth",0.2}}
posts = {}
local vx, vy = 603, 475
local d0 = 245
for i = 0, 9 do
  local d = d0 / (1.255 ^ i)
  local y = vy + d + randn(0, 0.6)
  local x = vx - d * 2.073 + randn(0, d * 0.02)
  local h = d * rand(0.25, 0.31)
  local w = math.max(1.3, d * rand(0.024, 0.031))
  local lean = randn(0, 0.06)
  posts[#posts+1] = {x=x, y=y, h=h, w=w, lean=lean}
end
for i, p in ipairs(posts) do
  local tx = p.x + math.sin(p.lean) * p.h
  local ty = p.y - p.h
  local q = poly({{p.x - p.w/2, p.y + p.w*0.3}, {p.x + p.w/2, p.y + p.w*0.3}, {tx + p.w*0.45, ty + p.w*0.2}, {tx, ty - p.w*0.15}, {tx - p.w*0.45, ty + p.w*0.1}})
  local tool = {kind="round", width=math.max(1.2, math.min(p.w * 0.7, 4)), stiffness=0.6}
  work(q, {hand="detail", tool=tool, pile=post_p, angle=-1.5708 + p.lean, coverage=2.4, fill=true, clip=true, length={math.max(3, p.h*0.3), math.max(5, p.h*0.7)}})
end
for i, p in ipairs(posts) do print(i, math.floor(p.x), math.floor(p.y), string.format("%.1f %.1f", p.h, p.w)) end

--@ chunk 52

post_dk = pile{{"raw umber",2},{"bone black",1},{"Prussian blue",0.3},{"lead white",0.25}}
cap = pile{{"lead white",3},{"pale smalt",1.2},{"smalt",0.2}}
base_snow = pile{{"lead white",1.2},{"smalt",2},{"cobalt blue",0.3},{"raw umber",0.15},{"red earth",0.1}}
for i, p in ipairs(posts) do
  local w = p.w * 1.15
  local b = brush{kind="round", width=math.max(1.3, w), point=0.2, stiffness=0.7}
  local tx = p.x + math.sin(p.lean) * p.h
  local ty = p.y - p.h
  b:load(post_dk, 0.9)
  b:stroke({{p.x + randn(0, w*0.1), p.y}, {lerp(p.x, tx, 0.5) + randn(0, w*0.12), lerp(p.y, ty, 0.5)}, {tx, ty + w*0.3}},
    {pressure={0.85, 0.75}, ramps={0.02, 0.08}, shake=1.2})
  if i <= 6 then
    b:load(post_dk, 0.6)
    b:stroke({{tx + randn(0, w*0.15), ty + w*0.5}, {p.x + randn(0, w*0.15), p.y - p.h*0.2}}, {pressure={0.6, 0.5}, shake=1.2})
  end
  -- snow cap
  local c = brush{kind="round", width=math.max(1.2, w * 1.1), point=0.2, stiffness=0.6}
  c:load(cap, 0.7)
  c:stroke({{tx - w*0.5, ty + w*0.25}, {tx + w*0.55, ty + w*0.15}}, {pressure={0.6, 0.4}, shake=0.6})
  -- snow around the base
  local s = brush{kind="filbert", width=math.max(1.5, w * 1.6), stiffness=0.5}
  s:load(base_snow, 0.6)
  s:stroke({{p.x - w*1.6, p.y + w*0.2}, {p.x + w*1.8, p.y + w*0.1}}, {pressure={0.4, 0.2}, shake=0.6})
end

--@ chunk 53

local m = nil
for i, p in ipairs(posts) do
  local w = p.w * 1.15
  local e = ellipse(p.x, p.y + w * 0.4, w * 3.2, w * 1.3)
  m = m and (m + e) or e
end
blend(m:soften(2), {angle=0.0, tool={kind="badger", width=6}})

--@ chunk 54

smoke = pile{{"lead white",2},{"smalt",0.6},{"raw umber",0.35},{"red earth",0.05}, medium=0.5}
local path = {{752,401},{751,388},{746,374},{735,360},{718,348},{696,339},{670,333},{640,330},{610,329}}
local b = brush{kind="filbert", width=5, stiffness=0.3}
for pass = 1, 3 do
  b:reload(smoke, 0.35)
  local pts = {}
  for i, p in ipairs(path) do
    local spread = (i - 1) * 1.2
    pts[i] = {p[1] + randn(0, spread * 0.3), p[2] + randn(0, spread * 0.4)}
  end
  b:stroke(pts, {pressure={0.35, 0.05}, swell={0.6, 1.0, 1.3, 1.1, 0.6}, ramps={0.05, 0.5}, shake=1.0, orient="across"})
end

--@ chunk 55

local path = {{752,403},{751,388},{746,374},{735,360},{718,348},{696,339},{670,333},{640,330},{610,329}}
local m = ribbon(path, {4, 6, 8, 10, 12, 14, 16, 18, 20}):soften(5)
blend(m, {angle=function(x, y) return -2.6 end, tool={kind="badger", width=14}})
blend(m, {angle=-1.2, tool={kind="badger", width=14}})

--@ chunk 56

local b = brush{kind="filbert", width=6, stiffness=0.3}
b:reload(smoke, 0.4)
b:stroke({{752,402},{751,392},{748,381},{743,371},{735,361}}, {pressure={0.45, 0.15}, ramps={0.1, 0.5}, shake=0.8, orient="across"})
blend(ribbon({{752,402},{751,392},{748,381},{743,371},{735,361}}, {5,6,8,9,10}):soften(3), {angle=-1.7, tool={kind="badger", width=10}})
-- chimney base: roof snow drift against it
local s = brush{kind="filbert", width=3.5, stiffness=0.5}
s:load(roof_snow, 0.7)
s:stroke({{744,427},{752,424.5},{761,426.5}}, {pressure={0.7, 0.6}, shake=0.5})

--@ chunk 57

star = pile{{"lead white",4},{"chrome yellow",0.15}}
local b = brush{kind="round", width=2.6, point=0.3, stiffness=0.7}
b:load(star, 0.9)
b:touch(258, 214, {pressure=0.75, twist=0.3})
b:touch(258.3, 214.2, {pressure=0.6})

--@ chunk 58

fg_glaze = pile{{"smalt",1.5},{"raw umber",0.45},{"Prussian blue",0.08},{"red earth",0.1}, medium=0.75}
local vg = mask(function(x, y)
  local t = smoothstep(640, 741, y)
  local c = smoothstep(260, 0, x) * smoothstep(560, 741, y) + smoothstep(760, 1000, x) * smoothstep(580, 741, y)
  return clamp(t * 0.9 + c * 0.6, 0, 1)
end)
local posts_m = nil
for i, p in ipairs(posts) do local q = rect(p.x - p.w, p.y - p.h - 3, p.w * 2, p.h + 6) posts_m = posts_m and (posts_m + q) or q end
work(vg - posts_m:grow(2), {hand="glaze", pile=fg_glaze, angle=-0.03, coverage=1.0, pressure={0.15,0.3}, dips={3, 0.45, 0.6}, clip=true})
blend(vg:grow(10):soften(20) - posts_m:grow(3), {angle=0.0, tool={kind="badger", width=40}})

--@ chunk 59

fp = pile{{"lead white",0.9},{"smalt",2},{"cobalt blue",0.3},{"raw umber",0.3},{"red earth",0.15}}
local path = {{262,748},{335,692},{420,632},{500,580},{568,541},{622,516},{652,507}}
-- walk the path in screen space with steps proportional to depth
local function at(t)
  local n = #path - 1
  local s = t * n
  local i = math.min(n, math.floor(s) + 1)
  local f = s - (i - 1)
  return lerp(path[i][1], path[i+1][1], f), lerp(path[i][2], path[i+1][2], f)
end
local t, side, k = 0.0, 1, 0
local b = brush{kind="round", width=4, point=0.2, stiffness=0.6}
b:load(fp, 0.6)
while t < 0.995 do
  local x, y = at(t)
  local d = y - 475
  local x2, y2 = at(math.min(1, t + 0.01))
  local ang = math.atan(y2 - y, x2 - x)
  local nx, ny = -math.sin(ang), math.cos(ang)
  local off = side * d * 0.016
  local px, py = x + nx * off + randn(0, d * 0.006), y + ny * off * 0.3 + randn(0, d * 0.004)
  local len = math.max(0.6, d * 0.03)
  local p = clamp(b:pressure_for(math.max(0.7, d * 0.014)), 0.05, 1)
  b:stroke({{px - len * 0.5, py}, {px + len * 0.5, py + randn(0, 0.2)}}, {pressure={p, p * 0.8}, ramps={0.2, 0.3}, shake=0.4})
  k = k + 1
  if k % 6 == 0 then b:load(fp, 0.5) end
  side = -side
  -- step: about one pace, shrinking with depth; t advances in screen fraction
  local pace = d * 0.085 + randn(0, d * 0.008)
  local seglen = math.sqrt((x2 - x)^2 + (y2 - y)^2) / 0.01
  t = t + pace / seglen
end
print(k)

--@ chunk 60

fp2 = pile{{"lead white",0.45},{"smalt",2},{"raw umber",0.5},{"red earth",0.2},{"Prussian blue",0.08},{"cobalt blue",0.3}}
local path = {{262,748},{335,692},{420,632},{500,580},{568,541},{622,516},{652,507}}
local function at(t)
  local n = #path - 1
  local s = math.min(t * n, n - 1e-6)
  local i = math.floor(s) + 1
  local f = s - (i - 1)
  return lerp(path[i][1], path[i+1][1], f), lerp(path[i][2], path[i+1][2], f)
end
prints = {}
local t, side = 0.0, 1
while t < 0.99 do
  local x, y = at(t)
  local x2, y2 = at(math.min(1, t + 0.005))
  local d = y - 475
  local ang = math.atan(y2 - y, x2 - x)
  local nx = -math.sin(ang)
  local px = x + side * nx * d * 0.018 + randn(0, d * 0.004)
  local py = y + randn(0, d * 0.003)
  prints[#prints+1] = {px, py, d}
  side = -side
  local pace = d * 0.075 * rand(0.85, 1.15)
  local seg = math.sqrt((x2 - x)^2 + (y2 - y)^2) / 0.005
  t = t + pace / seg
end
local k = 0
for _, p in ipairs(prints) do
  local x, y, d = p[1], p[2], p[3]
  local hgt = math.max(0.9, d * 0.016)
  local wid = math.max(1.4, d * 0.028)
  local b = brush{kind="filbert", width=hgt * 1.1, stiffness=0.6}
  b:load(fp2, 0.7)
  b:stroke({{x - wid * 0.5, y + randn(0, 0.2)}, {x + wid * 0.5, y + randn(0, 0.3)}}, {pressure={0.75, 0.6}, ramps={0.15, 0.25}, shake=0.5, orient="across"})
  k = k + 1
end
print(k)

--@ chunk 61

local pts, ws = {}, {}
for i, p in ipairs(prints) do pts[#pts+1] = {p[1], p[2]}; ws[#ws+1] = math.max(1.5, p[3] * 0.045) end
local m = ribbon(pts, ws):soften(2)
blend(m, {angle=function(x, y) return -0.62 end, tool={kind="badger", width=8}})
-- a few prints restated, irregularly, so the trail does not read as dashes
local b = brush{kind="filbert", width=3, stiffness=0.6}
for i, p in ipairs(prints) do
  if math.random() < 0.45 then
    local x, y, d = p[1], p[2], p[3]
    local hgt = math.max(0.8, d * rand(0.012, 0.02))
    local wid = math.max(1.2, d * rand(0.02, 0.034))
    local bb = brush{kind="filbert", width=hgt, stiffness=0.6}
    bb:load(fp2, rand(0.4, 0.7))
    local ox = randn(0, d * 0.008)
    bb:stroke({{x + ox - wid * 0.5, y + randn(0, 0.3)}, {x + ox + wid * 0.5, y + randn(0, 0.4)}}, {pressure={rand(0.4, 0.8), rand(0.3, 0.6)}, shake=0.7, orient="across"})
  end
end

--@ chunk 62

local rs = rect(789.5, 478, 7, 25) - side_m
local rw = rect(789.5, 466, 7, 12) - side_m - roof_m
local ls = rect(605, 478, 8.5, 25) - gable_m
local lw = rect(605, 468, 8.5, 10) - gable_m - house_m
work(rs + ls, {hand="detail", pile=s_far, angle=-1.5708, coverage=2, fill=true, clip=true, tool={kind="round", width=2}})
work(rw + lw, {hand="detail", pile=woods_dk, angle=-1.5708, coverage=2, fill=true, clip=true, tool={kind="round", width=2}})

--@ chunk 63

local r = (rect(788, 462, 14, 46) - side_m - roof_m) + (rect(598, 464, 16, 44) - gable_m - house_m)
blend(r:soften(1.5), {angle=0.0, tool={kind="badger", width=6}})
blend(r:soften(1.5), {angle=1.5708, tool={kind="badger", width=6}})

--@ chunk 64

snow_fix = pile{{"lead white",2.4},{"pale smalt",2},{"smalt",0.35},{"red earth",0.08},{"yellow ochre",0.06},{"raw umber",0.03}}
local hm = house_m:grow(0.3) + gable_m + side_m + roof_m
local wl = (rect(595, 457, 12, 17) + rect(791, 457, 16, 17)) - hm
local sl = (rect(595, 477.5, 12, 25) + rect(791, 477.5, 16, 25)) - hm
work(wl, {hand="detail", pile=woods_dk, angle=-1.5708, coverage=2.5, fill=true, clip=true, tool={kind="round", width=2.2, stiffness=0.6}})
work(sl, {hand="detail", pile=snow_fix, angle=0.0, coverage=2.5, fill=true, clip=true, tool={kind="round", width=2.2, stiffness=0.6}})
