const skills = [
  {
    "name": "Heal",
    "scoreName": "trekSklHeal",
    "description": "Heal your teammates by one half-heart, infrequently. A higher level means you will heal them more often."
  }
];


// maximum skill level allowed
const maxLevel = 5;
const SkillNameMsgTemplate = '# Skill: %SKILLNAME%\n\ntellraw @a[scores={trekShop=1}] ["",{"text":"Score: ","color":"gold"},{"text":"%SKILLNAME% ","bold":true,"color":"white","hoverEvent":{"action":"show_text","value":["",{"text":"%SKILLDESC%","color":"white"}]}},{"text":"(hover for a description)","color":"white"}]';
const SkillPurchaseMsgTemplate = 'tellraw @a[scores={trekShop=1,%SKILLSCORE%=%LEVEL%}] ["",{"text":"Level: ","color":"gold"},{"text":"[%BARS%] ","bold":true,"color":"white","hoverEvent":{"action":"show_text","value":["",{"text":"(%LEVEL%/%MAXLEVEL%)","color":"white"}]}},{"text":"+","bold":true,"color":"green","clickEvent":{"action":"run_command","value":"/trigger trekShop set %SKILLIDX%"},"hoverEvent":{"action":"show_text","value":["",{"text":"Click to purchase.","color":"white"}]}}]';
const SkillMaxedMsgTemplate = 'tellraw @a[scores={trekShop=1,%SKILLSCORE%=%MAXLEVEL%}] ["",{"text":"Level: ","color":"gold"},{"text":"[%BARS%]","bold":true,"color":"white","hoverEvent":{"action":"show_text","value":["",{"text":"This skill is at its highest level.","color":"white"}]}}]';
const SkillPurchaseTriggerTemplate = 'tellraw @a[scores={trekShop=%SKILLIDX%,%SKILLSCORE%=%MAXLEVEL%..}]  ["",{"text":"You have already maxed out the skill ","color":"gold"},{"text":"%SCORENAME% ","bold":true,"color":"white"}]\ntellraw @a[scores={trekShop=%SKILLIDX%,trekSkillPtBal=..0}]  ["",{"text":"Error: Insufficient funds!","color":"gold"}]\nexecute as @a[scores={trekShop=%SKILLIDX%,%SKILLSCORE%=..%BELOWMAXLEVEL%,trekSkillPtBal=1..}] run tag @s add trekShopBuy%SKILLIDX%\nscoreboard players add @a[tag=trekShopBuy%SKILLIDX%] %SKILLSCORE% 1\nscoreboard players remove @a[tag=trekShopBuy%SKILLIDX%] trekSkillPtBal 1\ntag @a remove trekShopBuy%SKILLIDX%'
let output = [];

function applyTemplate(template, fillIn) {
	let result = template.slice();
	const keys = Object.keys(fillIn);
	const regexes = keys.map(fillIn => new RegExp('%' + fillIn.toUpperCase() + '%', 'g'));
	for (let idx = 0; idx < keys.length; ++idx) {
		result = result.replace(regexes[idx], fillIn[keys[idx]]);
	}

	return result;
}

output.push("# Begin generated shop commands.");
output.push("execute as @a[scores={trekShop=1..}] run scoreboard players enable @s trekShop");
output.push('tellraw @a[scores={trekShop=1}] ["",{"text":"Trek PVP Skill Shop","bold":true,"color":"gold","hoverEvent":{"action":"show_text","value":["",{"text":"Here, you can spend skill points to upgrade your skills. Spend wisely!","color":"white"}]}}]');
for (let idx = 0; idx < skills.length; ++idx) {
	const skill = skills[idx];
	output.push(applyTemplate(SkillNameMsgTemplate, {
		"skillname": skill.name,
		"skilldesc": skill.description
	}));
	for (let level = 0; level < maxLevel; ++level) {
		output.push(applyTemplate(SkillPurchaseMsgTemplate, {
			"skillscore": skill.scoreName,
			"bars": "=".repeat(level).padEnd(maxLevel, ' '),
			"level": level,
			"maxlevel": maxLevel,
			"skillidx": 100 + idx
		}));
	}

	output.push(applyTemplate(SkillMaxedMsgTemplate, {
		"skillscore": skill.scoreName,
		"maxlevel": maxLevel,
		"bars": " MAX "
	}));

	output.push(applyTemplate(SkillPurchaseTriggerTemplate, {
		"skillname": skill.name,
		"skillscore": skill.scoreName,
		"maxlevel": maxLevel,
		"belowmaxlevel": maxLevel - 1,
		"skillidx": 100 + idx
	}));
}

output.push("execute as @a[scores={trekShop=100..}] run tag @s add trekShopper");
output.push("execute as @a[tag=trekShopper] run scoreboard players set @s trekShop 1");
output.push("execute as @a[tag=!trekShopper] run scoreboard players set @s trekShop 0");
output.push("tag @a remove trekShopper");
output.push("# End generated shop commands.");
output.join('\n')