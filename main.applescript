-- modified from script at https://audiophilestyle.com/forums/topic/11819-a-usefull-applescript-code-for-audiophiles/
-- BEGIN APPLESCRIPT --



set DACname to "HIFI DSD"

--set DACname to "Built-in Output"



set newDefaultDeviceName to DACname --"Built-in Output"

set newAlertDeviceName to "Built-in Output"



set menuDefaultOut to "Use this device for sound output"

set menuAlert to "Play alerts and sound effects through this device"





--if application "iTunes" is running then tell application "iTunes" to stop



activate application "Audio MIDI Setup"

tell application "System Events"
	
	tell process "Audio MIDI Setup"
		
		try
			
			click menu item "Show Audio Window" of menu 1 of menu bar item "Window" of menu bar 1
			
		end try
		
		
		
		--Set Nrows to number of audio devices:
		get properties
		set rowList to value of attribute "AXVisibleRows" of outline 1 of scroll area 1 of splitter group 1 of window "Audio Devices"
		
	end tell
	
end tell

set Nrows to count of rowList





--Select desired audio device (row N):

set Failure to true

tell application "System Events"
	
	tell process "Audio MIDI Setup"
		
		repeat with N from Nrows to 1 by -1
			
			set deviceName to name of UI element 1 of row N of outline 1 of scroll area 1 of splitter group 1 of window "Audio Devices"
			
			if deviceName = DACname then
				
				select row N of outline 1 of scroll area 1 of splitter group 1 of window "Audio Devices"
				
				set Failure to false
				
				exit repeat
				
			end if
			
		end repeat
		
	end tell
	
end tell



if Failure then
	
	display dialog "Missing device: " & DACname
	
	return --Quit the script.
	
end if





-- SetAudioDevice(newAlertDeviceName, menuAlert)

SetAudioDevice(newDefaultDeviceName, menuDefaultOut)



-- END MAIN --





on SetAudioDevice(myDeviceName, myType)
	
	activate application "Audio MIDI Setup"
	
	tell application "System Events"
		
		tell process "Audio MIDI Setup"
			
			
			
			-- Open Audio Devices window if it is closed:
			
			try
				
				click menu item "Show Audio Window" of menu "Window" of menu bar item "Window" of menu bar 1
				
			end try
			
			
			
			-- List of Audio Devices in left column:
			
			tell outline 1 of scroll area 1 of splitter group 1 of window "Audio Devices"
				
				
				set N to 0
				
				
				
				-- Set N to index of desired device:
				
				repeat with k from 1 to (count of rows)
					
					--set deviceName to value of text field 1 of row k
					
					--display dialog (k as text) & deviceName
					set x to name of UI element 1 of row k
					
					if x = myDeviceName then
						
						set N to k
						
						exit repeat
						
					end if
					
				end repeat
				
				if N = 0 then
					
					display dialog "Desired Audo Device not found."
					
					quit
					
				end if
				
				
				
				--Select desired output device:
				
				select row N
				
			end tell
			
			
			
			--Use this device for sound output:
			
			tell window "Audio Devices"
				
				perform action "AXShowMenu" of outline 1 of scroll area 1 of splitter group 1
				
				tell menu 1 of outline 1 of scroll area 1 of splitter group 1
					click menu item 5
				end tell
				tell application "System Events"
					key code 53
				end tell
				perform action "AXShowMenu" of outline 1 of scroll area 1 of splitter group 1
				tell menu 1 of outline 1 of scroll area 1 of splitter group 1
					click menu item 6
				end tell
				tell application "System Events"
					key code 53
				end tell
				
				
			end tell
			tell window "Audio Devices"
				perform action "AXPress" of radio button "Output" of tab group 1 of splitter group 1
				perform action "AXPress" of pop up button 2 of tab group 1 of splitter group 1
				tell menu 1 of pop up button 2 of tab group 1 of splitter group 1
					click menu item 15
				end tell
			end tell
			
			
			
			
		end tell
		
	end tell
	
end SetAudioDevice



-- END APPLESCRIPT --
