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
   local MyIconPath = "/mods/Hydro"
   
   local function IsMyUnit(bpid)
      for i, v in MyUnitIdTable do
         if v == bpid then
            return true
         end
      end
      return false
   end
   
   local oldUpdateWindow = UpdateWindow
   function UpdateWindow(info)
      oldUpdateWindow(info)
      if IsMyUnit(info.blueprintId) and DiskGetFileInfo(MyIconPath .. '/icons/units/' .. info.blueprintId.. '_icon.dds') then
         controls.icon:SetTexture(MyIconPath .. '/icons/units/' .. info.blueprintId .. '_icon.dds')
      end
   end
end