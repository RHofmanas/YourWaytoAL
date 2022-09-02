tableextension 50101 "Saleperson ext" extends "Salesperson/Purchaser"
{
    fields
    {
        field(50100; "Posted Invoices"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula =
            count("Sales Invoice Header" where("Salesperson Code" = field(Code),
            "Sell-to Customer No." = field("Customer Filter")));

        }
        Field(50101; "Customer Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = Customer;
        }
    }
}
