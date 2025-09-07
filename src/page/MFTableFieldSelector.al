page 50402 MFTableFieldSelector
{
    ApplicationArea = All;
    Caption = 'Mandatory Fields Table Field Selector', Comment = 'ESP="Selector de campos"';
    ;
    PageType = List;
    SourceTable = "Field";
    UsageCategory = None;
    Editable = false;


    layout
    {

        area(Content)
        {
            repeater(General)
            {
                field(TableNo; Rec.TableNo)
                {
                    Visible = false;
                }
                field("No."; Rec."No.")
                {
                }
                field("Field Caption"; Rec."Field Caption")
                {
                }
                field(included; AlreadyIncludedField())
                {
                    Caption = 'Already added', Comment = 'ESP="Añadido"';
                    trigger OnValidate()
                    begin
                        AddFields(Rec);
                    end;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            group(Fields)
            {
                Caption = 'Add fields', Comment = 'ESP="Añadir campos"';
                action(MFAddFields)
                {
                    ApplicationArea = all;
                    Caption = 'Add fields', Comment = 'ESP="Añadir campos"';
                    Image = Add;
                    trigger OnAction()
                    var
                        field: Record Field;
                        lbl000: Label 'You have added %1 fields.', Comment = 'ESP="Se han añadido %1 campos"';
                    begin
                        field.Reset();
                        CurrPage.SetSelectionFilter(field);
                        if field.FindSet() then begin
                            repeat
                                AddFields(field);
                            until field.Next() = 0;
                            Message(lbl000, fieldsChanged);
                        end;
                    end;
                }
                action(MFRemoveFields)
                {
                    ApplicationArea = all;
                    Caption = 'Remove fields', Comment = 'ESP="Quitar campos"';
                    Image = Delete;
                    trigger OnAction()
                    var
                        field: Record Field;
                        lbl000: Label 'You have removed %1 fields.', Comment = 'ESP="Se han quitado %1 campos"';
                    begin
                        field.Reset();
                        CurrPage.SetSelectionFilter(field);
                        if field.FindSet() then begin
                            repeat
                                RemoveFields(field);
                            until field.Next() = 0;
                            Message(lbl000, fieldsChanged);
                        end;
                    end;
                }
            }
        }
        area(Promoted)
        {

            group(Category_Process)
            {
                Caption = 'Process', Comment = 'ESP="Proceso"';
                actionref(AddFields_Promoted; MFAddFields)
                {
                }
                actionref(RemoveFields_Promoted; MFRemoveFields)
                {
                }
            }
        }
    }
    var
        fieldsChanged: Integer;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        lbl001: Label 'For changing fields, you must use the actions. Do you want to exit without changing any field?', Comment = 'ESP="Para modificar campos, utilice las acciones. ¿Desea salir sin modificar ningún campo?"';
    begin
        if fieldsChanged = 0 then begin
            if not Confirm(lbl001, false) then
                exit(false);
        end;
    end;

    local procedure AlreadyIncludedField(): Boolean
    var
        mfTableFieldSetup: Record MFTableFieldSetup;
    begin
        if mfTableFieldSetup.Get(Rec.TableNo, Rec."No.") then
            exit(true);
    end;

    /// <summary>
    /// AddFields
    /// </summary>
    /// <param name="field"></param>
    local procedure AddFields(field: Record Field)
    var
        mfTableFieldSetup: Record MFTableFieldSetup;
    begin
        if not mfTableFieldSetup.Get(field.TableNo, field."No.") then begin
            mfTableFieldSetup.Init();
            mfTableFieldSetup.Validate(TableNo, field.TableNo);
            mfTableFieldSetup.Validate(FieldNo, field."No.");
            OnBeforeInsertMfFieldSetup(mfTableFieldSetup);
            mfTableFieldSetup.Insert();
            fieldsChanged += 1;
        end;
    end;

    /// <summary>
    /// RemoveFields
    /// </summary>
    /// <param name="field"></param>
    local procedure RemoveFields(field: Record Field)
    var
        mfTableFieldSetup: Record MFTableFieldSetup;
    begin
        if mfTableFieldSetup.Get(field.TableNo, field."No.") then begin
            mfTableFieldSetup.Delete(true);
            fieldsChanged += 1;
        end;
    end;


    [IntegrationEvent(false, false)]
    local procedure OnBeforeInsertMfFieldSetup(var mfTableFieldSetup: Record MFTableFieldSetup)
    begin

    end;

}
