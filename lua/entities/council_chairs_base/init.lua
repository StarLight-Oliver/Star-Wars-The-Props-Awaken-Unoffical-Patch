

AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

include("shared.lua")

local spawnOffset = Vector(0,0,20)

function ENT:SpawnFunction(pl, tr, className)
	local e = ents.Create(className)

	if not IsValid(e) then return end

	e:SetAngles(Angle(0,pl:GetAimVector():Angle().Yaw,0))
	e:Spawn()
	e:Activate()
	e:SetPos(tr.HitPos + spawnOffset + e:OBBCenter())
	return e
end

function ENT:Initialize()

	self:SetModel(self.Model)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:StartMotionController()
	self:SetUseType(SIMPLE_USE)
	self:SetRenderMode(RENDERMODE_TRANSALPHA)

	local pos, ang = self:LocalToWorld(self.SeatPos), self:LocalToWorldAngles(self.SeatAng)

	self:SecretChair(pos, ang)

	local phys = self:GetPhysicsObject()

	if not IsValid(phys) then return end

	phys:Wake()
	phys:SetMass(100000)
end

local TransparentWhite = Color(255,255,255,0)
function ENT:SecretChair(pos,ang)
	local e = ents.Create("prop_vehicle_prisoner_pod")
	e:SetPos(pos)
	e:SetAngles(ang)
	e:SetParent(self)
	e:SetModel("models/nova/airboat_seat.mdl")
	e:SetRenderMode(RENDERMODE_TRANSALPHA)
	e:SetColor(TransparentWhite)
	e:Spawn()
	e:Activate()
	e:SetNWBool("IsSyphSeat", true)
	e.Ent = self
	self.Chair = e
end


function ENT:Use(p)
	if not IsValid(self.Chair) then return end

	p:EnterVehicle(self.Chair)
end


hook.Add("PlayerLeaveVehicle","SyphSeatExitRewritten", function(ply,vehicle)
	// are these checkss needed ? taken from legacy code
	if not IsValid(ply) then return end
	if not IsValid(vehicle) then return end

	if not vehicle:GetNWBool("IsSyphSeat") then return end

	local ent = vehicle.Ent

	local pos, ang = vehicle:LocalToWorld(ent.ExitPos), vehicle:LocalToWorldAngles(ent.ExitAng)

	ply:SetPos(pos)
	ply:SetEyeAngles(ang)
end)