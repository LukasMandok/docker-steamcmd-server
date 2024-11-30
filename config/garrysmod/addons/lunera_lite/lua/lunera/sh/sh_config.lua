-----------------------------------------------------------------
-- @package     LuneraLITE
-- @author      Richard
-- @build       v1.4.0
-- @release     11.22.2015
-----------------------------------------------------------------

Lunera = Lunera or {}
Lunera.Settings = Lunera.Settings or {}
Lunera.Language = Lunera.Language or {}

-----------------------------------------------------------------
-- [ WORKSHOP / FASTDL RESOURCES ]
-----------------------------------------------------------------
-- Set [Lunera.Settings.ResourcesEnable] to false if you do not wish 
-- for the server to force players to download the 
-- resources/materials.
-----------------------------------------------------------------
-- Set [Lunera.Settings.WorkshopEnabled] to false if you do not wish
-- for the server to force clients to download the resources 
-- from the workshop.
-----------------------------------------------------------------

Lunera.Settings.ResourcesEnable = true
Lunera.Settings.WorkshopEnabled = true

-----------------------------------------------------------------
-- [ RULES ]
-----------------------------------------------------------------
-- List the results for your server here.
-----------------------------------------------------------------

Lunera.Settings.RulesText = [[

----DO NOT DO THE FOLLOWING----
[x] No ghosting while in spectator mode or when dead
[x] No racist or sexually abusive comments toward others
[x] No impersonating staff members
[x] No being disrespectful to other players or staff
[x] No threatening to DDoS or take down our network [perm-ban and IP logging]
[x] No asking for other players personal information (IE: home address, phone number)
[x] No blocking doors or denying players access to a part of the map.
[x] No abusing the !unstuck command.
[x] No prop-killing.
[x] No hiding in areas as a prop that hunters cannot access or see.
[x] No mic or chat spamming.

----INFRACTION CONSEQUENCES----
The following actions may be taken in this order [unless violating a more serious offense]:

[-] Player shall be warned about the rule they have broken.
[-] Will be kicked from the server if they continue to break a rule.
[-] A ban will be issued for a term of 3-5 days (depending on what occured)
[-] A permanent ban will be issued and shall not be removed
[-] Bypassing a server ban will result in a GLOBAL BAN from ALL servers within our network including denied access to our website

]]

-----------------------------------------------------------------
-- [ CUSTOM HTML BOX ]
-----------------------------------------------------------------
-- If you do not wish to use the advertisement box, you can use 
-- the custom HTML box. It fills the center of the MOTD screen 
-- with a browsable website of your choice.
-----------------------------------------------------------------

Lunera.Settings.HTMLLoader = false 
Lunera.Settings.HTMLShowNavBar = false
Lunera.Settings.HTMLurl = "http://steamcommunity.com/"

-----------------------------------------------------------------
-- [ MOTD BINDS / TOGGLE ]
-----------------------------------------------------------------
-- [Lunera.Settings.InitOnJoin]
-- true    :: MOTD WILL display when player joins server.
-- false   :: MOTD WILL NOT display when player joins server.
-----------------------------------------------------------------
-- [Lunera.Settings.KeybindAllowToggle]
-- true    :: Will toggle when the key assigned to 
--            Lunera.Settings.KeybindEnum is pressed.
-- false   :: Will ignore when key assigned to
--            Lunera.Settings.KeybindEnum is pressed.
-----------------------------------------------------------------
-- [Lunera.Settings.KeybindEnum]
-- Determines what key will toggle (activate) Lunera when the 
-- setting Lunera.Settings.KeybindAllowToggle is set to true.
-- Uses ENUMS.
-----------------------------------------------------------------
-- [Lunera.Settings.KeybindChat]
-- What the public chat command will be in order for players to
-- toggle Lunera.
-----------------------------------------------------------------

Lunera.Settings.InitOnJoin = true
Lunera.Settings.KeybindAllowToggle = true
Lunera.Settings.KeybindEnum = KEY_F4
Lunera.Settings.KeybindChat = "!motd"

