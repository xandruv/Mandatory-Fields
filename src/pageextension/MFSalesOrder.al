pageextension 50403 MFSalesOrder extends "Sales Order"
{
    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        MFFieldsControl: Codeunit MFFieldsControl;
        recRef: RecordRef;
        salesline: Record "Sales Line";
        lineErrors: Record "Error Message" temporary;
    begin
        //Control for Header
        recRef.Get(Rec.RecordId);
        MFFieldsControl.ControlFields(recRef);
        salesline.Reset();
        salesline.SetRange("Document Type", Rec."Document Type");
        salesline.SetRange("Document No.", Rec."No.");
        if salesline.FindSet() then
            repeat
                //Control for each line
                recRef.Get(salesline.RecordId);
                MFFieldsControl.ControlFieldsLines(recRef, lineErrors);
            until salesline.Next() = 0;
        if lineErrors.Count > 0 then
            Page.RunModal(Page::"Error Messages Part", lineErrors)
    end;
}
