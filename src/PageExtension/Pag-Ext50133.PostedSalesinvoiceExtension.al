pageextension 50133 "Posted Sales invoice Extension" extends "Posted Sales Invoice"
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