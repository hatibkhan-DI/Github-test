codeunit 50125 "Fetch Sales Order Data"
{
    trigger OnRun()
    begin

    end;

    procedure GetSalesOrderData()
    var
        Client: HttpClient;
        Headers: HttpHeaders;
        ResponseMessage: HttpResponseMessage;
        Object: JsonObject;
        JsonText: Text;
        Url: Text;
        IterationCount: Integer;
        index: Integer;
    begin

        IterationCount := GetIterationCount();
        Client.DefaultRequestHeaders.Add('Authorization', 'Bearer ' + GetAccessToken());
        for index := 1 to IterationCount do begin
            Url := GetURL() + format(index);



            if not client.Get(Url, responseMessage) then
                Error('The call to the web service failed.');
            if not ResponseMessage.IsSuccessStatusCode then
                Error('The web service returned an error message:\\' +
                        'Status code: %1\' +
                        'Description: %2',
                        ResponseMessage.HttpStatusCode,
                        ResponseMessage.ReasonPhrase);
            ResponseMessage.Content.ReadAs(JsonText);

            if not Object.ReadFrom(JsonText) then
                Error('Invalid response, expected a JSON object');

            InsertSalesOrderInfo(Object);


        end;


    end;

    procedure GetIterationCount(): Integer
    var
        Client: HttpClient;
        Headers: HttpHeaders;
        ResponseMessage: HttpResponseMessage;
        Token: JsonToken;
        Object: JsonObject;
        JsonText: Text;
        Url: Text;
        IterationCount: Integer;
    begin
        Url := GetURL() + '1';
        Client.DefaultRequestHeaders.Add('Authorization', 'Bearer ' + GetAccessToken());

        if not client.Get(Url, responseMessage) then
            Error('The call to the web service failed.');
        if not ResponseMessage.IsSuccessStatusCode then
            Error('The web service returned an error message:\\' +
                    'Status code: %1\' +
                    'Description: %2',
                    ResponseMessage.HttpStatusCode,
                    ResponseMessage.ReasonPhrase);
        ResponseMessage.Content.ReadAs(JsonText);

        if not Object.ReadFrom(JsonText) then
            Error('Invalid response, expected a JSON object');
        Object.Get('total_count', Token);
        IterationCount := (Token.AsValue().AsInteger()) DIV 10; //Because results have been limited to 10 per page
        if ((Token.AsValue().AsInteger()) MOD 10 > 0) then
            IterationCount := IterationCount + 1;
        exit(IterationCount);
    end;

    procedure GetURL(): Text
    var
        Url: Text;
    begin
        if EAZYSetup.FindFirst() then begin

            Url := EAZYSetup."Base URL" + '?searchCriteria[pageSize]=' + Format(EAZYSetup."Page Size") + '&searchCriteria[currentPage]=';
            Exit(Url);

        end;
    end;

    procedure GetAccessToken(): Text
    var
        AccessToken: text;
    begin
        EAZYSetup.FindFirst();
        AccessToken := EAZYSetup."Access Token";
        exit(AccessToken);

    end;

    procedure ConvertDate(DateString: Text): Text
    var
        DateStrings: List of [Text];
    begin
        DateStrings := DateString.Split(' ');
        DateString := DateStrings.Get(1);
        exit(DateString);
    end;

    procedure InsertSalesOrderInfo(Object: JsonObject)
    var

        Token: JsonToken;
        Itemtoken: JsonToken;
        LineToken: JsonToken;
        Jarray: JsonArray;
        LineArray: JsonArray;
        EAZYSalesHeader: Record "EAZY Sales Header";
        EAZYSalesLines: Record "EAZY Sales Line";
        LineNo: Integer;

    begin
        LineNo := 0;

        Clear(EAZYSalesLines);



        Object.Get('items', Token);
        JArray := Token.AsArray();

        foreach Token in JArray do begin
            Object := Token.AsObject();

            Object.Get('increment_id', ItemToken);
            EAZYSalesHeader."Increment ID" := ItemToken.AsValue().AsText();

            Object.Get('created_at', ItemToken);
            Evaluate(EAZYSalesHeader."Order Date", ConvertDate(ItemToken.AsValue().AsText()));

            Object.Get('customer_email', ItemToken);
            EAZYSalesHeader."Customer Email" := ItemToken.AsValue().AsText();

            Object.Get('subtotal', ItemToken);
            EAZYSalesHeader.Subtotal := ItemToken.AsValue().AsDecimal();

            Object.Get('subtotal_incl_tax', ItemToken);
            EAZYSalesHeader."Subtotal Incl. Tax" := ItemToken.AsValue().AsDecimal();

            Object.Get('tax_amount', ItemToken);
            EAZYSalesHeader."Tax Amount" := ItemToken.AsValue().AsDecimal();

            Object.Get('discount_amount', ItemToken);
            EAZYSalesHeader."Discount Amount" := ItemToken.AsValue().AsDecimal();

            if not EAZYSalesHeader.Insert() then
                EAZYSalesHeader.Modify();


            Object.Get('items', ItemToken);
            LineArray := ItemToken.AsArray();

            foreach ItemToken in LineArray do begin
                Object := ItemToken.AsObject();

                EAZYSalesLines."Line No." := GenerateLineNo(LineNo);
                LineNo := EAZYSalesLines."Line No.";

                EAZYSalesLines."Order ID" := EAZYSalesHeader."Increment ID";
                LineNo := EAZYSalesLines."Line No.";

                Object.Get('sku', LineToken);
                EAZYSalesLines.SKU := LineToken.AsValue().AsText();

                Object.Get('name', LineToken);
                EAZYSalesLines.Name := LineToken.AsValue().AsText();

                Object.Get('created_at', LineToken);
                Evaluate(EAZYSalesLines."Order Date", ConvertDate(LineToken.AsValue().AsText()));

                Object.Get('tax_percent', LineToken);
                EAZYSalesLines."Tax Percent" := LineToken.AsValue().AsDecimal();

                Object.Get('tax_amount', LineToken);
                EAZYSalesLines."Tax Amount" := LineToken.AsValue().AsDecimal();

                Object.Get('row_total', ItemToken);
                EAZYSalesLines."Row Total" := LineToken.AsValue().AsDecimal();

                Object.Get('row_total_incl_tax', LineToken);
                EAZYSalesLines."Row Total Incl. Tax" := LineToken.AsValue().AsDecimal();

                if not EAZYSalesLines.Insert() then
                    EAZYSalesLines.Modify();
                Clear(EAZYSalesLines);


            end;
            LineNo := 0;
            Clear(EAZYSalesHeader);






        end;

    end;

    procedure GenerateLineNo(LineNo: Integer): Integer
    begin
        Exit(LineNo + 10000);
    end;

    procedure CreateSalesOrder(var EAZYSalesHeader: Record "EAZY Sales Header")
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        EAZYSalesLine: Record "EAZY Sales Line";
        SalesReceivable: Record "Sales & Receivables Setup";
        SalesPost: Codeunit "Sales-Post";
    begin
        EAZYSetup.Get();
        SalesReceivable.Get();
        Clear(SalesLine);
        Clear(SalesHeader);
        SalesHeader.Init();
        SalesHeader.Validate("Document Type", SalesHeader."Document Type"::Invoice);
        SalesHeader.Validate("No.", NoSeriesManagement.GetNextNo(SalesReceivable."Invoice Nos.", 0D, true));
        SalesHeader.Validate("Sell-to Customer No.", format(EAZYSetup.Customer));
        SalesHeader."Web Shop Order No." := EAZYSalesHeader."Increment ID";

        if not SalesHeader.Insert(true) then
            Message('Sales Header not inserted');

        EAZYSalesLine.SetFilter("Order ID", SalesHeader."Web Shop Order No.");
        If EAZYSalesLine.FindSet() then begin
            repeat
                Message('No. %1', SalesHeader."No.");
                SalesLine.Validate("Document Type", SalesLine."Document Type"::Invoice);
                SalesLine.Validate("Document No.", SalesHeader."No.");
                SalesLine.Validate("Line No.", EAZYSalesLine."Line No.");
                SalesLine.Type := SalesLine.Type::Item;
                SalesLine.Validate("No.", EAZYSalesLine.SKU);
                SalesLine.Validate(Quantity, 10);
                if not SalesLine.Insert(true) then
                    Message('Sales Line not inserted');
            until EAZYSalesLine.Next() = 0;

            SalesPost.Run(SalesHeader);
        end;

    end;


    var
        NoSeriesManagement: Codeunit NoSeriesManagement;
        EAZYSetup: Record "EAZY Sales Orders Setup";
}