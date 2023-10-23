/// <summary>
/// PageExtension Sales Order Ext (ID 50181) extends Record Sales Order.
/// </summary>
pageextension 50250 "Sales Order Ext" extends "Sales Order"
{
    actions
    {
        addafter("DocAttach")
        {
            action(Vessel)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Vessels';
                Image = Track;
                ToolTip = 'Open the page of Vessels';
                RunObject = page Vessel;
                RunPageLink = "Sales Order No." = field("No.");
            }

            action(AddToFleet)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Add To Fleet';
                Image = Track;
                ToolTip = 'Add Vessel to fleet';
                trigger OnAction()
                var
                    MarineTrafficAPI: Codeunit "Marine Traffic API";
                begin
                    MarineTrafficAPI.AddVesselToFleet(Rec);
                end;
            }
        }
    }
}
