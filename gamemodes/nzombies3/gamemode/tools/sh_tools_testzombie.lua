nz.Tools.Functions.CreateTool("testzombie", {
	displayname = "Spawn Test Zombie",
	desc = "LMB: Create a test zombie, RMB: Remove test zombie",
	condition = function(wep, ply)
		return true
	end,

	PrimaryAttack = function(wep, ply, tr, data)
		data = data or {speed = 51}
		local z = ents.Create("nz_zombie_walker")
		z:SetPos(tr.HitPos)
		z:SetHealth(100)
		z.SpecialInit = function(self)
			self:SetRunSpeed(data.speed)
		end
		z:Spawn()
		z:SetRunSpeed(data.speed)

		undo.Create( "Test Zombie" )
			undo.SetPlayer( ply )
			undo.AddEntity( z )
		undo.Finish( "Effect (" .. tostring( model ) .. ")" )
	end,

	SecondaryAttack = function(wep, ply, tr, data)
		if IsValid(tr.Entity) and tr.Entity:GetClass() == "nz_zombie_walker" then
			tr.Entity:Remove()
		end
	end,
	Reload = function(wep, ply, tr, data)
		//Nothing
	end,
	OnEquip = function(wep, ply, data)

	end,
	OnHolster = function(wep, ply, data)

	end
}, {
	displayname = "Spawn Test Zombie",
	desc = "LMB: Create a test zombie, RMB: Remove test zombie",
	icon = "icon16/user_green.png",
	weight = 400,
	condition = function(wep, ply)
		return nz.Tools.Advanced
	end,
	interface = function(frame, data)
	
		local pnl = vgui.Create("DPanel", frame)
		pnl:Dock(FILL)
		
		local txt = vgui.Create("DLabel", pnl)
		txt:SetText("Zombie Speed")
		txt:SizeToContents()
		txt:SetTextColor(Color(0,0,0))
		txt:SetPos(120, 30)
	
		local slider = vgui.Create("DNumberScratch", pnl)
		slider:SetSize(100, 20)
		slider:SetPos(130, 50)
		slider:SetMin(0)
		slider:SetMax(300)
		slider:SetValue(data.speed)
		
		local num = vgui.Create("DNumberWang", pnl)
		num:SetValue(data.speed)
		num:SetMinMax(0, 300)
		num:SetPos(90, 50)
		
		local function UpdateData()
			nz.Tools.Functions.SendData( data, "testzombie" )
		end
		
		slider.OnValueChanged = function(self, val)
			data.speed = val
			num:SetValue(val)
			UpdateData()
		end
		num.OnValueChanged = function(self, val)
			data.speed = val
			slider:SetValue(val)
			UpdateData()
		end
		
		return pnl
	end,
	defaultdata = {
		speed = 51,
	}
})