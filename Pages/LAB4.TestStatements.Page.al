page 50109 "Test Statements Page"
{
    PageType = Card;

    layout
    {
        area(content)
        {
            group(GeneralFastTab)
            {
                Caption = 'General';
                group(Input)
                {
                    field(Quantity; Quantity)
                    {
                        Caption = 'Quantity';
                        ApplicationArea = All;
                    }
                    field(UnitPrice; UnitPrice)
                    {
                        Caption = 'Unit Price';
                        MinValue = 0;
                        ApplicationArea = All;
                    }

                }
                group(Output)
                {

                    field(Result; Result)
                    {
                        Caption = 'Result';
                        Editable = False;
                        ApplicationArea = All;
                    }
                    field(TotalSales; TotalSales)
                    {
                        Caption = 'Total Sales';
                        Editable = False;
                        ApplicationArea = All;
                    }
                    field(TotalCredits; TotalCredits)
                    {
                        Caption = 'Total Credits';
                        Editable = False;
                        ApplicationArea = All;
                    }
                    field(GrandTotal; GrandTotal)
                    {
                        Caption = 'Grand Total';
                        Editable = False;
                        ApplicationArea = All;
                    }

                    field(TotalQtySales; TotalSales)
                    {
                        Caption = 'Total Qty Sales';
                        Editable = False;
                        ApplicationArea = All;
                    }
                    field(TotalQtyCredits; TotalCredits)
                    {
                        Caption = 'Total Qty Credits';
                        Editable = False;
                        ApplicationArea = All;
                    }
                    field(GrandQtyTotal; GrandTotal)
                    {
                        Caption = 'Grand Qty Total';
                        Editable = False;
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Execute_If)
            {
                Caption = 'Execute If';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF Quantity = 0 THEN
                        EXIT;
                    Result := Quantity * UnitPrice;
                    IF Result < 0 THEN
                        TotalCredits := TotalCredits + Result
                    ELSE
                        TotalSales := TotalSales + Result;
                    GrandTotal := GrandTotal + Result;
                end;
            }
            action(Clear)
            {
                Caption = 'Clear';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Quantity := 0;
                    UnitPrice := 0;
                    Result := 0;
                    TotalSales := 0;
                    TotalCredits := 0;
                    GrandTotal := 0;
                end;
            }
            action(ExecuteCompound)
            {
                Caption = 'Execute Compound';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF Quantity = 0 THEN EXIT;
                    Result := Quantity * UnitPrice;
                    IF Result < 0 THEN begin
                        TotalCredits := TotalCredits + Result;
                        TotalQtyCredits := TotalQtyCredits + Quantity
                    end ELSE begin
                        TotalSales := Totalsales + Result;
                        TotalQtySales := TotalQtySales + Quantity
                    end;
                    GrandTotal := GrandTotal + Result;
                    GrandQtyTotal := GrandQtyTotal + Quantity;
                end;
            }
            action(ExecuteCase)
            {
                Caption = 'Execute Case';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Result := Quantity * UnitPrice;
                    CASE TRUE OF
                        Quantity = 0:
                            EXIT;
                        Quantity < 0:
                            begin
                                TotalCredits := TotalCredits + Result;
                                TotalQtyCredits := TotalQtyCredits + Quantity
                            end;
                        Quantity > 0:
                            begin
                                TotalSales := Totalsales + Result;
                                TotalQtySales := TotalQtySales + Quantity
                            end;
                    end;
                    GrandTotal := GrandTotal + Result;
                    GrandQtyTotal := GrandQtyTotal + Quantity;
                end;
            }
        }
    }


    var
        Quantity: Integer;
        UnitPrice: Decimal;
        TotalSales: Decimal;
        TotalCredits: Decimal;
        GrandTotal: Decimal;
        Result: Decimal;
        TotalQtySales: Integer;
        TotalQtyCredits: Integer;
        GrandQtyTotal: Integer;
}