-----------------------------------------------------------------
-- [ CLOCK ]
-----------------------------------------------------------------
-- [Lunera.Settings.ClockEnabled]
-- true    :: Clock will display in bottom right.
-- false   :: Clock will NOT display in bottom right.
-----------------------------------------------------------------
-- [Lunera.Settings.ClockTextColor]
-- Text color that the color will appear in.
-----------------------------------------------------------------

Lunera.Settings.ClockEnabled = true 
Lunera.Settings.ClockTextColor = Color ( 255, 255, 255, 255 )

-----------------------------------------------------------------
-- How the time will display
-- To see a list of format properties:
--      https://maurits.tv/data/garrysmod/wiki/wiki.garrysmod.com/index09bf.html
-----------------------------------------------------------------

Lunera.Settings.ClockSyntax = "%a, %I:%M:%S %p"

-----------------------------------------------------------------
-- [ GENRAL SETTINGS ]
-----------------------------------------------------------------

Lunera.Settings.NetworkName = "LDTNE - TTT Server"
Lunera.Settings.NetworkNameColor = Color( 255, 255, 255, 255 )
Lunera.Settings.BottomBarColor = Color( 255, 136 , 0, 255 )

-----------------------------------------------------------------
-- [ ROTATING BACKGROUNDS ]
-----------------------------------------------------------------
-- [Lunera.Settings.BackgroundsEnable]
-- If set to true - each time Liko is opened, a new background 
-- will be shown. Disable this to have no background at all.
-----------------------------------------------------------------
-- [Lunera.Settings.Backgrounds]
-- A list of backgrounds you want to use for rotation. These are
-- actual URLs to images on the internet.
-----------------------------------------------------------------

Lunera.Settings.BackgroundsEnable = true 
Lunera.Settings.Backgrounds = {
    "http://galileomanager.com/api/products/1621/resources/wallpaper/lunera-gmod-wallpaper-001.jpg",
    "http://galileomanager.com/api/products/1621/resources/wallpaper/lunera-gmod-wallpaper-002.jpg",
    "http://galileomanager.com/api/products/1621/resources/wallpaper/lunera-gmod-wallpaper-003.jpg",
    "http://galileomanager.com/api/products/1621/resources/wallpaper/lunera-gmod-wallpaper-004.jpg",
    "http://galileomanager.com/api/products/1621/resources/wallpaper/lunera-gmod-wallpaper-005.jpg",
    "http://galileomanager.com/api/products/1621/resources/wallpaper/lunera-gmod-wallpaper-006.jpg"
}

-----------------------------------------------------------------
-- [ BUTTONS ]
-----------------------------------------------------------------

Lunera.Settings.MenuButtonColor = Color( 15, 15, 15, 0 )
Lunera.Settings.MenuButtonHoverColor = Color( 255, 255, 255, 220 )
Lunera.Settings.MenuButtonTextColor = Color( 255, 255, 255, 255 )
Lunera.Settings.MenuButtonHoverTextColor = Color( 0, 0, 0, 255 )

Lunera.Settings.ServerButtonColor = Color( 15, 15, 15, 0 )
Lunera.Settings.ServerButtonHoverColor = Color( 255, 255, 255, 220 )
Lunera.Settings.ServerButtonTextColor = Color( 255, 255, 255, 255 )
Lunera.Settings.ServerButtonHoverTextColor = Color( 0, 0, 0, 255 )

Lunera.Settings.MenuTextRules = "Network Rules"
Lunera.Settings.MenuLinkRules = "http://ldtne.ddnss.de/ttt/ttt_regeln/index.html"

Lunera.Settings.MenuTextRoles = "Custom Roles"
Lunera.Settings.MenuLinkRoles = "http://ldtne.ddnss.de/ttt/ttt_regeln/roles.html"

Lunera.Settings.MenuTextDonate = "Donate to Network"
Lunera.Settings.MenuLinkDonate = "http://paypal.com/"

