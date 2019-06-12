---Coded by Jeremiah#0420
RegisterCommand("k", function(source,args,rawCommand)
    HandsupKneel()
end, false)

function playAnim(animDict, animName, duration)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do Citizen.Wait(0) end
    TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
    RemoveAnimDict(animDict)
end

function DisplayNotification( text )
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
    DrawNotification( false, false )
end

---HandsupKneel Code
function HandsupKneel()
    ped = PlayerPedId()
    if IsPedInAnyVehicle(ped, true) then
        DisplayNotification("Please leave the vehicle first next time.")
        ClearPedTasksImmediately(ped)
    end
    if DoesEntityExist(ped) then
        Citizen.CreateThread(function()
            playAnim("random@arrests@busted")
            if IsEntityPlayingAnim(ped, "random@arrests@busted", "idle_a", 3)then
                ClearPedTasksImmediately(ped)
                ResetPedMovementClipset(ped, 0.0)
			elseif not IsEntityPlayingAnim(ped, "random@arrests@busted", "idle_a", 3) then
                TaskPlayAnim(ped, "random@arrests@busted", "idle_a", 8.0, -8, -1, 49, 0, 0, 0, 0)
                TaskPlayAnim(ped, "random@arrests", "idle_2_hands_up", 8.0, 1.0, -1, 2, 0, 0, 0, 0)
                RequestAnimSet( "move_ped_crouched" )
                HasAnimSetLoaded("move_ped_crouched")
                SetPedMovementClipset(ped, "move_ped_crouched", 0.25 )
			end
		end)
	end
end
