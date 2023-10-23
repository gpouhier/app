permissionset 50250 "MarineTrafficPerm."
{
    Access = Internal;
    Assignable = true;
    Caption = 'All permissions', Locked = true;

    Permissions =
         table MarineTrafficSetup = X,
         tabledata MarineTrafficSetup = RIMD,
         table Vessel = X,
         tabledata Vessel = RIMD,
         table VesselArchive = X,
         tabledata VesselArchive = RIMD;
}