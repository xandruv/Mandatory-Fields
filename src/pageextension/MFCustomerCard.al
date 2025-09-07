pageextension 50400 MFCustomerCard extends "Customer Card"
{

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        MFFieldsControl: Codeunit MFFieldsControl;
        recRef: RecordRef;
    begin
        MFFieldsControl.ControlFields(rec.RecordId.TableNo, Rec."No.");
    end;
}
