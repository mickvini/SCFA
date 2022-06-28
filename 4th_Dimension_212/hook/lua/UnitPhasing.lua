#**************************************************************************** 
#** 
#**  File          : /lua/UnitPhasing.lua 
#** 
#**  Author        : Resin_Smoker 
#** 
#**  Summary       : Unit Phasing: Allows a unit so enhanced to shift it's molecules 
#**                  around into extra spatial dimensions becoming translucent and 
#**                  semi-ethereal, almost completely non corporeal. 
#**                  The advantage to this is that a unit so enhanced can avoid a 
#**                  percentage direct fire weapons by allowing them to pass thru it 
#**                  harmlessly! While protected from directfire projectiles, a Phased
#**                  unit is still very vunerable from laser weapons, damage over time
#**                  weapons, and projectile with signifigant splash damage.  
#** 
#**  Copyright     : 4th Dimension, 2009 
#** 
#**************************************************************************** 
#** 
#**  The following is required in the units script for UnitPhasing 
#**  This calls into action the UnitPhasing scripts for SAirUnit 
#** 
#**  local SAirUnit = import('/lua/seraphimunits.lua').SAirUnit
#**  SAirUnit = import('/mods/4th_Dimension_212/hook/lua/UnitPhasing.lua').UnitPhasing( SAirUnit ) 
#** 
#**************************************************************************** 

### Start of AdvancedJamming(SuperClass)
function UnitPhasing(SuperClass) 
    return Class(SuperClass) {
    
    OnStopBeingBuilt = function(self,builder,layer) 
        SuperClass.OnStopBeingBuilt(self,builder,layer)      
        ### Phase Global Variables 
        self.BP = self:GetBlueprint() 
        self.PhaseEnabled = false
        self.PriorStatus = false 
        self:SetMaintenanceConsumptionInactive()
        if self.BP.Defense.Phasing.StartsOn == true then
            self:SetScriptBit('RULEUTC_ShieldToggle', true) 
        end        
        self:ForkThread(self.EconomyHeartBeat)                                                                       
    end,
    
    EconomyHeartBeat = function(self)
        local cost = self.BP.Economy.MaintenanceConsumptionPerSecondEnergy           
        while not self:IsDead() do    
            local econ = self:GetAIBrain():GetEconomyStored('Energy')           
            if econ < cost and self.PhaseEnabled == true then
                self.PriorStatus = true
                self:ForkThread(self.PhaseDisable) 
            elseif self.PriorStatus == true and self.PhaseEnabled == false and econ > cost then
                self.PriorStatus = false
                self:ForkThread(self.PhaseEnable)
            end       
            ### Short delay between checks
            WaitSeconds(Random(1, 3))         
        end
    end, 
            
    OnScriptBitSet = function(self, bit)
        if bit == 0 then
            self:ForkThread(self.PhaseEnable)
        end
        SuperClass.OnScriptBitSet(self, bit)
    end,     
     
    OnScriptBitClear = function(self, bit)
       if bit == 0 then
           self.PriorStatus = false
           self:ForkThread(self.PhaseDisable)      
       end
       SuperClass.OnScriptBitClear(self, bit)
    end,    
    
    PhaseEnable = function(self)
        if not self:IsDead() and not self.PhaseEnabled == true then 
            self.PhaseEnabled = true
            self:SetMaintenanceConsumptionActive() 
            self:SetMesh(self.BP.Defense.Phasing.PhaseMesh, true)  
        end
    end,    
    
    PhaseDisable = function(self)
        if not self:IsDead() and not self.PhaseEnabled == false then    
            self.PhaseEnabled = false    
            self:SetMaintenanceConsumptionInactive() 
            self:SetMesh(self.BP.Defense.Phasing.StandardMesh, true)            
        end
    end,
    
    OnCollisionCheck = function(self, other, firingWeapon)
        if not self:IsDead() and self.PhaseEnabled == true then
            if EntityCategoryContains(categories.PROJECTILE, other) then  
                local random = Random(1,100) 
                ### Allows % of projectiles to pass 
                if random <= self.BP.Defense.Phasing.PhasePercent then   
                    ### Returning false allows the projectile to pass thru
                    return false       
                else 
                    ### Projectile impacts normally 
                    return true  
                end
            end
        else
            ### Projectile impacts normally 
            return true            
        end
        SuperClass.OnCollisionCheck(self, other, firingWeapon)  
    end,        
}
end 
### End of AdvancedJamming(UnitPhasing) ###