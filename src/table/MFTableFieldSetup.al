table 50401 MFTableFieldSetup
{
    Caption = 'Mandatory Fields Table Field Setup', Comment = 'ESP="Configuración de campos obligatorios de la tabla"';
    DataClassification = CustomerContent;

    fields
    {
        field(1; TableNo; Integer)
        {
            Caption = 'Table No', Comment = 'ESP="N.º de tabla"';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Table));
        }

        field(2; FieldNo; Integer)
        {
            Caption = 'Field No', Comment = 'ESP="N.º de campo"';
            TableRelation = Field."No." where(TableNo = field(TableNo));
        }
        field(3; FieldName; Text[250])
        {
            Caption = 'Field Name', Comment = 'ESP="Nombre de campo"';
            FieldClass = FlowField;
            CalcFormula = lookup(Field."Field Caption" where(TableNo = field(TableNo), "No." = field(FieldNo)));
            Editable = false;
        }
    }
    keys
    {
        key(PK; TableNo, FieldNo)
        {
            Clustered = true;
        }
    }
}
