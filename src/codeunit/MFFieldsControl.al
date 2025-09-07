codeunit 50400 MFFieldsControl
{


    /// <summary>
    /// ControlFields
    /// </summary>
    /// <param name="tableID"></param>
    /// <param name="recordID"></param>
    procedure ControlFields(tableID: Integer; recordID: code[20])
    var
        MFTableFieldSetup: Record MFTableFieldSetup;
        recRef: RecordRef;
        fieldRef: FieldRef;
        keyRef: KeyRef;
        isHandled: Boolean;
        errors: Record "Error Message" temporary;
    begin
        OnBeforeControlFields(isHandled, tableID, recordID);
        if isHandled then
            exit;
        MFTableFieldSetup.Reset();
        MFTableFieldSetup.SetRange(TableNo, tableID);
        recRef.Open(tableID);
        keyRef := recRef.KeyIndex(1); //Gets PrimaryKey index
        fieldRef := keyRef.FieldIndex(1); //Gets PrimaryKey field
        fieldRef.Value := recordID;
        if recRef.Find('=') then begin
            if MFTableFieldSetup.FindSet() then
                repeat
                    fieldRef := recRef.Field(MFTableFieldSetup.FieldNo);
                    if not CheckFieldsAndCollectErrors(fieldRef, recRef) then begin
                        errors.ID += 1;
                        errors.Message := GetLastErrorText;
                        errors."Table Number" := tableID;
                        errors."Field Number" := fieldRef.Number;
                        errors.Insert()
                    end;
                until MFTableFieldSetup.Next() = 0;
        end;
        if errors.Count > 0 then
            Page.RunModal(Page::"Error Messages Part", errors)
    end;

    /// <summary>
    /// CheckFieldsAndCollectErrors
    /// </summary>
    /// <param name="fieldRef"></param>
    /// <param name="recRef"></param>
    /// <returns></returns>
    [TryFunction]
    local procedure CheckFieldsAndCollectErrors(var fieldRef: FieldRef; var recRef: RecordRef)
    var
        lbl001: Label 'Field %1 can not be empty', Comment = 'ESP="El campo %1 no puede estar vacío"';
    begin
        if Format(fieldRef.Value) = '' then begin
            Error(lbl001, fieldRef.Caption);
        end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeControlFields(var isHandled: Boolean; var tableID: Integer; var recordID: code[20])
    begin

    end;

}
