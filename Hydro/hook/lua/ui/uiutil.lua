do
   local MyUnitIdTable = {
      	'ahydro2',
	'ahydro3',
	'ahydro4',
      	'ehydro2',
	'ehydro3',
	'ehydro4',
      	'rhydro2',
	'rhydro3',
	'rhydro4',
      	'shydro2',
	'shydro3',
	'shydro4',


   }
   --unit icon must be in /icons/units/. Put the full path to the /icons/ folder in here - note no / on the end!
   local MyIconPath = "/Mods/Hydro"
   local oldUIFile = UIFile
   function UIFile(filespec)
      for i, v in MyUnitIdTable do
         if string.find(filespec, v .. '_icon') then
            local curfile =  MyIconPath .. filespec
            if DiskGetFileInfo(curfile) then
               return curfile
            else
               WARN('Blueprint icon for unit '.. control.Data.id ..' could not be found, check your file path and icon names!')
            end
         end
      end
      return oldUIFile(filespec)
   end
end 