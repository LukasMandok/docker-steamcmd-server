-----------------------------------------------------------------
-- @package     LuneraLITE
-- @author      Richard
-- @build       v1.4.0
-- @release     11.22.2015
-----------------------------------------------------------------

Lunera = Lunera or {}
Lunera.Settings = Lunera.Settings or {}

surface.CreateFont( "LuneraFontCloseGUI", 
{
	size = 14,
	weight = 700,
	antialias = true,
	shadow = false,
	font = "Marlett"
})

surface.CreateFont( "LuneraFontNetworkName", 
{
	size = 35,
	weight = 100,
	antialias = true,
	shadow = false,
	font = "Oswald Light"
})

surface.CreateFont( "LuneraFontClock", 
{
	size = 28,
	weight = 100,
	antialias = true,
	shadow = false,
	font = "Teko Light"
})

surface.CreateFont( "LuneraFontMenuItem", 
{
	size = 25,
	weight = 400,
	antialias = true,
	shadow = false,
	font = "Oswald Light"
})

surface.CreateFont( "LuneraFontBrowserTitle", 
{
	size = 34,
	weight = 100,
	antialias = true,
	shadow = false,
	font = "Teko Light"
})

surface.CreateFont( "LuneraFontStandardText", 
{
	size = 16,
	weight = 400,
	antialias = true,
	shadow = false,
	font = "Marlett"
})

surface.CreateFont( "LuneraFontPlayername", 
{
	size = 44,
	weight = 200,
	antialias = true,
	shadow = false,
	font = "Teko Light"
})

surface.CreateFont( "LuneraFontSteamID", 
{
	size = 28,
	weight = 100,
	antialias = true,
	shadow = false,
	font = "Teko Light"
})

surface.CreateFont( "LuneraHostname", 
{
	size = 28,
	weight = 100,
	antialias = true,
	shadow = false,
	font = "Oswald Light"
})

local LuneraBtnClose = "lunera/lunera_btn_close.png"

-----------------------------------------------------------------
--  Custom Functions
-----------------------------------------------------------------

function draw.LuneraBox( x, y, w, h, color )
	surface.SetDrawColor( color )
	surface.DrawRect( x, y, w, h )
end

local blur = Material("pp/blurscreen")
function DrawBlurPanel( panel, amount, heavyness )
	local x, y = panel:LocalToScreen(0, 0)
	local scrW, scrH = ScrW(), ScrH()

	surface.SetDrawColor( 255, 255, 255 )
	surface.SetMaterial( blur )

	for i = 1, ( heavyness or 3 ) do
		blur:SetFloat( "$blur", ( i / 3 ) * ( amount or 6 ) )
		blur:Recompute()

		render.UpdateScreenEffectTexture()
		surface.DrawTexturedRect( x * -1, y * -1, scrW, scrH )
	end
end

-----------------------------------------------------------------
--  Lunera:guiMenu
-----------------------------------------------------------------

