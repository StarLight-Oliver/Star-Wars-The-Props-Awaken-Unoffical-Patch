include("shared.lua")

function ENT:Draw()
	self:DrawModel()
end

local View = {}
hook.Add("CalcView", "SyphSeatView", function()

	local p = LocalPlayer();
	local Seat = p:GetVehicle()

	if not IsValid(Seat) then return end
	if not Seat:GetNWBool("IsSyphSeat") then return end
	if not Seat:GetThirdPersonMode() then return end

	local seatPos = Seat:GetPos()
	local camPos = seatPos + Seat:GetUp() * 175 + LocalPlayer():GetAimVector():GetNormal() * -100
	local camAng = ((seatPos + Vector(0,0,100)) - camPos):Angle()

	View.origin = camPos
	View.angles = camAng

	return View
end)

hook.Add( "ShouldDrawLocalPlayer", "SyphSeatPlayerDraw", function( p )
	local Seat = p:GetVehicle()

	if not IsValid(Seat) then return end
	if not Seat:GetNWBool("IsSyphSeat") then return end
	if not Seat:GetThirdPersonMode() then return end

	return true
end)

