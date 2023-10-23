/// <summary>
/// Table VesselArchive (ID 50253).
/// </summary>
table 50253 "VesselArchive"
{
    Caption = 'Vessel Archive';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Vessel; Text[100])
        {
            Caption = 'Vessel';
            DataClassification = ToBeClassified;
        }
        field(2; Port; Text[30])
        {
            Caption = 'Port';
            DataClassification = ToBeClassified;
        }
        field(3; "IMO No."; Text[100])
        {
            Caption = 'IMO No.';
            DataClassification = ToBeClassified;
        }
        field(4; ETD; Date)
        {
            Caption = 'ETD';
            DataClassification = ToBeClassified;
        }
        field(5; ETA; Date)
        {
            Caption = 'ETA';
            DataClassification = ToBeClassified;
        }
        field(6; ETB; Date)
        {
            Caption = 'ETB';
            DataClassification = ToBeClassified;
        }
        field(7; "Items Category"; Code[250])
        {
            Caption = 'Items Category';
            DataClassification = ToBeClassified;
        }
        field(8; Comments; Text[250])
        {
            Caption = 'Comments';
            DataClassification = ToBeClassified;
        }
        field(9; "Delivery Date"; Date)
        {
            Caption = 'Delivery Date';
            DataClassification = ToBeClassified;
        }
        field(10; "Acces is done"; Boolean)
        {
            Caption = 'Acces is done';
            DataClassification = ToBeClassified;
        }
        field(11; "Invoice folder"; Boolean)
        {
            Caption = 'Invoice folder';
            DataClassification = ToBeClassified;
        }
        field(12; "Sales Order No."; Code[20])
        {
            Caption = 'Sales order No.';
            DataClassification = ToBeClassified;
        }

        //------- DATA FROM API ----------
        field(13; "Last UserID API Call"; Text[250])
        {
            Caption = 'Last UserID API Call';
            DataClassification = ToBeClassified;
        }

        field(14; "Last DateTime API Call"; DateTime)
        {
            Caption = 'Last DateTime API Call';
            DataClassification = ToBeClassified;
        }
        field(15; "Agents"; Text[250])
        {
            Caption = 'Agents'; //Commande
            DataClassification = ToBeClassified;
        }
        field(16; "Breath"; Text[250])
        {
            Caption = 'Breath'; //Commande
            DataClassification = ToBeClassified;
        }
        field(17; "Successfully added to M.T"; Boolean)
        {
            Caption = 'Successfully added to Marine Traffic';
            DataClassification = ToBeClassified;
        }
        field(18; "Zone"; Code[20])
        {
            Caption = 'Zone';
            FieldClass = FlowField;
            CalcFormula = lookup("Post Code".Zone where(City = field(Port)));
        }
        field(100; "MMSI"; Text[250])
        {
            Caption = 'Data From Marine Traffic PS03 API';
            DataClassification = ToBeClassified;
        }
        field(101; "IMO"; Text[250])
        {
            Caption = 'Data From Marine Traffic PS03 API';
            DataClassification = ToBeClassified;
        }
        field(102; "SHIP_ID"; Text[250])
        {
            Caption = 'Data From Marine Traffic PS03 API';
            DataClassification = ToBeClassified;
        }
        field(103; "LAT"; Text[250])
        {
            Caption = 'Data From Marine Traffic PS03 API';
            DataClassification = ToBeClassified;
        }
        field(104; "LON"; Text[250])
        {
            Caption = 'Data From Marine Traffic PS03 API';
            DataClassification = ToBeClassified;
        }
        field(105; "SPEED"; Text[250])
        {
            Caption = 'Data From Marine Traffic PS03 API';
            DataClassification = ToBeClassified;
        }
        field(106; "HEADING"; Text[250])
        {
            Caption = 'Data From Marine Traffic PS03 API';
            DataClassification = ToBeClassified;
        }
        field(107; "COURSE"; Text[250])
        {
            Caption = 'Data From Marine Traffic PS03 API';
            DataClassification = ToBeClassified;
        }
        field(108; "STATUS"; Text[250])
        {
            Caption = 'Data From Marine Traffic PS03 API';
            DataClassification = ToBeClassified;
        }
        field(109; "_TIMESTAMP"; Text[250])
        {
            Caption = 'Data From Marine Traffic PS03 API';
            DataClassification = ToBeClassified;
        }
        field(110; "DSRC"; Text[250])
        {
            Caption = 'Data From Marine Traffic PS03 API';
            DataClassification = ToBeClassified;
        }
        field(111; "UTC_SECONDS"; Text[250])
        {
            Caption = 'Data From Marine Traffic PS03 API';
            DataClassification = ToBeClassified;
        }
        field(112; "SHIPNAME"; Text[250])
        {
            Caption = 'Data From Marine Traffic PS03 API';
            DataClassification = ToBeClassified;
        }
        field(113; "SHIPTYPE"; Text[250])
        {
            Caption = 'Data From Marine Traffic PS03 API';
            DataClassification = ToBeClassified;
        }
        field(114; "CALLSIGN"; Text[250])
        {
            Caption = 'Data From Marine Traffic PS03 API';
            DataClassification = ToBeClassified;
        }
        field(115; "FLAG"; Text[250])
        {
            Caption = 'Data From Marine Traffic PS03 API';
            DataClassification = ToBeClassified;
        }
        field(116; "LENGTH"; Text[250])
        {
            Caption = 'Data From Marine Traffic PS03 API';
            DataClassification = ToBeClassified;
        }
        field(117; "WIDTH"; Text[250])
        {
            Caption = 'Data From Marine Traffic PS03 API';
            DataClassification = ToBeClassified;
        }
        field(118; "GRT"; Text[250])
        {
            Caption = 'Data From Marine Traffic PS03 API';
            DataClassification = ToBeClassified;
        }
        field(119; "DWT"; Text[250])
        {
            Caption = 'Data From Marine Traffic PS03 API';
            DataClassification = ToBeClassified;
        }
        field(120; "DRAUGHT"; Text[250])
        {
            Caption = 'Data From Marine Traffic PS03 API';
            DataClassification = ToBeClassified;
        }
        field(121; "YEAR_BUILT"; Text[250])
        {
            Caption = 'Data From Marine Traffic PS03 API';
            DataClassification = ToBeClassified;
        }
        field(122; "ROT"; Text[250])
        {
            Caption = 'Data From Marine Traffic PS03 API';
            DataClassification = ToBeClassified;
        }
        field(123; "TYPE_NAME"; Text[250])
        {
            Caption = 'Data From Marine Traffic PS03 API';
            DataClassification = ToBeClassified;
        }
        field(124; "AIS_TYPE_SUMMARY"; Text[250])
        {
            Caption = 'Data From Marine Traffic PS03 API';
            DataClassification = ToBeClassified;
        }
        field(125; "DESTINATION"; Text[250])
        {
            Caption = 'Data From Marine Traffic PS03 API';
            DataClassification = ToBeClassified;
        }
        field(126; "_ETA"; Text[250])
        {
            Caption = 'Data From Marine Traffic PS03 API';
            DataClassification = ToBeClassified;
        }
        field(127; "CURRENT_PORT"; Text[250])
        {
            Caption = 'Data From Marine Traffic PS03 API';
            DataClassification = ToBeClassified;
        }
        field(128; "LAST_PORT"; Text[250])
        {
            Caption = 'Data From Marine Traffic PS03 API';
            DataClassification = ToBeClassified;
        }
        field(129; "LAST_PORT_TIME"; Text[250])
        {
            Caption = 'Data From Marine Traffic PS03 API';
            DataClassification = ToBeClassified;
        }
        field(130; "CURRENT_PORT_ID"; Text[250])
        {
            Caption = 'Data From Marine Traffic PS03 API';
            DataClassification = ToBeClassified;
        }
        field(131; "CURRENT_PORT_UNLOCODE"; Text[250])
        {
            Caption = 'Data From Marine Traffic PS03 API';
            DataClassification = ToBeClassified;
        }
        field(132; "CURRENT_PORT_COUNTRY"; Text[250])
        {
            Caption = 'Data From Marine Traffic PS03 API';
            DataClassification = ToBeClassified;
        }
        field(133; "LAST_PORT_ID"; Text[250])
        {
            Caption = 'Data From Marine Traffic PS03 API';
            DataClassification = ToBeClassified;
        }
        field(134; "LAST_PORT_UNLOCODE"; Text[250])
        {
            Caption = 'Data From Marine Traffic PS03 API';
            DataClassification = ToBeClassified;
        }
        field(135; "LAST_PORT_COUNTRY"; Text[250])
        {
            Caption = 'Data From Marine Traffic PS03 API';
            DataClassification = ToBeClassified;
        }
        field(136; "NEXT_PORT_ID"; Text[250])
        {
            Caption = 'Data From Marine Traffic PS03 API';
            DataClassification = ToBeClassified;
        }
        field(137; "NEXT_PORT_UNLOCODE"; Text[250])
        {
            Caption = 'Data From Marine Traffic PS03 API';
            DataClassification = ToBeClassified;
        }
        field(138; "NEXT_PORT_NAME"; Text[250])
        {
            Caption = 'Data From Marine Traffic PS03 API';
            DataClassification = ToBeClassified;
        }
        field(139; "NEXT_PORT_COUNTRY"; Text[250])
        {
            Caption = 'Data From Marine Traffic PS03 API';
            DataClassification = ToBeClassified;
        }
        field(140; "ETA_CALC"; Text[250])
        {
            Caption = 'Data From Marine Traffic PS03 API';
            DataClassification = ToBeClassified;
        }
        field(141; "ETA_UPDATED"; Text[250])
        {
            Caption = 'Data From Marine Traffic PS03 API';
            DataClassification = ToBeClassified;
        }
        field(142; "DISTANCE_TO_GO"; Text[250])
        {
            Caption = 'Data From Marine Traffic PS03 API';
            DataClassification = ToBeClassified;
        }
        field(143; "DISTANCE_TRAVELLED"; Text[250])
        {
            Caption = 'Data From Marine Traffic PS03 API';
            DataClassification = ToBeClassified;
        }
        field(144; "AVG_SPEED"; Text[250])
        {
            Caption = 'Data From Marine Traffic PS03 API';
            DataClassification = ToBeClassified;
        }
        field(145; "MAX_SPEED"; Text[250])
        {
            Caption = 'Data From Marine Traffic PS03 API';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; Vessel, Port)
        {
            Clustered = true;
        }
    }

    /// <summary>
    /// RestoreVessel.
    /// </summary>
    procedure RestoreVessel()
    var
        VesselRecord: Record Vessel;
        MarineTrafficSetup: Record MarineTrafficSetup;
        MarineTrafficAPI: Codeunit "Marine Traffic API";
        ConfirmLbl: Label 'Vessel (IMO %1) correctly added to fleet.', Comment = 'IMO No', Locked = true;
    begin
        if not VesselRecord.Get(Rec.Vessel, Rec.Port) then begin
            VesselRecord.Init();
            VesselRecord.TransferFields(Rec, true);
            if VesselRecord.Insert(true) then begin
                MarineTrafficAPI.VesselToFleet(Rec."IMO No.", MarineTrafficSetup.FleetID, '1', 0);
                Rec.Delete(true);
                Message(ConfirmLbl, Rec."IMO No.");
            end;
        end;
    end;
}