Lunera.Settings.MenuTextWebsite = "Welcome to Network"
Lunera.Settings.MenuLinkWebsite = "http://facepunch.com/"

Lunera.Settings.MenuTextWorkshop = "Workshop Collection"
Lunera.Settings.MenuLinkWorkshop = "https://steamcommunity.com/sharedfiles/filedetails/?id=2324894576"

Lunera.Settings.menuTextGroup = "Network Steam Group"
Lunera.Settings.MenuLinkGroup = "https://steamcommunity.com/groups/LDTNE"

-----------------------------------------------------------------
-- Button Properties
--      name = (text to display on button)
--      icon = (icon to use for button)
--      func = (what to do when button is pressed)
--      enabled = (if button should show or not)
--      onLoad = (if panel should show as soon as MOTD is opened)
--          |> *Note*: Only ONE should be set to TRUE 
-----------------------------------------------------------------
-- To toggle buttons to do what you want, you will change the
-- code after each 'func = function()' line.
--
-- To open a URL in the STEAM BROWSER
--      gui.OpenURL( "http://urlhere.com"
--
-- To open a URL with the BUILT IN BROWSER 
--       Lunera:OpenURL( "http://urlhere.com", "Titlebar Name" )
--
-- To open a Frame with JUST text (IE: Rules)
--      Lunera:OpenText( "Text to display", "Titlebar Name" )
--
-- To run a ConCommand:
--      RunConsoleCommand('concommand_here')
--
-----------------------------------------------------------------

Lunera.Settings.Buttons = {
    {
        name = "Rules",
        icon = "lunera/lunera_btn_rules.png",
        func = function()
            Lunera:OpenURL( Lunera.Settings.MenuLinkRules, Lunera.Settings.MenuTextRules )
        end,
        enabled = true,
        onLoad = true
    },
	{
        name = "Roles",
        icon = "lunera/lunera_btn_roles.png",
        func = function()
            Lunera:OpenURL( Lunera.Settings.MenuLinkRoles, Lunera.Settings.MenuTextRoles )
        end,
        enabled = true,
        onLoad = false
    },
    {
        name = "Donate",
        icon = "lunera/lunera_btn_donate.png",
        func = function()
            Lunera:OpenURL( Lunera.Settings.MenuLinkDonate, Lunera.Settings.MenuTextDonate )
        end,
        enabled = false,
        onLoad = false
    },
    {
        name = "Website",
        icon = "lunera/lunera_btn_website.png",
        func = function()
            Lunera:OpenURL( Lunera.Settings.MenuLinkWebsite, Lunera.Settings.MenuTextWebsite )
        end,
        enabled = false,
        onLoad = false
    },
    {
        name = "Workshop",
        icon = "lunera/lunera_btn_workshop.png",
        func = function()
            Lunera:OpenURL( Lunera.Settings.MenuLinkWorkshop, Lunera.Settings.MenuTextWorkshop )
        end,
        enabled = true,
        onLoad = false
    },
    {
        name = "Steam Group",
        icon = "lunera/lunera_btn_steam.png",
        func = function ()
            Lunera:OpenURL( Lunera.Settings.MenuLinkGroup, Lunera.Settings.menuTextGroup )
        end,
        enabled = true,
        onLoad = false
    }
}

Lunera.Settings.UseButtonIconsWithText = true -- This shows the icons with text.
Lunera.Settings.UseButtonIconsOnly = true -- This will show the icons only, without the text counterpart. The above option OVERRIDES this, so please turn that off first.

-----------------------------------------------------------------
-- [ INTEGRATED WEB BROWSER ]
-----------------------------------------------------------------
-- [Lunera.Settings.BrowserShowNavBar]
-- true    :: Enable the nav options (back, forward, stop, reload)
-- false   :: Disable the nav options.
-----------------------------------------------------------------
-- [Lunera.Settings.BrowserColor]
-- The color to use for the integrated web browser panel.
-----------------------------------------------------------------

Lunera.Settings.BrowserShowNavBar = false
Lunera.Settings.BrowserColor = Color( 0, 0, 0, 240 )
