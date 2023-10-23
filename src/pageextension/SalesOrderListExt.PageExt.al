/// <summary>
/// PageExtension Sales Order Ext (ID 50181) extends Record Sales Order.
/// </summary>
pageextension 50251 "Sales Order List Ext" extends "Sales Order List"
{
    actions
    {
        addafter("Prepayment Credi&t Memos")
        {
            action(Vessel)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Vessels';
                Image = Track;
                ToolTip = 'Open the page of Vessels';
                trigger OnAction()
                var
                    VesselRecord: Record Vessel;
                    Vesselpage: Page Vessel;
                begin
                    VesselRecord.Reset();
                    VesselRecord.SetRange("Sales Order No.", Rec."No.");
                    VesselRecord.SetRecFilter();
                    Vesselpage.SetTableView(VesselRecord);
                    Vesselpage.Run();
                end;
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
