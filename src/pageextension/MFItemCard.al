pageextension 50402 MFItemCard extends "Item Card"
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
