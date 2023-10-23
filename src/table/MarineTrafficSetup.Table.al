/// <summary>
/// Table "MarineTrafficSetup" (ID 50251).
/// </summary>
table 50251 MarineTrafficSetup
{
    Caption = 'MarineTrafficSetup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
        }
        field(2; PU01_API_Key; Text[250])
        {
            Caption = 'PU01 API_Key';
            DataClassification = ToBeClassified;
        }
        field(3; PS03_API_Key; Text[250])
        {
            Caption = 'PS03 API_Key';
            DataClassification = ToBeClassified;
        }
        field(4; DeltaDaysToCalc; Text[20])
        {
            Caption = 'Delta Days To Calc';
            DataClassification = ToBeClassified;
        }
        field(5; CreditConsumed; Integer)
        {
            Caption = 'Credit Consumed';
            DataClassification = ToBeClassified;
        }
        field(6; FleetID; Code[20])
        {
            caption = 'Fleet ID';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
