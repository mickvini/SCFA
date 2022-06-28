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
   local MyIconPath ="/mods/4th_Dimension_212" 
   
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