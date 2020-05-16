# Transport the player (@s) to the current ship's target ship

tag @e[tag=trekShip,distance=..100] add trekTmpCurrent
execute as @e[tag=trekShip] if score @s trekID = @e[tag=trekTmpCurrent,limit=1] trekTargetID run tag @s add trekTmpDestination

# Give wither if either shield is up
execute if entity @e[tag=trekTmpCurrent,tag=!trekShieldDisabled,scores={trekShieldHealth=25..}] run effect give @s minecraft:wither 30 3
execute if entity @e[tag=trekTmpDestination,tag=!trekShieldDisabled,scores={trekShieldHealth=25..}] run effect give @s minecraft:wither 30 3

# Give a little xp if they go over with both shields down
execute if entity @e[tag=trekTmpCurrent,scores={trekShieldHealth=..25}] if entity @e[tag=trekTmpDestination,scores={trekShieldHealth=..25}] run scoreboard players add @s trekXP 5

execute at @e[tag=trekTmpDestination] run tp @s ~ ~3 ~

tag @e remove trekTmpCurrent
tag @e remove trekTmpDestination
