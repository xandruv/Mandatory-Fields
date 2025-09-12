page 50401 MFTableFieldSetup
{
    ApplicationArea = All;
    Caption = 'Mandatory Fields Table Field Setup', Comment = 'ESP="Configuración de campos obligatorios de la tabla"';
    PageType = List;
    SourceTable = MFTableFieldSetup;
    UsageCategory = None;
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
                field(FieldNo; Rec.FieldNo)
                {
                    Lookup = false;

                    trigger OnDrillDown()
                    begin
                        DrillDownFieldNo();
                    end;
                }
                field(FieldName; Rec.FieldName)
                {
                }
            }
        }
    }

    /// <summary>
    /// DrillDownFieldNo
    /// </summary>
    local procedure DrillDownFieldNo()
    var
        selectorPage: Page MFTableFieldSelector;
        field: Record Field;
    begin
        field.Reset();
        field.SetRange(TableNo, Rec.TableNo);
        field.FindSet();
        selectorPage.SetTableView(field);
        selectorPage.RunModal();
    end;
}
