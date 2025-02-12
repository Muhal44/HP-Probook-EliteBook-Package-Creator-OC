# Applescript create by chris1111
# Install Media HP Laptop OC Copyright (c) 2020, 2023 chris1111 All rights reserved.
# No right on OpenCore Bootloader
#
# Credit: Apple
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
# Version "1.0" by chris1111
# Vars

set theAction to button returned of (display dialog "
Welcome Install Media HP Laptop OC
Support:
8-series laptop: HP Probook 3x0 G1, Probook 4x0 G1/G2, Probook 6x0 G1, Elitebook 8x0 G1, ZBook G1, Folio 1040 G1
Support macOS Sierra 10.12 to macOS Ventura 13
————————————————————————
7-series laptop: HP Probook 4x40s, 4x0 G0, 6x70b, 
6x70B-AMD, 6x70B-NVIDIA,  Elitebook 8x70p, 2x70p, 9x70m
7 series laptop HP Probook, EliteBook. Support macOS Sierra 10.12 to macOS Ventura 13
————————————————————————

You can create a bootable USB key 
from macOS 10.12 to macOS Ventura 13
		
Format your USB Drive with Disk Utility 
in the format Mac OS Extended (Journaled) 
GUID Partition Map

*****************************
You must quit Disk Utility to continue 
installation !" with icon note buttons {"Quit", "Create Install Media"} cancel button "Quit" default button {"Create Install Media"})

--If Create Install Media
if theAction = "Create Install Media" then
	set the_command to quoted form of POSIX path of (path to resource "VolumesRename" in directory "Scripts")
	do shell script the_command with administrator privileges
	--If Continue
	if theAction = "Create Install Media" then
		
		tell application "Disk Utility"
			activate
		end tell
		
		repeat
			if application "Disk Utility" is not running then exit repeat
		end repeat
		activate me
		set all to paragraphs of (do shell script "ls /Volumes")
		set w to choose from list all with prompt " 
To be able to continue, select the volume
that you just formatted.
Then press the OK button" OK button name "OK" with multiple selections allowed
		if w is false then
			display dialog "Quit Installer" with icon note buttons {"EXIT"} default button {"EXIT"}
			
			return
		end if
		try
			repeat with teil in w
				do shell script "diskutil `diskutil list | awk '/ " & teil & "  / {print $NF}'`" with administrator privileges
			end repeat
		end try
		
		
		set source to path to me as string
		set source to POSIX path of source & "Contents/Resources/Installer/VolumePackage.pkg"
		set source to quoted form of source
		
		do shell script ¬
			"installer -pkg  " & source & " -target \"" & w & "\"" with administrator privileges
		delay 1
		--If Continue		
		set theAction to button returned of (display dialog "

Choose the location of your Install macOS.app" with icon note buttons {"Quit", "macOS 10.12", "10.13 to Ventura 13"} cancel button "Quit" default button {"10.13 to Ventura 13"})
		if theAction = "10.13 to Ventura 13" then
			--If 10.13 to Ventura 13
			display dialog "
Your choice is 10.13 to Ventura 13
Choose your Install OS X.app 
From macOS High Sierra to macOS Ventura" with icon note buttons {"Quit", "Continue"} cancel button "Quit" default button {"Continue"}
			
			set InstallOSX to choose file of type {"XLSX", "APPL"} default location (path to applications folder) with prompt "Choose your Install macOS.app"
			set OSXInstaller to POSIX path of InstallOSX
			
			delay 2
			
			set progress description to "Create Install Media
======================================
Installation time 15 to 25 min on a standard USB key
3 to 5 min on a Disk Ext HD
======================================
"
			
			set progress total steps to 7
			
			set progress additional description to "Analysing Install macOS"
			delay 2
			set progress completed steps to 1
			
			set progress additional description to "Analysing USB Install Media"
			delay 2
			set progress completed steps to 2
			
			set progress additional description to "Install USB Media OK"
			delay 2
			set progress completed steps to 3
			
			set progress additional description to "Install in Progress "
			delay 1
			set progress completed steps to 4
			
			set progress additional description to "Install in Progress Wait! "
			delay 1
			set progress completed steps to 5
			
			set progress additional description to "Installing macOS  wait . . . ."
			delay 1
			--display dialog cmd
			set cmd to "sudo \"" & OSXInstaller & "Contents/Resources/createinstallmedia\" --volume /Volumes/Install-Media --nointeraction "
			do shell script cmd with administrator privileges
			set progress completed steps to 6
			
			set progress additional description to "Install in Progress 90%"
			delay 2
			set progress completed steps to 7
			set progress additional description to "
Create Install Media Completed ➤ ➤ ➤ 100%
Create Install Media Completed.
OpenCore Installer! "
			delay 3
			set theFile to ((path to me) as string) & "Contents:Resources:Installer:OpenCore USB.pkg"
			tell application "Finder" to open theFile
			
		else if theAction = "macOS 10.12" then
			
			--If 10.9 to 10.12
			display dialog "
macOS 10.12
Choose the location of your Install macOS.app
" with icon note buttons {"Quit", "Continue"} cancel button "Quit" default button {"Continue"}
			
			set InstallOSX to choose file of type {"XLSX", "APPL"} default location (path to applications folder) with prompt "Choose your Install macOS.app"
			set OSXInstaller to POSIX path of InstallOSX
			
			delay 2
			
			set progress description to "Create Install Media
======================================
Installation time 15 to 20 min on a standard USB key
3 to 5 min on a Disk Ext HD
======================================
"
			
			set progress total steps to 7
			
			set progress additional description to "Analysing Install macOS"
			delay 2
			set progress completed steps to 1
			
			set progress additional description to "Analysing USB Install Media"
			delay 2
			set progress completed steps to 2
			
			set progress additional description to "Install USB Media OK"
			delay 2
			set progress completed steps to 3
			
			set progress additional description to "Install in Progress "
			delay 1
			set progress completed steps to 4
			
			set progress additional description to "Install in Progress Wait! "
			delay 1
			set progress completed steps to 5
			
			set progress additional description to "Installing macOS  wait . . . ."
			delay 1
			--display dialog cmd
			set cmd to "sudo \"" & OSXInstaller & "Contents/Resources/createinstallmedia\" --volume /Volumes/Install-Media --applicationpath \"" & OSXInstaller & "\" --nointeraction "
			do shell script cmd with administrator privileges
			set progress completed steps to 6
			
			set progress additional description to "Install in Progress 90%"
			delay 2
			set progress completed steps to 7
			set progress additional description to "
Create Install Media Completed ➤ ➤ ➤ 100%
Create Install Media Completed.
OpenCore Installer! "
			delay 3
			set theFile to ((path to me) as string) & "Contents:Resources:Installer:OpenCore USB.pkg"
			tell application "Finder" to open theFile
		end if
	end if
end if