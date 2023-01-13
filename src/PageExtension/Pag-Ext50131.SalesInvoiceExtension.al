pageextension 50131 "Sales Invoice Extension" extends "Sales Invoice"
{
    layout
    {
        addlast(General)
        {
            field("Web Shop Order No."; Rec."Web Shop Order No.")
            {
                ApplicationArea = All;
                
            }
        }
    }
}
