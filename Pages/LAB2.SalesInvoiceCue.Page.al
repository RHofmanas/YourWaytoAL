page 50126 SalesInvoiceCuePage
{
    PageType = CardPart;
    SourceTable = SalesInvoiceCueTable;

    layout
    {
        area(content)
        {
            cuegroup(SalesCueContainer)
            {
                Caption = 'Sales Invoices';
                field(SalesCue; Rec.SalesInvoicesOpen)
                {
                    Caption = 'Open';
                    DrillDownPageId = "Sales Invoice List";
                    ApplicationArea = all;
                }
            }
        }
    }

    trigger OnOpenPage();
    begin
        Rec.RESET;
        if not Rec.get then begin
            rec.INIT;
            rec.INSERT;
        end;
    end;
}