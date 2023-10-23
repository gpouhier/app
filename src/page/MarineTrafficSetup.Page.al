/// <summary>
/// Page MarineTrafficSetup (ID 50250).
/// </summary>
page 50250 "MarineTrafficSetup"
{
    ApplicationArea = All;
    Caption = 'MarineTrafficSetup';
    PageType = Card;
    SourceTable = MarineTrafficSetup;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field(PU01_API_Key; Rec.PU01_API_Key)
                {
                    ToolTip = 'Specifies the value of the PU01 API_Key field.';
                }
                field(PS03_API_Key; Rec.PS03_API_Key)
                {
                    ToolTip = 'Specifies the value of the PS03 API_Key field.';
                }
                field(FleetID; Rec.FleetID)
                {
                    ToolTip = 'Specifies the value of Fleet ID field';
                }
                /*field(DeltaDaysToCalc; Rec.DeltaDaysToCalc)
                {
                    ToolTip = 'Specifies the value of the DeltaDaysToCalc field.';
                }
                field(CreditConsumed; Rec.CreditConsumed)
                {
                    ToolTip = 'Specifies the value of the current consumed credit.';
                }*/
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ClearCredits)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Clear Credits';
                Image = ClearLog;
                ToolTip = 'Clear Credits';

                trigger OnAction()
                var

                begin
                    if Confirm('Do you want to clear the credit counter ?') then begin
                        Rec.CreditConsumed := 0;
                        Rec.Modify(true);
                    end;
                end;
            }
        }
    }
}
