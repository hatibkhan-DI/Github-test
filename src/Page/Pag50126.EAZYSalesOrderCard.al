page 50126 "EAZY Sales Order Card"
{
    ApplicationArea = All;
    Caption = 'EAZY Sales Order Card';
    PageType = Card;
    SourceTable = "EAZY Sales Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Increment ID"; Rec."Increment ID")
                {
                }
                field("Customer Email"; Rec."Customer Email")
                {
                }
                field("Order Date"; Rec."Order Date")
                {
                }
                field(Subtotal; Rec.Subtotal)
                {
                }
                field("Tax Amount"; Rec."Tax Amount")
                {
                }
                field("Subtotal Incl. Tax"; Rec."Subtotal Incl. Tax")
                {
                }
                field("Discount Amount"; Rec."Discount Amount")
                {
                }
            }

            group(Lines)
            {
                part("sales Lines"; "EAZY Sales Order Line")
                {
                    SubPageLink = "Order ID" = field("Increment ID");
                    ApplicationArea = All;
                }
            }
        }
    }
}
