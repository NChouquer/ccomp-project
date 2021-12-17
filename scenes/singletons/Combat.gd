extends Node


func getSkillDamage(skill):
	return DataImport.skill_data[skill].phys_damage
