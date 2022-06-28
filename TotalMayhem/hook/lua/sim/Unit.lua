do

local oldUnit=Unit
Unit = Class(oldUnit) {
OnStartBuild = function(self, unitBeingBuilt, order)
                oldUnit.OnStartBuild(self, unitBeingBuilt, order)
               
                if order == 'MobileBuild' then
                        local LowerCostUnits = {
                                'brmat1exgs', 'brmt3exbm', 'broat1exgs', 'brnt1hpd', 'brmt1beetle', 'brmt2beetle', 'brmt1expd', 'brmt1expdt2', 'brmt2epd', 'brmt2medm', 'brmt2wildcat', 'brmt3exbm', 'brmt3ham', 'brmt3mcm', 'brmt3mcm2', 'brmt3mcm4', 'brmt3ava', 'brmt3vul', 'brnt1expd', 'brnt2bm', 'brnt1exart', 'brnt3shbm', 'brnt3argus', 'brnt3blasp', 'brnt3bat', 'brnt3shpd', 'brnt1exmob', 'brnt2epd', 'brnt2exart', 'brnt3pdro', 'brmt3pdro', 'brot3pdro', 'brmt3pd', 'brnt2exlm', 'brnt2exm1', 'brnt2exm2', 'brot1extank', 'brot1expd', 'brot2exth', 'brot3coug', 'brot3ham', 'brot3ncm', 'brot3shbm', 'brot3shpd', 'brot2exbm', 'brot2exm2', 'brot2epd', 'brnt1extk', 'brmt1extank', 'brot1exmobart', 'brmt1exm1', 'brmt2medm', 'brnt1exm1', 'brnt2bm', 'brnt2exm1', 'brnt2exm2', 'brot1exm1', 'brot1exm2', 'brot2asb', 'brot2exm2', 'brot2exth', 'brnt2exmdf', 'brmt3advbtbot', 'brpt1expbot', 'brpt1extank2', 'brpat1exgunship', 'brpt1expd', 'brpt2expd', 'brpt2exbot', 'brpat1advbomb', 'brmt3garg', 'brot3exm1', 'brpt3shbm', 'brpt2hvbot', 'brnt2sniper', 'brnt3doomsday', 'brpt3pd', 'brnt1expdt2', 'brnt3shbm2', 'brnat1exgs', 'brot3ncm2', 'brmt1advart', 'brnbaafac' , 'brnat3bomber', 'broat3bomber', 'brnt3advbtbot', 'brnt1advnavygun', 'brmt1advnavygun', 'brot1advnavygun', 'brpt1advnavygun', 'brobt1hydeng', 'brot3hades', 'broat2exgs', 'brmt1pd', 'brmt1pdt2', 'brnt2pd2', 'brmt2pd', 'brnt3perses', 'broat3pride', 'brmt1advbot', 'brmat2gunship', 'brmt3snake', 'brn1advbot'
                        }
                        local UBBBPID = unitBeingBuilt:GetBlueprint().BlueprintId
                        local mult = 0.25
                       
                        if table.find(LowerCostUnits, UBBBPID) then
                                local AIBrain = self:GetAIBrain()
                                if AIBrain.BrainType != 'Human' then
                                        WARN('--> builder is building ' .. repr(UBBBPID).. ' apply mult value to econ')
                                        self.EconChangedForIA = true
                                        self.EconChangedForIAValues = { Energy = self.EnergyBuildAdjMod, Mass = self.MassBuildAdjMod }
                                        self.EnergyBuildAdjMod = mult
                                        self.MassBuildAdjMod = mult
                                        self:UpdateConsumptionValues()
                                end
                        else
                                if self.EconChangedForIA then
                                        local LastValues = self.EconChangedForIAValues
                                        self.EnergyBuildAdjMod = LastValues.Energy or nil
                                        self.MassBuildAdjMod = LastValues.Mass or nil
                                        self:UpdateConsumptionValues()
                                        self.EconChangedForIAValues = nil
                                        self.EconChangedForIA = nil
                                end
                        end
                end
        end,
}

end