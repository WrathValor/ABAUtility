--| Set Up

local bindable = Instance.new("BindableFunction")

--| Variables

local actualmoney = 0
local rand = 600
local legend = 3000

--| Functions

local function rands()
    local args = {
        [1] = "10rands"
    }

    game:GetService("ReplicatedStorage").BuyStuff:FireServer(unpack(args))
end

local function legen()
    local args = {
        [1] = "legendary"
    }

    game:GetService("ReplicatedStorage").BuyStuff:FireServer(unpack(args))
end

local function notify()
    game.StarterGui:SetCore("SendNotification", {
    	Title = "Insufficent Funds";
    	Text = "You do not have enough cash to buy this. Would you like to buy some?";
    	Duration = 5;
    	Callback = bindable;
    	Button1 = "Yes";
    	Button2 = "No";
    })
end

local function roshi(amount)

	local args = {
		[1] = workspace.FriendlyNPCs.Roshi
	}

	game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatStart:FireServer(unpack(args))


	wait(1)


	local args = {
		[1] = "Yes"
	}

	game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance:FireServer(unpack(args))


	wait(1)


	local args = {
		[1] = amount
	}

	game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance:FireServer(unpack(args))

	wait(1)

	local args = {
		[1] = amount
	}

	game:GetService("Players").LocalPlayer.Backpack.ServerTraits.ChatAdvance:FireServer(unpack(args))

end

function bindable.OnInvoke(response)
	if response == "Yes" then
	    if actualmoney > rand then
	    	roshi("1,000")
	    else
	        roshi("3,000")
	    end
	end
end

local function getMoney()
    local plr = game.Players.LocalPlayer
    local ui = plr.PlayerGui
    local hud = ui.HUD
    local money = hud.Money
    
    actualmoney = tonumber(money.Text:sub(2))
end

--| UI

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("ABA Skins", "GrapeTheme")

local Tab = Window:NewTab("Spins")
local Section = Tab:NewSection("Skins")

local newTab = Window:NewTab("Money")
local newSection = newTab:NewSection("Money")

newSection:NewButton("1,000", "ButtonInfo", function()
  roshi("1,000")
end)

newSection:NewButton("3,000", "ButtonInfo", function()
  roshi("3,000")
end)

newSection:NewButton("10,000", "ButtonInfo", function()
  roshi("10,000")
end)


Section:NewButton("10 Random Spins", "ButtonInfo", function()
    getMoney()
    
    if actualmoney > rand then
        rands()
    else
        notify()
    end
end)

Section:NewButton("Legendary Spin", "ButtonInfo", function()
     if actualmoney > legend then
        legen()
    else
        notify()
    end
end)