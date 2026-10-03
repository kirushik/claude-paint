-- easel session "dream": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box sargent
--@ engine 2

--@ chunk 1

canvas{size=1800, aspect=1.6, linen={18,15}, raw="cotton duck", seed=31}
c = chalk()
c:line({{30,352},{170,338},{310,356},{455,331},{620,345},{790,322},{975,338}}, {pressure={0.3,0.45,0.25}})
c:line({{520,505},{575,445},{650,418},{725,430},{752,478},{722,512},{684,503},{679,474}}, {pressure={0.55,0.4,0.2}})
c:line({{800,92},{772,110},{765,140},{780,166},{806,178}}, {pressure={0.4,0.25}})

--@ chunk 2

seaw = pile{{"cerulean blue",3},{"viridian",1.2},{"ultramarine ash",1}}
local n = noise{seed=4, period=140, octaves=3}
local land = mask(function(x, y)
  local band = smoothstep(370, 420, y) * (1 - smoothstep(560, 625, y))
  return band * smoothstep(0.52, 0.66, n:at01(x, y))
end)
print(pour(land, {pile=seaw, thinner=16, ml=150, tilt={0.15, 0.2}}))

--@ chunk 3

deep = pile{{"ultramarine blue",3},{"cobalt blue",1}}
local curl = ellipse(600, 450, 9, 7) + ellipse(668, 424, 8, 8) + ellipse(728, 470, 7, 9)
print(pour(curl:roughen(3, 12, 5), {pile=deep, thinner=7, ml=55}))
local gaps = ellipse(150, 445, 7, 7) + ellipse(450, 470, 8, 6) + ellipse(870, 455, 6, 6)
print(pour(gaps:roughen(3, 12, 6), {pile=seaw, thinner=12, ml=60}))

--@ chunk 4

local crest = ribbon({{560,432},{610,410},{660,402},{708,414},{738,446}}, {5, 9, 11, 9, 5}):roughen(4, 14, 8)
print(blot(crest:soften(3), {strength=0.95}))
print(blot(ellipse(470, 395, 30, 6):roughen(5, 20, 9):soften(4), {strength=0.8}))

--@ chunk 5

print(wait(100))
print(soaked(650, 470), "|", soaked(150, 430))

--@ chunk 6

dawn = pile{{"rose madder",2},{"cobalt violet",1.2},{"ultramarine ash",0.6}}
print(pour(ellipse(170, 110, 8, 7):roughen(3, 12, 11), {pile=dawn, thinner=12, ml=40}))
print(pour(ellipse(430, 80, 9, 7):roughen(3, 12, 12), {pile=dawn, thinner=14, ml=45}))
print(pour(ellipse(610, 215, 7, 7):roughen(3, 12, 13), {pile=dawn, thinner=10, ml=30}))
print(pour(ellipse(960, 240, 8, 7):roughen(3, 12, 14), {pile=dawn, thinner=14, ml=35, tilt={math.pi, 0.3}}))

--@ chunk 7

glow = pile{{"Indian yellow",3},{"cadmium yellow",0.5}}
local path = ribbon({{60,272},{200,262},{340,280},{470,258}}, {3, 5, 4, 3}):roughen(2, 10, 21)
print(pour(path, {pile=glow, thinner=10, ml=35}))
ash = pile{{"ultramarine ash",2},{"cobalt violet",1},{"rose madder",0.5}}
local trail = ribbon({{20,30},{230,40},{360,20},{520,60},{700,40},{900,60},{990,30}}, {4, 3, 5, 3, 4, 3, 4}):roughen(2, 10, 22)
print(pour(trail, {pile=ash, thinner=16, ml=55}))

--@ chunk 8
print(wait(3*24*60))

--@ chunk 9

night = pile{{"ultramarine ash",3},{"viridian",0.6},{"bone brown",0.4},{"cobalt violet",0.6}}
local dots = nil
local path = {{120,60},{260,150},{400,170},{520,120},{640,90},{720,200},{860,170},{930,330},{880,470},{960,560}}
for i, p in ipairs(path) do
  local d = ellipse(p[1] + randn(0, 6), p[2] + randn(0, 6), rand(4, 7), rand(4, 7))
  dots = dots and (dots + d) or d
end
print(pour(dots:roughen(2, 10, 31), {pile=night, thinner=18, ml=280, tilt={0.9, 0.15}}))

--@ chunk 10

local moon = (ellipse(800, 135, 38, 40) - ellipse(818, 128, 34, 38)):roughen(2, 10, 41):soften(2)
print(blot(moon, {strength=1.0}))
print(blot(moon, {strength=1.0}))
print(soaked(775, 135))

--@ chunk 11

print(wait(120))
deep2 = pile{{"ultramarine blue",2},{"viridian",1},{"bone brown",0.3}}
print(pour(ellipse(210, 520, 6, 5):roughen(2, 10, 51) + ellipse(120, 560, 5, 5), {pile=deep2, thinner=4, ml=30}))
ember = pile{{"rose madder",2},{"Mars orange",1}}
print(pour(ellipse(300, 248, 5, 4):roughen(2, 10, 52), {pile=ember, thinner=9, ml=10}))

--@ chunk 12
print(wait(7*24*60))
