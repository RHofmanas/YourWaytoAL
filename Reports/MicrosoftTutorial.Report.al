report 50103 "Microsoft Tutorial Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = 'RDLC\Microsoft Tutorial Report.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Customer; Customer)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Name", "Customer Posting Group";
            column(CustomerNo; "No.")
            {
            }
            column(CustomerName; Name)
            {
            }
            dataitem(CustomerLedgers; "Cust. Ledger Entry")
            {
                DataItemLinkReference = Customer;
                DataItemLink = "Customer No." = field("No.");
                DataItemTableView = sorting("Customer No.");
                column(CustomerLedgersCustomerNo; "Customer No.")
                {
                }
                column(CustomerLedgersAmountLCY; "Amount (LCY)")
                {
                }
            }
            trigger OnPreDataItem()
            begin
                if HideBlockedCustomers then
                    Customer.SetRange(Blocked, Blocked::" ");
            end;
        }
    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    field(HideBlockedCustomers; HideBlockedCustomers)
                    {
                        ApplicationArea = All;
                        Caption = 'Hide Blocked Customers?';
                    }
                }
            }
        }

    }
    var
        HideBlockedCustomers: Boolean;
}