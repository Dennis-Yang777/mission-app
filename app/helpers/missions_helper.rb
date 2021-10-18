module MissionsHelper	
	def go_to_change_state(mission)
		if mission.state == "pending" 
			link_to "前往執行", run_mission_path(mission), class: "btn btn-xs border", method: 'POST' 
		elsif mission.state == "running" 
			link_to "完成", run_mission_path(mission), class: "btn btn-xs border", method: 'POST' 
		end
	end 

	def priority_state_collection
		Mission.priority_states.keys.zip( Mission.priority_states.values)
	end

	def priority_statement(mission)
		case mission.priority
			when 0
				t('low')
			when 1
				t('medium')
			when 2
				t('high')
		end 
	end
end
