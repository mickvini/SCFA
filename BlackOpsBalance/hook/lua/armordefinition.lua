--Adds FireBeetle armortype, plays nice with the CBP
do
    local armor_firebeetle = { 'FireBeetle',
        'Normal 1.0',
        'FireBeetleExplosion 0.0',
    }
    --Locate armor types within the table
    local firebeetle
    for id, armordef in armordefinition do
        if armordef[1] == 'FireBeetle' then
            firebeetle = id
        end
    end
    --Add firebeetle armor if one doesn't already exist (e.g. CBP)
    if not firebeetle then
        table.insert(armordefinition, armor_firebeetle)
    end
end