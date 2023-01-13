table 50123 "EAZY Sales Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Increment ID"; Code[20])
        {
            Caption = 'Increment ID';

        }
        field(2; "Order Date"; Date)
        {
            Caption = 'Order Date';

        }
        field(3; "Customer Email"; Text[50])
        {
            Caption = 'Customer Email';

        }
        field(4; Subtotal; Decimal)
        {
            Caption = 'Subtotal';

        }
        field(5; "Subtotal Incl. Tax"; Decimal)
        {
            Caption = 'Subtotal Incl. Tax';

        }
        field(6; "Tax Amount"; Decimal)
        {
            Caption = 'Tax Amount';

        }
        field(7; "Discount Amount"; Decimal)
        {
            Caption = 'Discount Amount';

        }

    }

    keys
    {
        key(PK; "Increment ID")
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