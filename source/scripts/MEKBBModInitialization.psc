Scriptname MEKBBModInitialization extends ReferenceAlias

Weapon Property MEKBBBarstool Auto


LeveledItem Property LItemWeaponDwarvenWarhammer Auto
LeveledItem Property LItemwerewolfBossWarhammer Auto
LeveledItem Property LItemSoldierSonsWarhammer Auto
LeveledItem Property LItemWeaponWarhammerTown Auto
LeveledItem Property LItemWeaponWarhammer Auto
LeveledItem Property LItemBanditWarhammer Auto
LeveledItem Property DLC2LItemWeaponWarhammerTown Auto
LeveledItem Property DLC2LItemWeaponWarhammer Auto
LeveledItem Property LItemWeaponWarhammerSpecial Auto
LeveledItem Property LItemOrcStrongholdWarhammer Auto
LeveledItem Property LItemWeaponWarhammerBlacksmith Auto
LeveledItem Property LItemWeaponWarhammerBest Auto
LeveledItem Property LItemBanditBossWarhammer Auto
LeveledItem Property DLC2LItemWeaponWarhammerDremora Auto

float Property StoredModVersion = 0.0 Auto
float Property StoredImmersiveWeaponsVersion = 0.0 Auto
float Property StoredBaseLeveledListsVersion = 0.0 Auto
float Property StoredValdacilsItemSortingVersion = 0.0 Auto

string ImmersiveWeapons = "Immersive Weapons.esp"
string ValdacilsItemSorting = "ValdacilsItemSorting.esp"
string UpdateText = "Barstool Brawler Updated to "
string LogPrefix = "[MEKBB] "

Event OnInit()
    RegisterForSingleUpdate(1.0)
EndEvent

Event OnPlayerLoadGame()
    RegisterForSingleUpdate(1.0)
EndEvent

Event OnUpdate()
    bool updated = false
    If (StoredModVersion < 1.0)
        Maintenance()
        StoredModVersion = 1.0
        Debug.Notification(UpdateText + "1.0")
        updated = true
    EndIf
    If (StoredModVersion < 1.1)
        Maintenance()
        StoredModVersion = 1.1
        Debug.Notification(UpdateText + "1.1")
        updated = true
    EndIf
    If (!updated)
        Maintenance()
    EndIf
EndEvent

Function TraceLog(string logEntry)
    Debug.Trace(LogPrefix + logEntry)
EndFunction

Function Maintenance()
    TraceLog("=================Maintenance Start=================")
    UpdateBaseLeveledLists1_0()
    UpdateImmersvieWeapons1_0()
    UpdateValdacilsItemSorting1_0()
    UpdateImmersvieWeapons1_1()
    TraceLog("=================Maintenance End===================")
EndFunction

Function UpdateItemList(LeveledItem itemList, Form addItem, int itemLevel, int itemCount, int repeat = 1)
    int index = 0
    ; Try adding the item to Leveled Item List repeat number of times
    While (index < repeat)
        ; Leveled Lists can only have a max of 255 items, so skip if the list is full
        If (itemList.GetNumForms() == 255)
            ; break out of repeat loop
            index = repeat
            TraceLog("Skipping adding '" + addItem + "' to '" + itemList + "'. The list is full")
        Else
            TraceLog("Adding '" + addItem + "' Level '" + itemLevel + "' count '" + itemCount + "' to '" + itemList + "'")
            itemList.AddForm(addItem, itemLevel, itemCount)
        EndIf
        index += 1
    EndWhile
EndFunction

Function UpdateRemoteItemList(string ModName, int FormID, Form addItem, int itemLevel, int itemCount, int repeat = 1)
    Form listForm = Game.GetFormFromFile(FormID, ModName)
    If (listForm == None)
        TraceLog("Unable to find FormID '" + FormID + "' from '" + ModName + "' Skipping adding '" + addItem + "'" )
        Return
    EndIf
    UpdateItemList(listForm as LeveledItem, addItem, itemLevel, itemCount, repeat)
EndFunction

