table 50127 "EAZY Sales Orders Setup"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; ID; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'ID';

        }
        field(2; "Base URL"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Base URL';

        }
        field(3; "Page Size"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Page Size';

        }
        field(4; "Access Token"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Access Token';

        }
        field(5; "Customer"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer No.';
            TableRelation = Customer;

        }
        field(6; Item; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Item No.';
            TableRelation = Item;

        }

    }

    keys
    {
        key(Key1; ID)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}