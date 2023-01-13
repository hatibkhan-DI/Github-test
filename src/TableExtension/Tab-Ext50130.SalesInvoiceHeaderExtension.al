tableextension 50130 "Sales Invoice Header Extension" extends "Sales Invoice Header"
{
    fields
    {
        field(50122; "Web Shop Order No."; Code[20])
        {
            Caption = 'Web Shop Order No.';
            TableRelation = "EAZY Sales Header";
            DataClassification = ToBeClassified;
        }
    }
}
