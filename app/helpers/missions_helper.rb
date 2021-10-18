module MissionsHelper	
	def go_to_change_state(mission)
		if mission.state == "pending" 
			link_to "前往執行", run_mission_path(mission), class: "btn btn-xs border", method: 'POST' 
		elsif mission.state == "running" 
			link_to "完成", run_mission_path(mission), class: "btn btn-xs border", method: 'POST' 
		end
	end 
end
