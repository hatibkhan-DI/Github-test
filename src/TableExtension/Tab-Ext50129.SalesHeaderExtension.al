tableextension 50129 "Sales Header Extension" extends "Sales Header"
{
    fields
    {
        field(50122; "Web Shop Order No."; Code[20])
        {
            Caption = 'Web SHop Order No.';
            TableRelation = "EAZY Sales Header";
            DataClassification = ToBeClassified;
        }
    }
}
