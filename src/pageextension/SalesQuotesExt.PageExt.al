/// <summary>
/// PageExtension SalesQuotesExt (ID 50255) extends Record Sales Quotes.
/// </summary>
pageextension 50255 SalesQuotesExt extends "Sales Quotes"
{
    actions
    {
        addafter("&Quote")
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
