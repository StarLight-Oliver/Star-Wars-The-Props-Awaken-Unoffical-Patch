if SERVER then AddCSLuaFile() end

ENT.RenderGroup = RENDERGROUP_BOTH
ENT.Base = "council_chairs_base"
ENT.Type = "vehicle"

ENT.PrintName = "Mace Windu Council Chair"
ENT.Author = "Syphadias, Liam0102s Help, StarLight"
ENT.Category = "Star Wars Vehicles: Chairs"
ENT.AutomaticFrameAdvance = true
ENT.Spawnable = true
ENT.AdminSpawnable = false

ENT.Model = "models/starwars/syphadias/jedi_knight_jedi_academy/council_chairs/mace_windu_council_chair.mdl"
ENT.ExitPos = Vector(50, 0, 10)
ENT.ExitAng = Angle(0, 90, 0)
ENT.SeatPos = Vector(4, 0, 10)
ENT.SeatAng = Angle(0, -90, 15)