report 50101 "Customer by Salesperson"
{
    Caption = 'Customer by Salesperson';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'RDLC\CustomerBySalesPerson.rdl';
    DefaultLayout = RDLC;
    ApplicationArea = All;

    dataset
    {
        dataitem(Salesperson; "Salesperson/Purchaser")
        {
            PrintOnlyIfDetail = True;
            RequestFilterFields = "Commission %";
            column(CustNoCaption; Customer.FieldCaption("No."))
            {
            }
            column(CustNameCaption; Customer.FieldCaption(Name))
            {
            }
            column(PostCodeCityCaption; PostCodeCityCaption)
            {
            }
            column(CustNoInvoiceAmountsCaption; Customer.FieldCaption("Invoice amounts"))
            {
            }
            column(ReportCaption; ReportCaption)
            {
            }
            column(PageCaption; PageCaption)
            {
            }
            column(UserID; UserID)
            {
            }
            column(CompanyName; CompanyName)
            {
            }
            column("Code"; "Code")
            {
            }
            column("Name"; "Name")
            {
            }
            dataitem(Customer; Customer)
            {
                RequestFilterFields = "Country/Region Code";
                DataItemlinkReference = Salesperson;
                DataItemTableView = sorting("Salesperson Code");
                DataItemLink = "Salesperson Code" = field("Code");
                column("No"; "No.")
                {
                }
                column(Cust_Name; Name)
                {
                }
                column(Invoice_Amounts; "Invoice amounts")
                {
                }
                column("Post_Code_City"; "Post Code" + ' ' + "City")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    calcfields("Sales (LCY)");
                    if (PrintOnlyCustomerWithSale and ("Sales (LCY)" = 0)) then CurrReport.Skip();
                end;
            }
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(General)
                {
                    field(PrintOnlyCustomerWithSale; PrintOnlyCustomerWithSale)
                    {
                        Caption = 'Print active customers';
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    var
        PrintOnlyCustomerWithSale: Boolean;
        PostCodeCityCaption: Label 'Postcode/City';
        ReportCaption: Label 'Customers by Salesperson';
        PageCaption: Label 'Page';
}