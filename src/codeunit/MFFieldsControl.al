codeunit 50400 MFFieldsControl
{
    /// <summary>
    /// ControlFields
    /// </summary>
    /// <param name="tableID"></param>
    /// <param name="recordCode"></param>
    procedure ControlFields(var recRef: RecordRef)
    var
        MFTableFieldSetup: Record MFTableFieldSetup;
        fieldRef: FieldRef;
        isHandled: Boolean;
        errors: Record "Error Message" temporary;
    begin
        OnBeforeControlFields(isHandled, recRef);
        if isHandled then
            exit;
        MFTableFieldSetup.Reset();
        MFTableFieldSetup.SetRange(TableNo, recRef.Number);
        if MFTableFieldSetup.FindSet() then
            repeat
                fieldRef := recRef.Field(MFTableFieldSetup.FieldNo);
                if not CheckFieldsAndCollectErrors(fieldRef, recRef) then begin
                    errors.ID += 1;
                    errors.Message := GetLastErrorText;
                    errors."Table Number" := recRef.Number;
                    errors."Field Number" := fieldRef.Number;
                    errors."Additional Information" := TranslateTableName(recRef, Format(recRef.RecordId));
                    errors.Insert()
                end;
            until MFTableFieldSetup.Next() = 0;
        if errors.Count > 0 then
            Page.RunModal(Page::"Error Messages Part", errors)
    end;

    /// <summary>
    /// ControlFieldsLines
    /// </summary>
    /// <param name="recRef"></param>
    /// <param name="errors"></param>
    procedure ControlFieldsLines(var recRef: RecordRef; var errors: Record "Error Message" temporary)
    var
        MFTableFieldSetup: Record MFTableFieldSetup;
        fieldRef: FieldRef;
        isHandled: Boolean;
    begin
        OnBeforeControlFieldsLines(isHandled, recRef);
        if isHandled then
            exit;
        MFTableFieldSetup.Reset();
        MFTableFieldSetup.SetRange(TableNo, recRef.Number);
        if MFTableFieldSetup.FindSet() then
            repeat
                fieldRef := recRef.Field(MFTableFieldSetup.FieldNo);
                if not CheckFieldsAndCollectErrors(fieldRef, recRef) then begin
                    errors.ID += 1;
                    errors.Message := GetLastErrorText;
                    errors."Table Number" := recRef.Number;
                    errors."Field Number" := fieldRef.Number;
                    errors."Additional Information" := TranslateTableName(recRef, Format(recRef.RecordId));
                    errors.Insert()
                end;
            until MFTableFieldSetup.Next() = 0;
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
        case fieldRef.Type of

            fieldRef.Type::Integer:
                begin
                    if Format(fieldRef.Value) = '0' then begin
                        Error(lbl001, fieldRef.Caption);
                    end;
                    exit;
                end;

            fieldRef.Type::Decimal:
                begin
                    if Format(fieldRef.Value) = '0' then begin
                        Error(lbl001, fieldRef.Caption);
                    end;

                    exit;
                end;
        end;

        if Format(fieldRef.Value) = '' then begin
            Error(lbl001, fieldRef.Caption);
        end;
    end;

    /// <summary>
    /// TranslateTableName
    /// </summary>
    /// <param name="recRef"></param>
    /// <param name="OriginalError"></param>
    /// <returns></returns>
    local procedure TranslateTableName(var recRef: RecordRef; OriginalError: Text) TranslatedError: Text
    begin
        //Delete the table name in english
        TranslatedError := DelChr(OriginalError, '<', recRef.Name);
        //Get the table caption
        TranslatedError := recRef.Caption + TranslatedError;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeControlFields(var isHandled: Boolean; var recRef: RecordRef)
    begin

    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeControlFieldsLines(var isHandled: Boolean; var recRef: RecordRef)
    begin

    end;

}
