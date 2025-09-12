pageextension 50403 SalesOrder extends "Sales Order"
{
    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        MFFieldsControl: Codeunit MFFieldsControl;
        recRef: RecordRef;
    begin
        recRef.Get(Rec.RecordId);
        MFFieldsControl.ControlFields(recRef);
    end;
}
