/// <summary>
/// Codeunit "MarineTrafficSubscription" (ID 50251).
/// </summary>
codeunit 50251 MarineTrafficSubscription
{
    //Mapping 
    //79 Sell-to Customer Name <------> 1 Vessel
    //17 Ship-to City <------> 2 Port
    //81 Sell-to Address <------> 3 IMO No.
    //8 Delivery Date <------> 8 Delivery Date
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnAfterManualReleaseSalesDoc', '', false, false)]
    local procedure ReleaseSalesDocument_OnAfterManualReleaseSalesDoc(var SalesHeader: Record "Sales Header")
    var
        MarineTrafficAPI: Codeunit "Marine Traffic API";
    begin
        MarineTrafficAPI.AddVesselToFleet(SalesHeader);
    end;

    /// <summary>
    /// UpdateItemCategory.
    /// </summary>
    /// <param name="SalesHeader">VAR Record "Sales Header".</param>
    /// <returns>Return variable ItemCategoryText of type Code[250].</returns>
    procedure UpdateItemCategory(var SalesHeader: Record "Sales Header") ItemCategoryText: Code[250];
    var
        SalesLineRecord: Record "Sales Line";
        TempItemCategoryRecord: Record "Item Category" temporary;
    begin
        //Fill Items Category field
        SalesLineRecord.Reset();
        SalesLineRecord.SetRange("Document Type", SalesHeader."Document Type");
        SalesLineRecord.SetRange("Document No.", SalesHeader."No.");
        if SalesLineRecord.FindSet() then begin
            repeat
                if not TempItemCategoryRecord.Get(SalesLineRecord."Item Category Code") then begin
                    TempItemCategoryRecord.Init();
                    TempItemCategoryRecord.Validate(Code, SalesLineRecord."Item Category Code");
                    TempItemCategoryRecord.Insert();
                end;
            until SalesLineRecord.Next() = 0;
            if TempItemCategoryRecord.FindSet() then
                repeat
                    ItemCategoryText += TempItemCategoryRecord.Code;
                until TempItemCategoryRecord.Next() = 0;
        end;
    end;
}
