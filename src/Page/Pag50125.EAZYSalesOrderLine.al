page 50125 "EAZY Sales Order Line"
{
    ApplicationArea = All;
    Caption = 'EAZY Sales Order Line';
    PageType = ListPart;
    SourceTable = "EAZY Sales Line";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                    ApplicationArea = All;
                }
                field(SKU; Rec.SKU)
                {
                    ToolTip = 'Specifies the value of the SKU field.';
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ToolTip = 'Specifies the value of the Created At field.';
                    ApplicationArea = All;
                }
                field("Tax Percent"; Rec."Tax Percent")
                {
                    ToolTip = 'Specifies the value of the Tax Percent field.';
                    ApplicationArea = All;
                }
                field("Tax Amount"; Rec."Tax Amount")
                {
                    ToolTip = 'Specifies the value of the Tax Amount field.';
                    ApplicationArea = All;
                }
                field("Row Total"; Rec."Row Total")
                {
                    ToolTip = 'Specifies the value of the Row Total field.';
                    ApplicationArea = All;
                }
                field("Row Total Incl. Tax"; Rec."Row Total Incl. Tax")
                {
                    ToolTip = 'Specifies the value of the Row Total Incl. Tax field.';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Say Hi")
            {
                

            }
        }
    }
 procedure SayHello()
    begin
        Message('Hello');

    end;
}
