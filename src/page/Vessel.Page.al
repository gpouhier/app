/// <summary>
/// Page "Vessel" (ID 50251).
/// </summary>
page 50251 Vessel
{
    ApplicationArea = All;
    Caption = 'Vessel';
    PageType = List;
    SourceTable = Vessel;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Acces is done"; Rec."Acces is done")
                {
                    ToolTip = 'Specifies the value of the Acces is done field.';
                }
                field("Successfully added to M.T"; Rec."Successfully added to M.T")
                {
                    ToolTip = 'Specifies the value of the Successfully added to M.T field.';
                    Editable = false;
                }
                field(Agents; Rec.Agents)
                {
                    ToolTip = 'Specifies the value of the Agents field.';
                }
                field(Breath; Rec.Breath)
                {
                    ToolTip = 'Specifies the value of the breath field.';
                }
                field(Comments; Rec.Comments)
                {
                    ToolTip = 'Specifies the value of the Comments field.';
                }
                field("Delivery Date"; Rec."Delivery Date")
                {
                    ToolTip = 'Specifies the value of the Delivery Date field.';
                }
                field(ETA; Rec.ETA)
                {
                    ToolTip = 'Specifies the value of the ETA field.';
                }
                field(ETB; Rec.ETB)
                {
                    ToolTip = 'Specifies the value of the ETB field.';
                }
                field(ETD; Rec.ETD)
                {
                    ToolTip = 'Specifies the value of the ETD field.';
                }
                field("IMO No."; Rec."IMO No.")
                {
                    ToolTip = 'Specifies the value of the IMO No. field.';
                }
                field("Invoice folder"; Rec."Invoice folder")
                {
                    ToolTip = 'Specifies the value of the Invoice folder field.';
                }
                field("Items Category"; Rec."Items Category")
                {
                    ToolTip = 'Specifies the value of the Items Category field.';
                }
                field(Port; Rec.Port)
                {
                    ToolTip = 'Specifies the value of the Port field.';
                }
                field(Zone; Rec.Zone)
                {
                    ToolTip = 'Specifies the value of the Zone field.';
                    Editable = false;
                }
                field(Vessel; Rec.Vessel)
                {
                    ToolTip = 'Specifies the value of the Vessel field.';
                }
                field("Sales Order No."; Rec."Sales Order No.")
                {
                    ToolTip = 'Specifies the value of the Sales Order No. field.';
                }
                field(NEXT_PORT_NAME; Rec.NEXT_PORT_NAME)
                {
                    ToolTip = 'Specifies the value of the NEXT_PORT_NAME field.';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(CallMarineTraffic)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Call Marine Traffic';
                Image = NewShipment;
                ToolTip = 'Call Marine Traffic';

                trigger OnAction()
                var
                    MarineTrafficAPI: Codeunit "Marine Traffic API";
                begin
                    MarineTrafficAPI.VesselPositionsofaDynamicFleet();
                end;
            }
            action(ArchiveVessel)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Archive Vessel';
                Image = Archive;
                ToolTip = 'Archive this Vessel';

                trigger OnAction()
                begin
                    Rec.ArchiveVessel();
                end;
            }
            action(OpenArchiveVessel)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Archives Vessels';
                Image = Archive;
                ToolTip = 'Open the page of Vessels archives';
                RunObject = Page VesselArchive;
            }
        }
    }
}
