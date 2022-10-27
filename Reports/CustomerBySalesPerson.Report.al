#pragma warning disable LC0015
report 50101 "Customer by Salesperson"
#pragma warning restore LC0015
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
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Commission %";
            column(CustNoCaption; Customer.FieldCaption("No."))
            {
            }
            column(CustNameCaption; Customer.FieldCaption(Name))
            {
            }
            column(PostCodeCityCaption; PostCodeCityCaptionLbl)
            {
            }
            column(CustNoInvoiceAmountsCaption; Customer.FieldCaption("Invoice Amounts"))
            {
            }
            column(ReportCaption; ReportCaptionLbl)
            {
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(UserID; UserId)
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
                column(Invoice_Amounts; "Invoice Amounts")
                {
                }
                column("Post_Code_City"; "Post Code" + ' ' + "City")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    CalcFields("Sales (LCY)");
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
                    Caption = 'General';
                    field(PrintOnlyCustomerWithSale; PrintOnlyCustomerWithSale)
                    {
                        Caption = 'Print active customers';
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Print active customers field.';
                    }
                }
            }
        }
    }

    var
#pragma warning disable AA0204
        PrintOnlyCustomerWithSale: Boolean;
#pragma warning restore AA0204
        PostCodeCityCaptionLbl: Label 'Postcode/City';
        ReportCaptionLbl: Label 'Customers by Salesperson';
        PageCaptionLbl: Label 'Page';
}