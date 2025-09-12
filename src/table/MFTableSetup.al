table 50400 MFTableSetup
{
    Caption = 'Mandatory Fields Table Setup', Comment = 'ESP="Configuración de campos obligatorios por tabla"';
    DataClassification = CustomerContent;

    fields
    {
        field(1; TableNo; Integer)
        {
            Caption = 'Table No', Comment = 'ESP="N.º de tabla"';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Table));
        }
        field(2; TableName; Text[250])
        {
            Caption = 'Table Name', Comment = 'ESP="Nombre de tabla"';
            FieldClass = FlowField;
            CalcFormula = lookup(AllObjWithCaption."Object Caption" where("Object Type" = const(Table), "Object ID" = field(TableNo)));
            Editable = false;
        }
    }
    keys
    {
        key(PK; TableNo)
        {
            Clustered = true;
        }
    }

    trigger OnDelete()
    var
        MFTableFieldSetup: Record MFTableFieldSetup;
        lbl001: Label 'Table %1 has mandatory fields. Do you want to delete them?', Comment = 'ESP="La tabla %1 contiene campos obligatorios configurados. ¿Desea eliminarlos?"';
        lbl002: Label 'Deletion was canceled', Comment = 'ESP="Operación cancelada"';
    begin
        MFTableFieldSetup.Reset();
        MFTableFieldSetup.SetRange(TableNo, Rec.TableNo);
        if MFTableFieldSetup.FindSet() then
            if not Confirm(lbl001, false, Rec.TableName) then
                Error(lbl002);
        MFTableFieldSetup.DeleteAll(true);
    end;
}