Function RenameWeaponValdacilsItemSorting(Weapon WeaponToRename)
    string prefix = "[2H Blunt] "
    string oldName = WeaponToRename.GetName()
    If (StringUtil.Find(oldName, prefix) != -1)
        TraceLog("'" + oldName + "' is already correct on '" + WeaponToRename + "'")
        Return
    EndIf
    string newName = prefix + oldName
    TraceLog("Renaming '" + oldName + "' to '" + newName + "' on '" + WeaponToRename + "'")
    WeaponToRename.SetName(newName)
EndFunction

Function UpdateBaseLeveledLists1_0()
    If (StoredBaseLeveledListsVersion < 1.0)
        StoredBaseLeveledListsVersion = 1.0
    Else
        Return
    EndIf
    TraceLog("==========Updating Base Game Leveled Lists=========")
    UpdateItemList(LItemWeaponDwarvenWarhammer, MEKBBBarstool, 3, 1, 1)
    UpdateItemList(LItemWeaponDwarvenWarhammer, MEKBBBarstool, 4, 1, 1)
    UpdateItemList(LItemWeaponDwarvenWarhammer, MEKBBBarstool, 5, 1, 1)
    UpdateItemList(LItemWeaponDwarvenWarhammer, MEKBBBarstool, 6, 1, 1)
    
    UpdateItemList(LItemwerewolfBossWarhammer, MEKBBBarstool, 1, 1, 1)

    UpdateItemList(LItemSoldierSonsWarhammer, MEKBBBarstool, 4, 1, 1)
    UpdateItemList(LItemSoldierSonsWarhammer, MEKBBBarstool, 5, 1, 1)
    UpdateItemList(LItemSoldierSonsWarhammer, MEKBBBarstool, 6, 1, 1)
    UpdateItemList(LItemSoldierSonsWarhammer, MEKBBBarstool, 7, 1, 1)
    UpdateItemList(LItemSoldierSonsWarhammer, MEKBBBarstool, 10, 1, 1)
    UpdateItemList(LItemSoldierSonsWarhammer, MEKBBBarstool, 11, 1, 1)
    UpdateItemList(LItemSoldierSonsWarhammer, MEKBBBarstool, 12, 1, 1)
    UpdateItemList(LItemSoldierSonsWarhammer, MEKBBBarstool, 13, 1, 1)

    UpdateItemList(LItemWeaponWarhammerTown, MEKBBBarstool, 4, 1, 1)
    UpdateItemList(LItemWeaponWarhammerTown, MEKBBBarstool, 5, 1, 1)
    UpdateItemList(LItemWeaponWarhammerTown, MEKBBBarstool, 6, 1, 1)
    UpdateItemList(LItemWeaponWarhammerTown, MEKBBBarstool, 7, 1, 1)

    UpdateItemList(LItemWeaponWarhammer, MEKBBBarstool, 2, 1, 1)
    UpdateItemList(LItemWeaponWarhammer, MEKBBBarstool, 3, 1, 1)
    UpdateItemList(LItemWeaponWarhammer, MEKBBBarstool, 4, 1, 1)

    UpdateItemList(LItemBanditWarhammer, MEKBBBarstool, 1, 1, 1)
    UpdateItemList(LItemBanditWarhammer, MEKBBBarstool, 1, 1, 1)

    UpdateItemList(DLC2LItemWeaponWarhammerTown, MEKBBBarstool, 4, 1, 1)
    UpdateItemList(DLC2LItemWeaponWarhammerTown, MEKBBBarstool, 5, 1, 1)
    UpdateItemList(DLC2LItemWeaponWarhammerTown, MEKBBBarstool, 6, 1, 1)
    UpdateItemList(DLC2LItemWeaponWarhammerTown, MEKBBBarstool, 7, 1, 1)
    
    UpdateItemList(DLC2LItemWeaponWarhammer, MEKBBBarstool, 2, 1, 1)
    UpdateItemList(DLC2LItemWeaponWarhammer, MEKBBBarstool, 3, 1, 1)
    UpdateItemList(DLC2LItemWeaponWarhammer, MEKBBBarstool, 4, 1, 1)

    UpdateItemList(LItemWeaponWarhammerSpecial, MEKBBBarstool, 1, 1, 1)

    UpdateItemList(LItemOrcStrongholdWarhammer, MEKBBBarstool, 1, 1, 1)

    UpdateItemList(LItemWeaponWarhammerBlacksmith, MEKBBBarstool, 1, 1, 2)

    UpdateItemList(LItemWeaponWarhammerBest, MEKBBBarstool, 1, 1, 2)

    UpdateItemList(LItemBanditBossWarhammer, MEKBBBarstool, 1, 1, 1)

    UpdateItemList(DLC2LItemWeaponWarhammerDremora, MEKBBBarstool, 1, 1, 1)

    TraceLog("==========Base Game Leveled Lists Updated==========")
