import XMonad
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.SetWMName
import XMonad.Actions.FloatKeys
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog

import Graphics.X11.ExtraTypes.XF86
import XMonad.Util.EZConfig

import Data.Monoid
import System.Exit
import Data.Ratio ((%))

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

import XMonad.Actions.CopyWindow

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "gnome-terminal"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Width of the window border in pixels.
--
myBorderWidth   = 0

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod1Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--

-- Define layout for specific workspaces  
nobordersLayout = noBorders $ layoutTmp
    
 -- Put all layouts together  
myLayout = onWorkspace "4:video" nobordersLayout $ defaultLayouts  
         
myWorkspaces = ["1:main","2","3","4:video","5:notes","6:mail","7","8"]  
           
--myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#333333"
myFocusedBorderColor = "#ff0000"

toggleFloat = withFocused (\windowId -> do { 
	floats <- gets (W.floating . windowset);
	if windowId `M.member` floats 
	then withFocused $ windows . W.sink
	else	float windowId >> 
				withFocused (keysResizeWindow (-1050,-600) (0.95,0.05))
	})
------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- close focused window
--    , ((modm .|. shiftMask, xK_c     ), kill)
    [ ((modm,		 						xK_c     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_m     ), refresh)

    -- Move focus to the next window
--    , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
--    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

		-- toggle float or tiling, resizing.
    , ((modm,               xK_t     ), toggleFloat)
		, ((modm,               xK_minus     ), withFocused (keysResizeWindow (-48,-27) (0.5,0.5)))
		, ((modm,               xK_equal     ), withFocused (keysResizeWindow (48,27) (0.5,0.5)))
		, ((modm,               xK_bracketleft     ), withFocused (keysResizeWindow (-48, 0) (0.5,1)))
		, ((modm,               xK_bracketright    ), withFocused (keysResizeWindow (48, 0) (0.5,1)))

		-- moving window.
		, ((modm,               xK_Left	   ), withFocused (keysMoveWindow (-50,0)))
		, ((modm,               xK_Right   ), withFocused (keysMoveWindow (50,0)))
		, ((modm,               xK_Up  	   ), withFocused (keysMoveWindow (0,-50)))
		, ((modm,               xK_Down    ), withFocused (keysMoveWindow (0,50)))

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
		, ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
--    , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart; notify-send 'xmonad recomped.'; pkill xbindkeys; xbindkeys")

		-- Volume control..
    , ((0,               xF86XK_AudioLowerVolume     ), spawn "amixer -D hw:$AUDIODEV sset Master,0 1%-; notify-send 'ALSA Master Volume' -h int:value:$(amixer -D hw:$AUDIODEV sget Master,0| fgrep dB| cut -d'[' -f2| cut -d '%' -f1)")
    , ((0,               xF86XK_AudioRaiseVolume     ), spawn "amixer -D hw:$AUDIODEV sset Master,0 1%+; notify-send 'ALSA Master Volume' -h int:value:$(amixer -D hw:$AUDIODEV sget Master,0| fgrep dB| cut -d'[' -f2| cut -d '%' -f1) ")
    , ((0,               xF86XK_AudioMute     ), spawn "amixer -D hw:$AUDIODEV sset Master,0 toggle; notify-send 'ALSA Master Volume' -h int:value:$(amixer -D hw:$AUDIODEV sget Master,0| fgrep dB| cut -d' ' -f8) ")

--		 , ((modm, xK_v ), windows copyToAll) -- @@ Make focused window always visible
--	   , ((modm .|. shiftMask, xK_v ),  killAllOtherCopies) -- @@ Toggle window state back


    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [
--		((modm, button1), (\w -> focus w >> mouseMoveWindow w
--                                       >> windows W.shiftMaster))
--
--    -- mod-button2, Raise the window to the top of the stack
--    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))
--
--    -- mod-button3, Set the window to floating mode and resize by dragging
--    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
--                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
layoutTmp = Full ||| tiled -- ||| Mirror tiled 
  where
     tiled   = Tall nmaster delta ratio
     nmaster = 1
     ratio   = 2/3
     delta   = 1/20


defaultLayouts = tiled |||Full
  where
     -- default tiling algorithm partitions the screen into two panes
--     tiled   = Tall nmaster delta ratio
     tiled   = spacing 0 $ Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 2/3

     -- Percent of screen to increment by when resizing panes
     delta   = 1/15


------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "Guake"        	--> doFloat
    , className =? "Tilda"        	--> doFloat
    , className =? "Dunst"        	--> doFloat
    , className =? "guvcview"       --> doFloat
--    , className =? "guvcview"       --> doFloat
    , className =? "Zenity"        	--> doFloat
--    , className =? "EBView"        	--> doFloat
    , className =? "Wicd-client.py"        	--> doFloat
    , className =? "Dialog"    			--> doFloat
		, className =? "Conky"					--> doFloat
		, className =? "Wine"					--> doFloat
		, className =? "Fcitx-config-gtk3"					--> doFloat
		, className =? "xpad"						--> doShift "5:notes"
--		, className =? "Gimp"           --> doFloat
    , className =? "Qjackctl"           --> doFloat
    , className =? "qsynth"           --> doFloat
    , className =? "Rosegarden"           --> doFloat
    , className =? "rosegarden"           --> doFloat
--    , className =? "Florence"           --> doFloat
--    , className =? "Florence"           --> doIgnore
    , className =? "kvkbd"           --> doFloat
    , className =? "VMPK-Virtual MIDI Piano Keyboard"           --> doFloat
    , className =? "BasicWin"           --> doFloat
    , className =? "Sphinxkeys.py"           --> doFloat
--    , className =? "kvkbd"           --> doIgnore
--    , className =? "Cellwriter"           --> doIgnore
    , resource  =? "desktop_window" --> doIgnore
    , className =? "Conky"					--> doIgnore
    , className =? "Gimp"					--> doFloat
    , className =? "Xfce4-notifyd"	--> doIgnore
--    , className =? "Ninix_main.py"	--> doIgnore
    , className =? "conky"					--> doIgnore
--    , className =? "Anki"					--> doShift "5:notes"
    , className =? "Patchage"					--> doShift "5:notes"
		, title =? "File Operation Progress" --> doFloat
		, title =? "PlayOnLinux" --> doFloat
		, className =? "GrandOrgue" --> doFloat
		, className =? "feh" --> doFloat
		, className =? "ssp.exe" --> doF (copyToAll)
		, className =? "ssp.exe" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore]

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--

-- fade inactive.
myLogHook :: X ()
myLogHook = fadeInactiveLogHook fadeAmount
	where fadeAmount = 0.6


------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main = xmonad defaults


-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults = defaultConfig {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        logHook            = myLogHook,
        startupHook        = setWMName "LG3D",
        handleEventHook    = fullscreenEventHook
    }