function Lunera:guiMenu()

	if IsValid( LuneraPanelMenu ) then
		if LuneraPanelMenu:IsVisible() then
			LuneraPanelMenu:Remove()
			gui.EnableScreenClicker(false)

			return
		else
			LuneraPanelMenu:SetVisible(true)
			gui.EnableScreenClicker(true)
			return
		end
	end

	LuneraPanelMenu = vgui.Create( "DPanel" )
	LuneraPanelMenu:SetSize( ScrW(), ScrH() )

	gui.EnableScreenClicker( true )

	LuneraPanelMenu.Paint = function( self, w, h )
		DrawBlurPanel( self )
		draw.LuneraBox( 0, 0, w, h, Color( 0, 0, 0, 150 ) )
	end

	local dhtmlBackground = LuneraPanelMenu
	if Lunera.Settings.BackgroundsEnable and Lunera.Settings.Backgrounds then
		dhtmlBackground = vgui.Create( "DHTML", LuneraPanelMenu )
		dhtmlBackground:SetSize( ScrW(), ScrH() )
		dhtmlBackground:SetScrollbars( false )
		dhtmlBackground:SetHTML(
		[[
			<body style="overflow: hidden; height: 100%; width: 100%;">
	 			<img src="]] .. table.Random( Lunera.Settings.Backgrounds ) .. [[" style="position: absolute; height: auto; width: auto; top: -50%; left: -50%; bottom: -50%; right: -50%; margin: auto;">
	 		</body>
		]])
		dhtmlBackground.Paint = function( self, w, h )
			DrawBlurPanel( self )
		end
	end

	local panelBarTop = vgui.Create( "DPanel", dhtmlBackground )
	panelBarTop:SetSize( ScrW(), 60 )
	panelBarTop:SetPos( 0, 0 )
	panelBarTop:Dock( TOP )
	panelBarTop.Paint = function(self, w, h)
		DrawBlurPanel( self )
		draw.LuneraBox( 0, 0, w, h, Color( 0, 0, 0, 200 ) )
		draw.SimpleText( Lunera.Settings.NetworkName, "LuneraFontNetworkName", self:GetWide() - 70, self:GetTall() / 2 , Lunera.Settings.NetworkNameColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
	end

	local buttonClose = vgui.Create( "DButton", panelBarTop )
	buttonClose:SetText( "" )
	buttonClose:Dock(RIGHT)
	buttonClose.Paint = function( self, w, h )
		local color = Lunera.Settings.MenuButtonColor
		local txtColor = Lunera.Settings.MenuButtonTextColor
		if self:IsHovered() or self:IsDown() then
			color = Lunera.Settings.MenuButtonHoverColor
			txtColor = Lunera.Settings.MenuButtonHoverTextColor
		end
		surface.SetDrawColor( Lunera.Settings.MenuButtonHoverColor )
		surface.SetMaterial( Material( LuneraBtnClose ) )
		surface.DrawTexturedRect( 16, 15, 32, 32 ) 
	end
	buttonClose.DoClick = function()
		LuneraPanelMenu:Remove()
		gui.EnableScreenClicker(false)
	end

	local buttonCount = 0
	for k, v in pairs( Lunera.Settings.Buttons ) do

		if v.enabled then

			local buttonCustom = vgui.Create( "DButton", panelBarTop )
			buttonCustom:SetText( "" )

			surface.SetFont( "LuneraFontMenuItem" )
			local sizex, sizey = surface.GetTextSize( string.upper( v.name ) )

			buttonCustom:SetSize( sizex + 20, 60 )
			buttonCustom:Dock( LEFT )

			local mat = false
			if v.icon and Lunera.Settings.UseButtonIconsWithText then
				mat = Material( v.icon )
				buttonCustom:SetSize( buttonCustom:GetWide() + 32, buttonCustom:GetTall() )
			elseif v.icon and Lunera.Settings.UseButtonIconsOnly then
				mat = Material( v.icon )
				buttonCustom:SetSize( 64, buttonCustom:GetTall() )
			end

			buttonCustom.Paint = function( self, w, h )

				local color = Lunera.Settings.MenuButtonColor
				local txtColor = Lunera.Settings.MenuButtonTextColor
				if self:IsHovered() or self:IsDown() then 
					color = Lunera.Settings.MenuButtonHoverColor
					txtColor = Lunera.Settings.MenuButtonHoverTextColor
				end
				
				surface.SetDrawColor( color )
				surface.DrawRect( 0, 0, w, h )

				if Lunera.Settings.UseButtonIconsWithText and mat then
					
					surface.SetDrawColor( txtColor )
					surface.SetMaterial( mat )
					surface.DrawTexturedRect( 5, 14, 32, 32 )

					draw.SimpleText( string.upper( v.name ), "LuneraFontMenuItem", self:GetWide() / 2 + 16, self:GetTall() / 2, txtColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

				elseif Lunera.Settings.UseButtonIconsOnly and mat then
					
					surface.SetDrawColor( txtColor )
					surface.SetMaterial( mat )
					surface.DrawTexturedRect( 17, 14, 32, 32 )

				else

					draw.SimpleText( string.upper( v.name ), "LuneraFontMenuItem", self:GetWide() / 2, self:GetTall() / 2, txtColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

				end
			end
			buttonCustom.DoClick = v.func

			buttonCount = buttonCount + 1

		end

	end

	if Lunera.Settings.ClockEnabled then

		local panelBarTopSec = vgui.Create( "DPanel", dhtmlBackground )
		panelBarTopSec:SetSize( ScrW(), 30 )
		panelBarTopSec:Dock( TOP )
		panelBarTopSec.Paint = function(self, w, h)
			DrawBlurPanel( self )
			draw.LuneraBox( 0, 0, w, h, Color( 0, 0, 0, 200 ) )
			draw.LuneraBox( 0, 0, w, 2, Lunera.Settings.BottomBarColor )
			draw.SimpleText( os.date( Lunera.Settings.ClockSyntax ), "LuneraFontClock", 20, 3, Lunera.Settings.ClockTextColor, 0, 0 )	
		end

	end

	if Lunera.Settings.HTMLLoader then

		local htmlLoader = vgui.Create( "DFrame", dhtmlBackground )
		htmlLoader:Dock( FILL )
		htmlLoader:DockMargin( 5, 5, 5, 5 )
		htmlLoader:MakePopup( )
		htmlLoader:SetTitle( "" )
		htmlLoader:ShowCloseButton(false)
		htmlLoader:SetDraggable( false ) 
		htmlLoader:SetPaintShadow( true )
		htmlLoader.Paint = function( self, w, h )
			DrawBlurPanel( self )
		end

		local dhtmlWindow = vgui.Create( "HTML", htmlLoader )
		dhtmlWindow:SetSize( ScrW() - 200, 300 )
		dhtmlWindow:DockMargin( 20, 0, 20, 25 )
		dhtmlWindow:Dock( FILL )

		if Lunera.Settings.HTMLShowNavBar then

			local dhtmlControlsBar = vgui.Create( "DHTMLControls", htmlLoader )
			dhtmlControlsBar:Dock( TOP )
			dhtmlControlsBar:DockMargin( 20, 0, 20, 0 )
			dhtmlControlsBar:SetWide( ScrW() - 200 )
			dhtmlControlsBar:SetPos( 0, 0 )
			dhtmlControlsBar:SetHTML( dhtmlWindow )
			dhtmlControlsBar.AddressBar:SetText( Lunera.Settings.HTMLurl )

			dhtmlWindow:MoveBelow( dhtmlControlsBar )

		end

		dhtmlWindow:OpenURL( Lunera.Settings.HTMLurl )

	end

	local panelBarBottom = vgui.Create( "DPanel", dhtmlBackground )
	panelBarBottom:Dock( BOTTOM )
	panelBarBottom:SetTall( 60 )
	panelBarBottom.Paint = function( self, w, h )
		draw.LuneraBox( 0, 0, w, h, Color( 0, 0, 0, 245 ) )
		draw.SimpleText( GetHostName(), "LuneraHostname", w - 20, h / 2 , Lunera.Settings.ButtonText, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
	end

	local avaterPlayer = vgui.Create( "AvatarImage", panelBarBottom )
	avaterPlayer:SetSize( 46, 46 )
	avaterPlayer:SetPos( 20, 7 )
	avaterPlayer:SetPlayer( LocalPlayer(), 46 )

	local txtPlayerName = vgui.Create( "DTextEntry", panelBarBottom )
	txtPlayerName:SetPos( 70, 0 )
	txtPlayerName:SetMultiline( true )
	txtPlayerName:SetDrawBackground( false )
	txtPlayerName:SetEnabled( true )
	txtPlayerName:SetSize( 350, 300 ) 
	txtPlayerName:SetVerticalScrollbarEnabled( false )
	txtPlayerName:SetFont( "LuneraFontPlayername" )
	txtPlayerName:SetText( LocalPlayer():Name() )
	txtPlayerName:SetTextColor( Color(255, 255, 255, 255) )

	local txtPlayerSteam = vgui.Create( "DLabel", panelBarBottom )
	txtPlayerSteam:SetSize( 200, 20 )
	txtPlayerSteam:SetPos( 74, 33 )
	txtPlayerSteam:SetText( LocalPlayer():SteamID() )
	txtPlayerSteam:SetFont( "LuneraFontSteamID" )

	function Lunera:OpenURL( luneraURL, LuneraTitle )

		if IsValid(panelBrowser) then panelBrowser:Remove() end

		panelBrowser = vgui.Create( "DFrame", LuneraPanelMenu )
		panelBrowser:Dock(FILL)
		panelBrowser:DockMargin(44,100,44,100)
		panelBrowser:ShowCloseButton(true)
		panelBrowser:SetTitle( "" )
		panelBrowser.Paint = function( self, w, h )
			DrawBlurPanel( self )
			surface.SetDrawColor(0,0,0,0)
			draw.RoundedBox( 4, 0, 0, w, h, Lunera.Settings.BrowserColor )
			draw.DrawText( LuneraTitle, "LuneraFontBrowserTitle", panelBrowser:GetWide() / 2, 8, color_white, TEXT_ALIGN_CENTER )
		end

		local dhtmlWindow = vgui.Create( "DHTML", panelBrowser )
		dhtmlWindow:SetSize( ScrW() - 200, 300 )
		dhtmlWindow:DockMargin( 10, 10, 5, 10 )
		dhtmlWindow:Dock( FILL )

		if Lunera.Settings.BrowserShowNavBar then

			local dhtmlControlsBar = vgui.Create( "DHTMLControls", panelBrowser )
			dhtmlControlsBar:Dock( TOP )
			dhtmlControlsBar:SetWide( ScrW() - 200 )
			dhtmlControlsBar:SetPos( 0, 0 )
			dhtmlControlsBar:SetHTML( dhtmlWindow )
			dhtmlControlsBar.AddressBar:SetText( luneraURL )

			dhtmlWindow:MoveBelow( dhtmlControlsBar )

		end

		dhtmlWindow:OpenURL( luneraURL )

	end

	function Lunera:OpenText( luneraText, LuneraTitle )

		if IsValid( panelBrowser ) then panelBrowser:Remove() end

		panelBrowser = vgui.Create( "DFrame", LuneraPanelMenu )
		panelBrowser:Dock(FILL)
		panelBrowser:DockMargin(44,100,44,100)
		panelBrowser:ShowCloseButton(true)
		panelBrowser:SetTitle( "" )
		panelBrowser.Paint = function( self, w, h )
			DrawBlurPanel( self )
			surface.SetDrawColor(0,0,0,0)
			draw.RoundedBox( 4, 0, 0, w, h, Lunera.Settings.BrowserColor )
			draw.DrawText( LuneraTitle, "LuneraFontBrowserTitle", panelBrowser:GetWide() / 2, 8, color_white, TEXT_ALIGN_CENTER )
		end

		local txtEntryMessage = vgui.Create( "DTextEntry", panelBrowser )
		txtEntryMessage:Dock(FILL)
		txtEntryMessage:DockMargin( 10, 20, 10, 15 )
		txtEntryMessage:SetMultiline( true )
		txtEntryMessage:SetDrawBackground( false )
		txtEntryMessage:SetEnabled( true )
		txtEntryMessage:SetVerticalScrollbarEnabled( true )
		txtEntryMessage:SetFont( "LuneraFontStandardText" )
		txtEntryMessage:SetText( luneraText )
		txtEntryMessage:SetTextColor( Color(255, 255, 255, 255) )

	end

	for k, v in pairs( Lunera.Settings.Buttons ) do
		if v.onLoad and v.enabled then
			local initFuncOnload = v.func()
			return
		end
	end

end
concommand.Add("lunera_motd", Lunera.guiMenu)

-----------------------------------------------------------------
--  Network Receivers
-----------------------------------------------------------------

net.Receive('LuneraInitMenu', function() 
	if ValidPanel( LuneraPanelMenu ) then
		LuneraPanelMenu:Remove()
	else
		Lunera:guiMenu()
	end
end)

-----------------------------------------------------------------
--  Keybinds
-----------------------------------------------------------------

if Lunera.Settings.KeybindAllowToggle then

	local nextThink = 0
	Lunera.MenuKey = Lunera.Settings.KeybindEnum or KEY_F4
	hook.Add( "Think", "LuneraOpenKey", function()
		if nextThink > CurTime() then return end

		if input.IsKeyDown( Lunera.MenuKey ) then
			if ValidPanel( LuneraPanelMenu ) then
				LuneraPanelMenu:Remove()
				gui.EnableScreenClicker( false )
			else
				Lunera:guiMenu()
				gui.EnableScreenClicker( true )
			end
			nextThink = CurTime() + 0.5
		end

	end)

end

