local futsalid = 6451757943 
local placeid = game.PlaceId
local workspace = game:GetService("Workspace")
local players = game:GetService("Players")
local runservice = game:GetService("RunService")
local player = players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidroot = character:WaitForChild("HumanoidRootPart")

getgenv().stud = getgenv().stud or 5

local toplar = {}
local sonyenileme = 0
local limbs = {"Torso", "Right Arm", "Left Arm", "Right Leg", "Left Leg"}

local topisimleri = {
	TPS = true, ESA = true, MRS = true, PRS = true, MPS = true
}


if placeid == futsalid then
	local SPS = game:GetService("StarterPlayer").StarterPlayerScripts
	local PS = player:WaitForChild("PlayerScripts")

	local m1 = require(SPS:FindFirstChild("TSFL Client").Modules:FindFirstChild("BallNetworking"))
	local m2 = require(PS:FindFirstChild("TSFL Client").Modules:FindFirstChild("BallNetworking"))

	local af = function() return false end
	local at = function() return true end

	hookfunction(m1.IsDistanceTooBig, af)
	hookfunction(m2.IsDistanceTooBig, af)

	hookfunction(m1.VerifyHit, af)
	hookfunction(m2.VerifyHit, af)

	hookfunction(m1.IsBallBoundingHitbox, at)
	hookfunction(m2.IsBallBoundingHitbox, at)
end


local function guncelle(degisken)
	if not degisken and os.time() - sonyenileme < 2 then return end
	sonyenileme = os.time()

	table.clear(toplar)
	for _, v in ipairs(workspace:GetDescendants()) do
		if topisimleri[v.Name] then
			table.insert(toplar, v)
		end
	end
end

guncelle(true)

local function reach()
	for _, uzuv in ipairs(limbs) do
		local limb = character:FindFirstChild(uzuv)
		if limb then
			for _, v in ipairs(limb:GetDescendants()) do
				if v:IsA("TouchTransmitter") or v.Name == "TouchInterest" then
					for _, top in ipairs(toplar) do
						if (top.Position - limb.Position).Magnitude < getgenv().stud then
							firetouchinterest(top, v.Parent, 0)
							firetouchinterest(top, v.Parent, 1)
							break
						end
					end
				end
			end
		end
	end
end

runservice.RenderStepped:Connect(function()
	guncelle(false)
	reach()
end)