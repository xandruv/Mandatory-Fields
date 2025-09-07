page 50400 MFTableSetup
{
    ApplicationArea = All;
    Caption = 'Mandatory Fields Table Setup', Comment = 'ESP="Configuración de campos obligatorios por tabla"';
    PageType = List;
    SourceTable = MFTableSetup;
    UsageCategory = Lists;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(TableNo; Rec.TableNo)
                {
                }
                field(TableName; Rec.TableName)
                {
                }
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            group(Fields)
            {
                Caption = 'Fields Setup', Comment = 'ESP="Configuración campos"';
                action(MFTableFieldSetup)
                {
                    ApplicationArea = all;
                    Caption = 'Fields Setup', Comment = 'ESP="Configuración campos"';
                    Image = Relationship;
                    RunObject = page MFTableFieldSetup;
                    RunPageLink = TableNo = field(TableNo);
                }
            }
        }
        area(Promoted)
        {

            group(Category_Navigation)
            {
                Caption = 'Fields Setup', Comment = 'ESP="Configuración campos"';

                actionref(MFTableFieldSetup_Promoted; MFTableFieldSetup)
                {
                }
            }
        }
    }
}
