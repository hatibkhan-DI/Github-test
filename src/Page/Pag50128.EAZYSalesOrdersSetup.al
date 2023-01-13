page 50128 "EAZY Sales Orders Setup"
{
    ApplicationArea = All;
    Caption = 'EAZY Sales Orders Setup';
    PageType = Card;
    UsageCategory = Lists;
    SourceTable = "EAZY Sales Orders Setup";
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Base URL"; Rec."Base URL")
                {
                    ToolTip = 'Specifies the value of the Base URL field.';
                }
                field("Access Token"; Rec."Access Token")
                {
                    ToolTip = 'Specifies the value of the Access Token field.';
                }
                field("Page Size"; Rec."Page Size")
                {
                    ToolTip = 'Specifies the value of the Page Size field.';
                }
                field(Customer; Rec.Customer)
                {
                    ToolTip = 'Specifies the Customer No.';
                }
                field(Item; Rec.Item)
                {
                    ToolTip = 'Specifies the Item No.';
                }
            }
        }
    }
    actions
    {

    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;

}
