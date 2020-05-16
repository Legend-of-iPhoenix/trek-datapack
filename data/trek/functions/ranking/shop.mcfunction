# Begin generated shop commands.
execute as @a[scores={trekShop=1..}] run scoreboard players enable @s trekShop
tellraw @a[scores={trekShop=1}] ["",{"text":"Trek PVP Skill Shop","bold":true,"color":"gold","hoverEvent":{"action":"show_text","value":["",{"text":"Here, you can spend skill points to upgrade your skills. Spend wisely!","color":"white"}]}}]
# Skill: Heal

tellraw @a[scores={trekShop=1}] ["",{"text":"Score: ","color":"gold"},{"text":"Heal ","bold":true,"color":"white","hoverEvent":{"action":"show_text","value":["",{"text":"Heal your teammates by one half-heart, infrequently. A higher level means you will heal them more often.","color":"white"}]}},{"text":"(hover for a description)","color":"white"}]
tellraw @a[scores={trekShop=1,trekSklHeal=0}] ["",{"text":"Level: ","color":"gold"},{"text":"[     ] ","bold":true,"color":"white","hoverEvent":{"action":"show_text","value":["",{"text":"(0/5)","color":"white"}]}},{"text":"+","bold":true,"color":"green","clickEvent":{"action":"run_command","value":"/trigger trekShop set 100"},"hoverEvent":{"action":"show_text","value":["",{"text":"Click to purchase.","color":"white"}]}}]
tellraw @a[scores={trekShop=1,trekSklHeal=1}] ["",{"text":"Level: ","color":"gold"},{"text":"[=    ] ","bold":true,"color":"white","hoverEvent":{"action":"show_text","value":["",{"text":"(1/5)","color":"white"}]}},{"text":"+","bold":true,"color":"green","clickEvent":{"action":"run_command","value":"/trigger trekShop set 100"},"hoverEvent":{"action":"show_text","value":["",{"text":"Click to purchase.","color":"white"}]}}]
tellraw @a[scores={trekShop=1,trekSklHeal=2}] ["",{"text":"Level: ","color":"gold"},{"text":"[==   ] ","bold":true,"color":"white","hoverEvent":{"action":"show_text","value":["",{"text":"(2/5)","color":"white"}]}},{"text":"+","bold":true,"color":"green","clickEvent":{"action":"run_command","value":"/trigger trekShop set 100"},"hoverEvent":{"action":"show_text","value":["",{"text":"Click to purchase.","color":"white"}]}}]
tellraw @a[scores={trekShop=1,trekSklHeal=3}] ["",{"text":"Level: ","color":"gold"},{"text":"[===  ] ","bold":true,"color":"white","hoverEvent":{"action":"show_text","value":["",{"text":"(3/5)","color":"white"}]}},{"text":"+","bold":true,"color":"green","clickEvent":{"action":"run_command","value":"/trigger trekShop set 100"},"hoverEvent":{"action":"show_text","value":["",{"text":"Click to purchase.","color":"white"}]}}]
tellraw @a[scores={trekShop=1,trekSklHeal=4}] ["",{"text":"Level: ","color":"gold"},{"text":"[==== ] ","bold":true,"color":"white","hoverEvent":{"action":"show_text","value":["",{"text":"(4/5)","color":"white"}]}},{"text":"+","bold":true,"color":"green","clickEvent":{"action":"run_command","value":"/trigger trekShop set 100"},"hoverEvent":{"action":"show_text","value":["",{"text":"Click to purchase.","color":"white"}]}}]
tellraw @a[scores={trekShop=1,trekSklHeal=5}] ["",{"text":"Level: ","color":"gold"},{"text":"[ MAX ]","bold":true,"color":"white","hoverEvent":{"action":"show_text","value":["",{"text":"This skill is at its highest level.","color":"white"}]}}]
tellraw @a[scores={trekShop=100,trekSklHeal=5..}]  ["",{"text":"You have already maxed out the skill ","color":"gold"},{"text":"%SCORENAME% ","bold":true,"color":"white"}]
tellraw @a[scores={trekShop=100,trekSkillPtBal=..0}]  ["",{"text":"Error: Insufficient funds!","color":"gold"}]
execute as @a[scores={trekShop=100,trekSklHeal=..4,trekSkillPtBal=1..}] run tag @s add trekShopBuy100
scoreboard players add @a[tag=trekShopBuy100] trekSklHeal 1
scoreboard players remove @a[tag=trekShopBuy100] trekSkillPtBal 1
tag @a remove trekShopBuy100
execute as @a[scores={trekShop=100..}] run tag @s add trekShopper
execute as @a[tag=trekShopper] run scoreboard players set @s trekShop 1
execute as @a[tag=!trekShopper] run scoreboard players set @s trekShop 0
tag @a remove trekShopper
# End generated shop commands.