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
}
