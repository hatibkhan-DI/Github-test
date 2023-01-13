page 50123 "EAZY Sales Order List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "EAZY Sales Header";
    CardPageId = "EAZY Sales Order Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Increment ID"; Rec."Increment ID")
                {
                    ApplicationArea = All;

                }
                field("Customer Email"; Rec."Customer Email")
                {
                    ApplicationArea = All;

                }
                field("Subtotal"; Rec."Subtotal")
                {
                    ApplicationArea = All;

                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Fetch Sales Orders")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    FetchSales.GetSalesOrderData();
                end;
            }
            action("Create Sales Order")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    FetchSales.CreateSalesOrder(Rec);
                end;
            }
        }
    }

    var
        FetchSales: Codeunit "Fetch Sales Order Data";


}