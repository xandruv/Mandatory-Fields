pageextension 50404 MFErrorMessagesPart extends "Error Messages Part"
{
    layout
    {
        addafter("Message Type")
        {

            field("Additional Information"; Rec."Additional Information")
            {
                ApplicationArea = All;
            }
        }

    }
}
