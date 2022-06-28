do
   local MyUnitIdTable = {
   	  'uel0108',
   	  'uab2306', 	
      'ual0302', 	
      'uel0302',
      'url0302',
      'urb2306',
      'uel0308',
      'url0204',      
      'ual0204',
      'ual0402',
      'uel0402',
      'url0403',  
      'url0305',
      'ura0305',
      'ura0106',
      'url0102',  
      'ura0305',   
      'ueb2201',  
      'ueb2201_a',
      'ueb2201_b',
      'ueb2201_c',
      'ual0108',
      'uel0305', 
      'ueb2306',
      'ual0310',
      'uel0107',
      'uaa0206',
      'uea0206',
      'ueb0209',
      'ueb0109',
      'ues0206',
	  'uel0403',
	  'ura0206',
	  'xsl0310a',	
	  'xsl0310b',		  
   }
   --unit icon must be in /icons/units/. Put the full path to the /icons/ folder in here - note no / on the end!
   local MyIconPath = "/mods/4th_Dimension_212"

   local oldFileNameFn = GetUnitIconFileNames
   
   local function IsMyUnit(bpid)
      for i, v in MyUnitIdTable do
         if v == bpid then
            return true
         end
      end
      return false
   end
   
   function GetUnitIconFileNames(blueprint)
      if IsMyUnit(blueprint.Display.IconName) then
         local iconName = MyIconPath .. "/icons/units/" .. blueprint.Display.IconName .. "_icon.dds"
         local upIconName = MyIconPath .. "/icons/units/" .. blueprint.Display.IconName .. "_icon.dds"
         local downIconName = MyIconPath .. "/icons/units/" .. blueprint.Display.IconName .. "_icon.dds"
         local overIconName = MyIconPath .. "/icons/units/" .. blueprint.Display.IconName .. "_icon.dds"
         
         if DiskGetFileInfo(iconName) == false then
            WARN('Blueprint icon for unit '.. blueprint.Display.IconName ..' could not be found, check your file path and icon names!')
            iconName = '/textures/ui/common/icons/units/default_icon.dds'
            upIconName = '/textures/ui/common/icons/units/default_icon.dds'
            downIconName = '/textures/ui/common/icons/units/default_icon.dds'
            overIconName = '/textures/ui/common/icons/units/default_icon.dds'
         end
         return iconName, upIconName, downIconName, overIconName
      else
         return oldFileNameFn(blueprint)
      end
   end
end