# create temporary objectives to do some math...

# additional skill points earned this match
scoreboard objectives add trekAddtlPts dummy
# XP required to earn the next point
scoreboard objectives add trekNextPt dummy

scoreboard players operation @a[distance=..500] trekAddtlPts = * trekXP

# set the amount of XP required to gain a skill point into a dummy user
scoreboard players set #trekBaseXP trekXP 100
scoreboard players set #trekXPIncrease trekXP 25

# formula: next skill point cost = #trekBaseXP + #trekXPIncrease * trekSkillPtBal
scoreboard players operation @a[distance=..500] trekNextPt = @a[distance=..500] trekSkillPtBal
scoreboard players operation @a[distance=..500] trekNextPt *= #trekXPIncrease trekXP
scoreboard players operation @a[distance=..500] trekNextPt += #trekBaseXP trekXP

scoreboard players operation @a[distance=..500] trekAddtlPts /= @a[distance=..500] trekNextPt
scoreboard players operation @a[distance=..500] trekXP %= @a[distance=..500] trekNextPt

scoreboard players operation @a[distance=..500] trekSkillPtBal += @a[distance=..500] trekAddtlPts
scoreboard players operation @a[distance=..500] trekSkillPtTot += @a[distance=..500] trekAddtlPts

scoreboard players enable @a[distance=..500] trekShop
# tell people how many skill points they earned
tellraw @a[distance=..500] ["",{"text":"You gained ","color":"gold"},{"score":{"name":"@p","objective":"trekAddtlPts"},"bold":true,"color":"white"},{"text":" skill points.","color":"gold"}]
# tell people their xp status + offer to show them the shop menu
tellraw @a[distance=..500] ["",{"text":"You have a total of ","color":"gold"},{"score":{"name":"@p","objective":"trekSkillPtBal"},"bold":true,"color":"white"},{"text":" skill points, and have ","color":"gold"},{"score":{"name":"@p","objective":"trekXP"},"bold":true,"color":"white"},{"text":" out of the ","color":"gold"},{"score":{"name":"@p","objective":"trekNextPt"},"bold":true,"color":"white"},{"text":" XP for the next skill point.","color":"gold"},{"text":"\n"},{"text":"Would you like to spend your skill points?","color":"white"},{"text":" (","bold":true,"color":"white"},{"text":"Yes","bold":true,"color":"green","clickEvent":{"action":"run_command","value":"/trigger trekShop set 1"},"hoverEvent":{"action":"show_text","value":["",{"text":"Click to show the shop.","color":"white"}]}},{"text":"/","bold":true,"color":"white"},{"text":"No","bold":true,"color":"red","clickEvent":{"action":"run_command","value":"/trigger trekShop set 0"},"hoverEvent":{"action":"show_text","value":["",{"text":"Click if you do not want to visit the shop.","color":"white"}]}},{"text":")","bold":true,"color":"white"}]