table 50124 "EAZY Sales Line"
{
    DataClassification = ToBeClassified;

    fields
    {

        field(1; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Line No.';

        }
        field(2; "Order ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "EAZY Sales Header";
            Caption = 'Order ID';
        }
        field(3; SKU; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'SKU';

        }
        field(4; Name; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Name';
        }
        field(5; "Order Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Order Date';
        }
        field(6; "Tax Percent"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Tax Percent';
        }
        field(7; "Tax Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Tax Amount';
        }
        field(8; "Row Total"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Row Total';
        }
        field(9; "Row Total Incl. Tax"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Row Total Incl. Tax';
        }
    }

    keys
    {
        key(PK; "Line No.", "Order ID")
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