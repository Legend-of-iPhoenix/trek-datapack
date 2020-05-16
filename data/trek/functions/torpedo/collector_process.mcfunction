# Process the hopper minecarts collecting torpedo items
execute if data entity @s Items[{Slot:0b,Count:64b}] at @e[tag=trekTorpedoMarker,sort=nearest,limit=1] unless entity @e[tag=trekTorpedo,distance=..3] run tag @s add trekTmpProceed
# grant a little xp to the person hitting the fireballs
execute if entity @s[tag=trekTmpProceed] as @e[tag=trekTorpedoMarker,sort=nearest,limit=1] run scoreboard players add @p[distance=..10] trekXP 2
execute if entity @s[tag=trekTmpProceed] at @e[tag=trekTorpedoMarker,sort=nearest,limit=1] run summon fireball ~ ~ ~ {Tags:[trek,trekTorpedo,trekTmpTorpedo],life:-10000,direction:[0.0,0.0,0.0],power:[0.0,0.0,0.0],ExplosionPower:8}
scoreboard players operation @e[tag=trekTmpTorpedo] trekID = @s trekID
execute if entity @s[tag=trekTmpProceed] run data modify entity @s Items[{Slot:0b,Count:64b}].Count set value 63b
tag @s remove trekTmpProceed
tag @e remove trekTmpTorpedo
