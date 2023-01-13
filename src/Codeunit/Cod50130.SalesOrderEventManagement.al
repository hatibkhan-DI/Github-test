codeunit 50130 "Sales Order Event Management"
{
    trigger OnRun()
    begin

    end;

    // [EventSubscriber(ObjectType::Page, Page::"Sales Order", 'OnAfterActionEvent', 'Release', false, false)]
    // local procedure PostOrderOnAfterActionEvent(var Rec: Record "Sales Header")
    // var
    //     SalesPost: Codeunit "Sales-Post";
    // begin
    //     Rec.Ship := true;
    //     Rec.Invoice := true;
    //     SalesPost.Run(Rec);
    // end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterModifyEvent', '', true, true)]
    local procedure OnAfterModifySalesHeaderEvent(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; RunTrigger: Boolean)
    var
        SalesPost: Codeunit "Sales-Post";
    begin
        // if Rec.Status <> xRec.Status then
        if Rec.Status = Rec.Status::Released then begin
            Rec.Ship := true;
            Rec.Invoice := true;
            SalesPost.Run(Rec);
        end;

    end;

}