EndFunction

Function UpdateImmersvieWeapons1_0()
    If (Game.GetModByName(ImmersiveWeapons) == 255)
        Return
    EndIf
    If (StoredImmersiveWeaponsVersion < 1.0)
        StoredImmersiveWeaponsVersion = 1.0
    Else
        Return
    EndIf
    TraceLog("Immersive Weapons Detected. Updating leveled lists")

                                       int IWLIWeaponWarhammer = 0x0001CB26
    UpdateRemoteItemList(ImmersiveWeapons, IWLIWeaponWarhammer, MEKBBBarstool, 1, 1, 1)

                                       int IWLIBanditWarhammer = 0x0001D603
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBanditWarhammer, MEKBBBarstool, 1, 1, 1)

                                       int IWLISoldierSonsWeapon2H = 0x0001F0F6
    UpdateRemoteItemList(ImmersiveWeapons, IWLISoldierSonsWeapon2H, MEKBBBarstool, 1, 1, 1)

                                       int IWLITownWarhammer = 0x000365C4
    UpdateRemoteItemList(ImmersiveWeapons, IWLITownWarhammer, MEKBBBarstool, 2, 1, 1)

                                       int IWLI_ListWarhammer = 0x00039B9E
    UpdateRemoteItemList(ImmersiveWeapons, IWLISoldierSonsWeapon2H, MEKBBBarstool, 1, 1, 1)

                                       int IWLIBoss2H = 0x0003FCB7
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBoss2H, MEKBBBarstool, 1, 1, 1)

                                       int IWLIBlacksmithWarhammer = 0x00040CF6
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBlacksmithWarhammer, MEKBBBarstool, 1, 1, 1)

                                       int IWLIBestWarhammer = 0x00040CF7
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBestWarhammer, MEKBBBarstool, 1, 1, 1)

                                       Int IWLIDraugr2H = 0x000417C7
    UpdateRemoteItemList(ImmersiveWeapons, IWLIDraugr2H, MEKBBBarstool, 1, 1, 1)

    TraceLog("Immersive Weapons leveled lists updated.")
EndFunction

Function UpdateImmersvieWeapons1_1()
    If (Game.GetModByName(ImmersiveWeapons) == 255)
        Return
    EndIf
    If (StoredImmersiveWeaponsVersion < 1.1)
        StoredImmersiveWeaponsVersion = 1.1
    Else
        Return
    EndIf
                                       int IWLI_ListWarhammer = 0x00039B9E
    UpdateRemoteItemList(ImmersiveWeapons, IWLI_ListWarhammer, MEKBBBarstool, 1, 1, 1)
EndFunction

Function UpdateValdacilsItemSorting1_0()
    If (Game.GetModByName(ValdacilsItemSorting) == 255)
        Return
    EndIf
    If (StoredValdacilsItemSortingVersion < 1.0)
        StoredValdacilsItemSortingVersion = 1.0
    Else
        Return
    EndIf

    TraceLog("Valdacil's Item Sorting Detected. Updating Weapon Names")
    RenameWeaponValdacilsItemSorting(MEKBBBarstool)
    TraceLog("Valdacil's Item Sorting Names Set")
EndFunction

