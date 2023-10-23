/// <summary>
/// PageExtension PostCodeExt (ID 50252) extends Record Post Codes.
/// </summary>
pageextension 50252 PostCodeExt extends "Post Codes"
{
    layout
    {
        addafter(City)
        {
            field(Zone; Rec.Zone)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Zone field.';
            }
        }
    }
}
