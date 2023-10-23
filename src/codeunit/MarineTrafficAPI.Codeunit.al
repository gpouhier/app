/// <summary>
/// Codeunit ExternalsFunctions (ID 50180).
/// </summary>
codeunit 50250 "Marine Traffic API"
{
    var
        _PU01: text;
        _EndPoint: Text;
        _PS03: Text;

    trigger OnRun() //Utiliser ce codeunit pour lancement via JobQueue
    begin
        VesselPositionsofaDynamicFleet();
    end;

    /// <summary>
    /// initUrl.
    /// </summary>
    procedure initUrl()
    begin
        _EndPoint := 'https://services.marinetraffic.com/api/';
        _PU01 := 'setfleet/';
        _PS03 := 'exportvessels/';
    end;

    /// <summary>
    /// CreateURIForPU01.
    /// </summary>
    /// <param name="IMOCode">text.</param>
    /// <param name="FleetID">Text, IsActive. If used, vessel will be added to the specific fleet, otherwise default fleet is used</param>
    /// <param name="IsActive">Text. 0 to set to inactive 1 to activate 2 to enable satellite coverage, if empty -> set to 1 by default</param>
    /// <param name="Delete">Integer. Set this parameter to 1 to delete a vessel from your fleet</param>
    /// <returns>Return value of type Text.</returns>
    procedure CreateURIForPU01(IMOCode: text; FleetID: Text; IsActive: Text; Delete: Integer) URI: Text
    var
        MarineTrafficSetupRecord: Record MarineTrafficSetup;
    begin
        //Verification de l'API_KEY
        MarineTrafficSetupRecord.Get();
        MarineTrafficSetupRecord.TestField(PU01_API_Key);

        if (IsActive = '') then
            IsActive := '1';

        URI := _EndPoint + _PU01 + MarineTrafficSetupRecord.PU01_API_Key;

        if (FleetID <> '') then
            URI += '?fleet_id=' + FleetID;

        URI += '&imo=' + IMOCode + '&active=' + IsActive;

        if (Delete = 1) then
            URI += '&delete=1'
    end;

    /// <summary>
    /// CreateURIForPS03.
    /// </summary>
    /// <returns>Return variable URI of type Text.</returns>
    procedure CreateURIForPS03() URI: Text
    var
        MarineTrafficSetupRecord: Record MarineTrafficSetup;
    begin
        //Verification de l'API_KEY
        MarineTrafficSetupRecord.Get();
        MarineTrafficSetupRecord.TestField(PS03_API_Key);

        URI := _EndPoint + _PS03 + MarineTrafficSetupRecord.PS03_API_Key + '?v=8&msgtype=full&protocol=jsono&timespan=5';
    end;

    /// <summary>
    /// VesselToFleet.
    /// </summary>
    /// <param name="IMOCode">text.</param>
    /// <param name="FleetID">Text, IsActive.</param>
    /// <param name="IsActive">Integer.</param>
    /// <param name="Delete">Integer.</param>
    procedure VesselToFleet(IMOCode: text; FleetID: Text; IsActive: Text; Delete: Integer)
    var
        Vessel: Record Vessel;
        clientHttpClient: HttpClient;
        contentHttpContent: HttpContent;
        headerHttpHeaders: HttpHeaders;
        responseHttpResponseMessage: HttpResponseMessage;
        Endpoint: Text;
    begin
        initUrl();

        EndPoint := CreateURIForPU01(IMOCode, FleetID, IsActive, Delete);

        contentHttpContent.GetHeaders(headerHttpHeaders);
        clientHttpClient.Post(Endpoint, contentHttpContent, responseHttpResponseMessage);
        if not responseHttpResponseMessage.IsSuccessStatusCode then
            Error('The web service returned an error message:\\' +
            'Status code: %1\' +
            'Description: %2',
            responseHttpResponseMessage.HttpStatusCode,
            responseHttpResponseMessage.ReasonPhrase);
        Vessel.SetRange("IMO No.", IMOCode);
        if Vessel.FindFirst() then begin
            Vessel."Successfully added to M.T" := true;
            Vessel.Modify();
        end;


    end;

    /// <summary>
    /// TextToDate.
    /// </summary>
    /// <param name="TxtDate">Date. Format of date : 2023-09-07T09:58:29 -> AAAA-MM-DDTHH:MM:SS</param>
    /// <returns>Return variable FormatedDate of type Date.</returns>
    procedure TextToDate(TxtDate: Text) FormatedDate: Date
    var
        Day: Integer;
        Month: Integer;
        Year: Integer;
    begin
        if TxtDate <> '' then begin
            evaluate(Day, copystr(TxtDate, 9, 2));
            evaluate(Month, copystr(TxtDate, 6, 2));
            evaluate(Year, copystr(TxtDate, 1, 4));
            FormatedDate := DMY2Date(Day, Month, Year);
        end else
            FormatedDate := 0D;
    end;

    /// <summary>
    /// VesselPositionsofaDynamicFleet.
    /// </summary>
    procedure VesselPositionsofaDynamicFleet()
    var
        clientHttpClient: HttpClient;
        contentHttpContent: HttpContent;
        headerHttpHeaders: HttpHeaders;
        responseHttpResponseMessage: HttpResponseMessage;
        Endpoint: Text;
        responseText: Text;
        JToken: JsonToken;
        JToken2: JsonToken;
        JArray: JsonArray;
        JObject: JsonObject;

        //Response without Key
        MMSI: Text;
        IMO: Text;
        SHIP_ID: Text;
        LAT: Text;
        LON: Text;
        SPEED: Text;
        HEADING: Text;
        COURSE: Text;
        STATUS: Text;
        TIMESTAMP: Text;
        DSRC: Text;
        UTC_SECONDS: Text;
        SHIPNAME: Text;
        SHIPTYPE: Text;
        CALLSIGN: Text;
        FLAG: Text;
        LENGTH: Text;
        WIDTH: Text;
        GRT: Text;
        DWT: Text;
        DRAUGHT: Text;
        YEAR_BUILT: Text;
        ROT: Text;
        TYPE_NAME: Text;
        AIS_TYPE_SUMMARY: Text;
        DESTINATION: Text;
        ETA: Text;
        CURRENT_PORT: Text;
        LAST_PORT: Text;
        LAST_PORT_TIME: Text;
        CURRENT_PORT_ID: Text;
        CURRENT_PORT_UNLOCODE: Text;
        CURRENT_PORT_COUNTRY: Text;
        LAST_PORT_ID: Text;
        LAST_PORT_UNLOCODE: Text;
        LAST_PORT_COUNTRY: Text;
        NEXT_PORT_ID: Text;
        NEXT_PORT_UNLOCODE: Text;
        NEXT_PORT_NAME: Text;
        NEXT_PORT_COUNTRY: Text;
        ETA_CALC: Text;
        ETA_UPDATED: Text;
        DISTANCE_TO_GO: Text;
        DISTANCE_TRAVELLED: Text;
        AVG_SPEED: Text;
        MAX_SPEED: Text;
    begin
        initUrl();

        EndPoint := CreateURIForPS03();

        contentHttpContent.GetHeaders(headerHttpHeaders);
        clientHttpClient.Post(Endpoint, contentHttpContent, responseHttpResponseMessage);
        if not responseHttpResponseMessage.IsSuccessStatusCode then
            Error('The web service returned an error message:\\' +
            'Status code: %1\' +
            'Description: %2',
            responseHttpResponseMessage.HttpStatusCode,
            responseHttpResponseMessage.ReasonPhrase);

        responseHttpResponseMessage.Content().ReadAs(responseText);
        JArray.ReadFrom(responseText);
        foreach JToken in JArray do begin
            JObject := JToken.AsObject();

            if JObject.Get('MMSI', JToken2) then
                MMSI := JToken2.AsValue().AsText();

            if JObject.Get('IMO', JToken2) then
                IMO := JToken2.AsValue().AsText();

            if JObject.Get('SHIP_ID', JToken2) then
                SHIP_ID := JToken2.AsValue().AsText();

            if JObject.Get('LAT', JToken2) then
                LAT := JToken2.AsValue().AsText();

            if JObject.Get('LON', JToken2) then
                LON := JToken2.AsValue().AsText();

            if JObject.Get('SPEED', JToken2) then
                SPEED := JToken2.AsValue().AsText();

            if JObject.Get('HEADING', JToken2) then
                HEADING := JToken2.AsValue().AsText();

            if JObject.Get('COURSE', JToken2) then
                COURSE := JToken2.AsValue().AsText();

            if JObject.Get('STATUS', JToken2) then
                STATUS := JToken2.AsValue().AsText();

            if JObject.Get('TIMESTAMP', JToken2) then
                TIMESTAMP := JToken2.AsValue().AsText();

            if JObject.Get('DSRC', JToken2) then
                DSRC := JToken2.AsValue().AsText();

            if JObject.Get('UTC_SECONDS', JToken2) then
                UTC_SECONDS := JToken2.AsValue().AsText();

            if JObject.Get('SHIPNAME', JToken2) then
                SHIPNAME := JToken2.AsValue().AsText();

            if JObject.Get('SHIPTYPE', JToken2) then
                SHIPTYPE := JToken2.AsValue().AsText();

            if JObject.Get('CALLSIGN', JToken2) then
                CALLSIGN := JToken2.AsValue().AsText();

            if JObject.Get('FLAG', JToken2) then
                FLAG := JToken2.AsValue().AsText();

            if JObject.Get('LENGTH', JToken2) then
                LENGTH := JToken2.AsValue().AsText();

            if JObject.Get('WIDTH', JToken2) then
                WIDTH := JToken2.AsValue().AsText();

            if JObject.Get('GRT', JToken2) then
                GRT := JToken2.AsValue().AsText();

            if JObject.Get('DWT', JToken2) then
                DWT := JToken2.AsValue().AsText();

            if JObject.Get('DRAUGHT', JToken2) then
                DRAUGHT := JToken2.AsValue().AsText();

            if JObject.Get('YEAR_BUILT', JToken2) then
                YEAR_BUILT := JToken2.AsValue().AsText();

            if JObject.Get('ROT', JToken2) then
                ROT := JToken2.AsValue().AsText();

            if JObject.Get('TYPE_NAME', JToken2) then
                TYPE_NAME := JToken2.AsValue().AsText();

            if JObject.Get('AIS_TYPE_SUMMARY', JToken2) then
                AIS_TYPE_SUMMARY := JToken2.AsValue().AsText();

            if JObject.Get('DESTINATION', JToken2) then
                DESTINATION := JToken2.AsValue().AsText();

            if JObject.Get('ETA', JToken2) then
                ETA := JToken2.AsValue().AsText();

            if JObject.Get('CURRENT_PORT', JToken2) then
                CURRENT_PORT := JToken2.AsValue().AsText();

            if JObject.Get('LAST_PORT', JToken2) then
                LAST_PORT := JToken2.AsValue().AsText();

            if JObject.Get('LAST_PORT_TIME', JToken2) then
                LAST_PORT_TIME := JToken2.AsValue().AsText();

            if JObject.Get('CURRENT_PORT_ID', JToken2) then
                CURRENT_PORT_ID := JToken2.AsValue().AsText();

            if JObject.Get('CURRENT_PORT_UNLOCODE', JToken2) then
                CURRENT_PORT_UNLOCODE := JToken2.AsValue().AsText();

            if JObject.Get('CURRENT_PORT_COUNTRY', JToken2) then
                CURRENT_PORT_COUNTRY := JToken2.AsValue().AsText();

            if JObject.Get('LAST_PORT_ID', JToken2) then
                LAST_PORT_ID := JToken2.AsValue().AsText();

            if JObject.Get('LAST_PORT_UNLOCODE', JToken2) then
                LAST_PORT_UNLOCODE := JToken2.AsValue().AsText();

            if JObject.Get('LAST_PORT_COUNTRY', JToken2) then
                LAST_PORT_COUNTRY := JToken2.AsValue().AsText();

            if JObject.Get('NEXT_PORT_ID', JToken2) then
                NEXT_PORT_ID := JToken2.AsValue().AsText();

            if JObject.Get('NEXT_PORT_UNLOCODE', JToken2) then
                NEXT_PORT_UNLOCODE := JToken2.AsValue().AsText();

            if JObject.Get('NEXT_PORT_NAME', JToken2) then
                NEXT_PORT_NAME := JToken2.AsValue().AsText();

            if JObject.Get('NEXT_PORT_COUNTRY', JToken2) then
                NEXT_PORT_COUNTRY := JToken2.AsValue().AsText();

            if JObject.Get('ETA_CALC', JToken2) then
                ETA_CALC := JToken2.AsValue().AsText();

            if JObject.Get('ETA_UPDATED', JToken2) then
                ETA_UPDATED := JToken2.AsValue().AsText();

            if JObject.Get('DISTANCE_TO_GO', JToken2) then
                DISTANCE_TO_GO := JToken2.AsValue().AsText();

            if JObject.Get('DISTANCE_TRAVELLED', JToken2) then
                DISTANCE_TRAVELLED := JToken2.AsValue().AsText();

            if JObject.Get('AVG_SPEED', JToken2) then
                AVG_SPEED := JToken2.AsValue().AsText();

            if JObject.Get('MAX_SPEED', JToken2) then
                MAX_SPEED := JToken2.AsValue().AsText();

            UpdateData(IMO, ETA, LAST_PORT_TIME);
            UpdateAPIData(MMSI, IMO, SHIP_ID, LAT, LON, SPEED, HEADING, COURSE, STATUS,
            TIMESTAMP, DSRC, UTC_SECONDS, SHIPNAME, SHIPTYPE, CALLSIGN, FLAG, LENGTH, WIDTH,
            GRT, DWT, DRAUGHT, YEAR_BUILT, ROT, TYPE_NAME, AIS_TYPE_SUMMARY, DESTINATION, ETA,
            CURRENT_PORT, LAST_PORT, LAST_PORT_TIME, CURRENT_PORT_ID, CURRENT_PORT_UNLOCODE, CURRENT_PORT_COUNTRY, LAST_PORT_ID,
            LAST_PORT_UNLOCODE, LAST_PORT_COUNTRY, NEXT_PORT_ID, NEXT_PORT_UNLOCODE, NEXT_PORT_NAME, NEXT_PORT_COUNTRY, ETA_CALC,
            ETA_UPDATED, DISTANCE_TO_GO, DISTANCE_TRAVELLED, AVG_SPEED, MAX_SPEED);
        end;

        /*
        -------- RESPONSE FORMAT ---------

        MMSI	
        string
        Maritime Mobile Service Identity - a nine-digit number sent in digital form over a radio frequency that identifies the vessel's transmitter station

        IMO	
        string
        International Maritime Organisation number - a seven-digit number that uniquely identifies vessels

        SHIP_ID	
        string
        A uniquely assigned ID by MarineTraffic for the subject vessel

        LAT	
        string
        Latitude - a geographic coordinate that specifies the north-south position of the vessel on the Earth's surface

        LON	
        string
        Longitude - a geographic coordinate that specifies the east-west position of the vessel on the Earth's surface

        SPEED	
        string
        The speed (in knots x10) that the subject vessel is reporting according to AIS transmissions

        HEADING	
        string
        The heading (in degrees) that the subject vessel is reporting according to AIS transmissions

        COURSE	
        string
        The course (in degrees) that the subject vessel is reporting according to AIS transmissions

        STATUS	
        string
        The AIS Navigational Status of the subject vessel as input by the vessel's crew. There might be discrepancies with the vessel's detail page when vessel speed is near zero (0) knots

        TIMESTAMP	
        string <date-time>
        The date and time (in UTC) that the subject vessel's position or event was recorded by MarineTraffic

        DSRC	
        string
        Data Source - Defines whether the transmitted AIS data was received by a Terrestrial or a Satellite AIS Station

        UTC_SECONDS	
        string
        The time slot that the subject vessel uses to transmit information

        SHIPNAME	
        string
        The Shipname of the subject vessel

        SHIPTYPE	
        string
        The Shiptype of the subject vessel according to AIS transmissions

        CALLSIGN	
        string
        A uniquely designated identifier for the vessel's transmitter station

        FLAG	
        string
        The flag of the subject vessel according to AIS transmissions

        LENGTH	
        string
        The overall Length (in metres) of the subject vessel

        WIDTH	
        string
        The Breadth (in metres) of the subject vessel

        GRT	
        string
        Gross Tonnage - unitless measure that calculates the moulded volume of all enclosed spaces of a ship

        DWT	
        string
        Deadweight - a measure (in metric tons) of how much weight a vessel can safely carry (excluding the vessel's own weight)

        DRAUGHT	
        string
        The Draught (in metres x10) of the subject vessel according to the AIS transmissions

        YEAR_BUILT	
        string
        The year that the subject vessel was built

        ROT	
        string
        Rate of Turn

        TYPE_NAME	
        string
        The Type of the subject vessel

        AIS_TYPE_SUMMARY	
        string
        Further explanation of the SHIPTYPE ID

        DESTINATION	
        string
        The Destination of the subject vessel according to the AIS transmissions

        ETA	
        string <date-time>
        The Estimated Time of Arrival to Destination of the subject vessel according to the AIS transmissions

        CURRENT_PORT	
        string
        The name of the Port the subject vessel is currently in (NULL if the vessel is underway)

        LAST_PORT	
        string
        The Name of the Last Port the vessel has visited

        LAST_PORT_TIME	
        string <date-time>
        The Date and Time (in UTC) that the subject vessel departed from the Last Port

        CURRENT_PORT_ID	
        string
        A uniquely assigned ID by MarineTraffic for the Current Port

        CURRENT_PORT_UNLOCODE	
        string
        A uniquely assigned ID by United Nations for the Current Port

        CURRENT_PORT_COUNTRY	
        string
        The Country that the Current Port is located at

        LAST_PORT_ID	
        string
        A uniquely assigned ID by MarineTraffic for the Last Port

        LAST_PORT_UNLOCODE	
        string
        A uniquely assigned ID by United Nations for the Last Port

        LAST_PORT_COUNTRY	
        string
        The Country that the Last Port is located at

        NEXT_PORT_ID	
        string
        A uniquely assigned ID by MarineTraffic for the Next Port

        NEXT_PORT_UNLOCODE	
        string
        A uniquely assigned ID by United Nations for the Next Port.

        NEXT_PORT_NAME	
        string
        The Name of the Next Port as derived by MarineTraffic based on the subject vessel's reported Destination

        NEXT_PORT_COUNTRY	
        string
        The Country that the Next Port is located at

        ETA_CALC	
        string <date-time>
        The Estimated Time of Arrival to Destination of the subject vessel according to the MarineTraffic calculations

        ETA_UPDATED	
        string <date-time>
        The date and time (in UTC) that the ETA was calculated by MarineTraffic

        DISTANCE_TO_GO	
        string
        The Remaining Distance (in NM) for the subject vessel to reach the reported Destination

        DISTANCE_TRAVELLED	
        string
        The Distance (in NM) that the subject vessel has travelled since departing from Last Port

        AVG_SPEED	
        string
        The average speed calculated for the subject vessel during the latest voyage (port to port)

        MAX_SPEED	
        string
        The maximum speed reported by the subject vessel during the latest voyage (port to port)

        */
    end;

    /// <summary>
    /// UpdateData.
    /// </summary>
    /// <param name="IMONo">Text.</param>
    /// <param name="ETA">Text.</param>
    /// <param name="ETD">Text.</param>
    procedure UpdateData(IMONo: Text; ETA: Text; ETD: Text)
    var
        Vessel: Record Vessel;
    begin
        Vessel.Reset();
        Vessel.SetRange("IMO No.", IMONo);
        if Vessel.FindSet() then
            repeat
                Vessel.ETA := TextToDate(ETA);
                Vessel.ETD := TextToDate(ETD);
                Vessel.Modify();
            until Vessel.Next() = 0;
    end;

    /// <summary>
    /// UpdateAPIData.
    /// </summary>
    /// <param name="MMSI">Text.</param>
    /// <param name="IMO">Text.</param>
    /// <param name="SHIP_ID">Text.</param>
    /// <param name="LAT">Text.</param>
    /// <param name="LON">Text.</param>
    /// <param name="SPEED">Text.</param>
    /// <param name="HEADING">Text.</param>
    /// <param name="COURSE">Text.</param>
    /// <param name="STATUS">Text.</param>
    /// <param name="TIMESTAMP">Text.</param>
    /// <param name="DSRC">Text.</param>
    /// <param name="UTC_SECONDS">Text.</param>
    /// <param name="SHIPNAME">Text.</param>
    /// <param name="SHIPTYPE">Text.</param>
    /// <param name="CALLSIGN">Text.</param>
    /// <param name="FLAG">Text.</param>
    /// <param name="LENGTH">Text.</param>
    /// <param name="WIDTH">Text.</param>
    /// <param name="GRT">Text.</param>
    /// <param name="DWT">Text.</param>
    /// <param name="DRAUGHT">Text.</param>
    /// <param name="YEAR_BUILT">Text.</param>
    /// <param name="ROT">Text.</param>
    /// <param name="TYPE_NAME">Text.</param>
    /// <param name="AIS_TYPE_SUMMARY">Text.</param>
    /// <param name="DESTINATION">Text.</param>
    /// <param name="_ETA">Text.</param>
    /// <param name="CURRENT_PORT">Text.</param>
    /// <param name="LAST_PORT">Text.</param>
    /// <param name="LAST_PORT_TIME">Text.</param>
    /// <param name="CURRENT_PORT_ID">Text.</param>
    /// <param name="CURRENT_PORT_UNLOCODE">Text.</param>
    /// <param name="CURRENT_PORT_COUNTRY">Text.</param>
    /// <param name="LAST_PORT_ID">Text.</param>
    /// <param name="LAST_PORT_UNLOCODE">Text.</param>
    /// <param name="LAST_PORT_COUNTRY">Text.</param>
    /// <param name="NEXT_PORT_ID">Text.</param>
    /// <param name="NEXT_PORT_UNLOCODE">Text.</param>
    /// <param name="NEXT_PORT_NAME">Text.</param>
    /// <param name="NEXT_PORT_COUNTRY">Text.</param>
    /// <param name="ETA_CALC">Text.</param>
    /// <param name="ETA_UPDATED">Text.</param>
    /// <param name="DISTANCE_TO_GO">Text.</param>
    /// <param name="DISTANCE_TRAVELLED">Text.</param>
    /// <param name="AVG_SPEED">Text.</param>
    /// <param name="MAX_SPEED">Text.</param>
    procedure UpdateAPIData(MMSI: Text[250]; IMO: Text[250]; SHIP_ID: Text[250]; LAT: Text[250]; LON: Text[250]; SPEED: Text[250]; HEADING: Text[250]; COURSE: Text[250]; STATUS: Text[250]; TIMESTAMP: Text[250]; DSRC: Text[250]; UTC_SECONDS: Text[250]; SHIPNAME: Text[250]; SHIPTYPE: Text[250]; CALLSIGN: Text[250]; FLAG: Text[250]; LENGTH: Text[250]; WIDTH: Text[250]; GRT: Text[250]; DWT: Text[250]; DRAUGHT: Text[250]; YEAR_BUILT: Text[250]; ROT: Text[250]; TYPE_NAME: Text[250]; AIS_TYPE_SUMMARY: Text[250]; DESTINATION: Text[250]; _ETA: Text[250]; CURRENT_PORT: Text[250]; LAST_PORT: Text[250]; LAST_PORT_TIME: Text[250]; CURRENT_PORT_ID: Text[250]; CURRENT_PORT_UNLOCODE: Text[250]; CURRENT_PORT_COUNTRY: Text[250]; LAST_PORT_ID: Text[250]; LAST_PORT_UNLOCODE: Text[250]; LAST_PORT_COUNTRY: Text[250]; NEXT_PORT_ID: Text[250]; NEXT_PORT_UNLOCODE: Text[250]; NEXT_PORT_NAME: Text[250]; NEXT_PORT_COUNTRY: Text[250]; ETA_CALC: Text[250]; ETA_UPDATED: Text[250]; DISTANCE_TO_GO: Text[250]; DISTANCE_TRAVELLED: Text[250]; AVG_SPEED: Text[250]; MAX_SPEED: Text[250])
    var
        Vessel: Record Vessel;
    begin
        Vessel.Reset();
        Vessel.SetRange("IMO No.", IMO);
        if Vessel.FindSet() then
            repeat
                Vessel."MMSI" := "MMSI";
                Vessel."IMO" := "IMO";
                Vessel."SHIP_ID" := "SHIP_ID";
                Vessel."LAT" := "LAT";
                Vessel."LON" := "LON";
                Vessel."SPEED" := "SPEED";
                Vessel."HEADING" := "HEADING";
                Vessel."COURSE" := "COURSE";
                Vessel."STATUS" := "STATUS";
                Vessel."_TIMESTAMP" := "TIMESTAMP";
                Vessel."DSRC" := "DSRC";
                Vessel."UTC_SECONDS" := "UTC_SECONDS";
                Vessel."SHIPNAME" := "SHIPNAME";
                Vessel."SHIPTYPE" := "SHIPTYPE";
                Vessel."CALLSIGN" := "CALLSIGN";
                Vessel."FLAG" := "FLAG";
                Vessel."LENGTH" := "LENGTH";
                Vessel."WIDTH" := "WIDTH";
                Vessel."GRT" := "GRT";
                Vessel."DWT" := "DWT";
                Vessel."DRAUGHT" := "DRAUGHT";
                Vessel."YEAR_BUILT" := "YEAR_BUILT";
                Vessel."ROT" := "ROT";
                Vessel."TYPE_NAME" := "TYPE_NAME";
                Vessel."AIS_TYPE_SUMMARY" := "AIS_TYPE_SUMMARY";
                Vessel."DESTINATION" := "DESTINATION";
                Vessel."_ETA" := "_ETA";
                Vessel."CURRENT_PORT" := "CURRENT_PORT";
                Vessel."LAST_PORT" := "LAST_PORT";
                Vessel."LAST_PORT_TIME" := "LAST_PORT_TIME";
                Vessel."CURRENT_PORT_ID" := "CURRENT_PORT_ID";
                Vessel."CURRENT_PORT_UNLOCODE" := "CURRENT_PORT_UNLOCODE";
                Vessel."CURRENT_PORT_COUNTRY" := "CURRENT_PORT_COUNTRY";
                Vessel."LAST_PORT_ID" := "LAST_PORT_ID";
                Vessel."LAST_PORT_UNLOCODE" := "LAST_PORT_UNLOCODE";
                Vessel."LAST_PORT_COUNTRY" := "LAST_PORT_COUNTRY";
                Vessel."NEXT_PORT_ID" := "NEXT_PORT_ID";
                Vessel."NEXT_PORT_UNLOCODE" := "NEXT_PORT_UNLOCODE";
                Vessel."NEXT_PORT_NAME" := "NEXT_PORT_NAME";
                Vessel."NEXT_PORT_COUNTRY" := "NEXT_PORT_COUNTRY";
                Vessel."ETA_CALC" := "ETA_CALC";
                Vessel."ETA_UPDATED" := "ETA_UPDATED";
                Vessel."DISTANCE_TO_GO" := "DISTANCE_TO_GO";
                Vessel."DISTANCE_TRAVELLED" := "DISTANCE_TRAVELLED";
                Vessel."AVG_SPEED" := "AVG_SPEED";
                Vessel."MAX_SPEED" := "MAX_SPEED";
                Vessel."Last UserID API Call" := UserId();
                Vessel."Last DateTime API Call" := CurrentDateTime();
                Vessel.Modify();
            until Vessel.Next() = 0;
    end;

    /// <summary>
    /// GetIMONo.
    /// </summary>
    /// <param name="IMONo">Text[50].</param>
    /// <returns>Return variable IMOCropped of type Text.</returns>
    procedure GetIMONo(IMONo: Text[50]) IMOCropped: Text
    begin
        if StrLen(IMONo) >= 4 then
            IMOCropped := CopyStr(IMONo, 5, StrLen(IMONo) - 4);
    end;

    /// <summary>
    /// IsVessel.
    /// </summary>
    /// <param name="SalesHeader">VAR record "Sales Header".</param>
    /// <returns>Return variable isVessel of type Boolean.</returns>
    procedure IsVessel(var SalesHeader: record "Sales Header") isVessel: Boolean
    begin
        isVessel := false;
        if CopyStr(SalesHeader."Sell-to Address 2", 1, 4) = 'IMO ' then
            isVessel := true;
    end;

    /// <summary>
    /// AddVesselToFleet.
    /// </summary>
    /// <param name="SalesHeader">VAR Record "Sales Header".</param>
    procedure AddVesselToFleet(var SalesHeader: Record "Sales Header")
    var
        VesselRecord: Record Vessel;
        MarineTrafficSetup: Record MarineTrafficSetup;
        MarineTrafficAPI: Codeunit "Marine Traffic API";
        ConfirmLbl: Label 'Vessel (IMO %1) correctly added to fleet.', Comment = 'IMO No', Locked = true;
        AlreadyExistLbl: Label 'This Vessel already exist in your fleet';
        IMONo: Text;
    begin
        IMONo := GetIMONo(SalesHeader."Sell-to Address 2");

        if not VesselRecord.Get(SalesHeader."Sell-to Customer Name", SalesHeader."Ship-to City") then begin
            VesselRecord.Init();
            VesselRecord.Validate(Vessel, SalesHeader."Sell-to Customer Name");
            VesselRecord.Validate(Port, SalesHeader."Ship-to City");
            VesselRecord.Validate("IMO No.", IMONo);
            VesselRecord.Validate("Delivery Date", SalesHeader."Promised Delivery Date");
            VesselRecord.Validate("Sales Order No.", SalesHeader."No.");
            VesselRecord.Insert(true);
            Commit();
            if IsVessel(SalesHeader) and (IMONo <> '') then begin
                MarineTrafficSetup.Get();
                MarineTrafficAPI.VesselToFleet(IMONo, MarineTrafficSetup.FleetID, '1', 0);
                Message(ConfirmLbl, IMONo);
            end;
        end else
            Message(AlreadyExistLbl);
    end;
}