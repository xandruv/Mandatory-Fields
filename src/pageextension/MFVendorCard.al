pageextension 50401 MFVendorCard extends "Vendor Card"
{

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        MFFieldsControl: Codeunit MFFieldsControl;
        recRef: RecordRef;
    begin
        MFFieldsControl.ControlFields(rec.RecordId.TableNo, Rec."No.");
    end;
}
