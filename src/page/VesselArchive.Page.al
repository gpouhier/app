/// <summary>
/// Page VesselArchive (ID 50252).
/// </summary>
page 50252 "VesselArchive"
{
    ApplicationArea = All;
    Caption = 'Vessel Archive';
    PageType = List;
    SourceTable = VesselArchive;
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
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(RestoreVessel)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Restore Vessel';
                Image = Restore;
                ToolTip = 'Restore this Vessel';

                trigger OnAction()
                begin
                    Rec.RestoreVessel();
                end;
            }
        }
    }
}
