pageextension 50401 MFVendorCard extends "Vendor Card"
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
