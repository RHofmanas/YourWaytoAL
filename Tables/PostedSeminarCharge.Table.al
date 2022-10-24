table 50013 "Posted Seminar Charge"
{
    Caption = 'Posted Seminar Charge';
    DataClassification = CustomerContent;
    DrillDownPageId = "Posted Seminar Charges";
    LookupPageId = "Posted Seminar Charges";

    fields
    {
        field(1; "Seminar Registration No."; Code[10])
        {
            Caption = 'Seminar Registration No.';
            TableRelation = "Posted Seminar Reg. Header";
            NotBlank = true;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;
        }
        field(4; Type; enum "Seminar Charge Type")
        {
            Caption = 'Type';
        }
        field(5; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = if (Type = const(Resource)) Resource else
            if (Type = const("G/L Account")) "G/L Account";
        }
        field(6; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(7; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(8; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
            AutoFormatType = 2;
            MinValue = 0;
        }
        field(9; "Total Price"; Decimal)
        {
            Caption = 'Total Price';
            Editable = false;
            AutoFormatType = 1;
        }
        field(10; "To Invoice"; Boolean)
        {
            Caption = 'To Invoice';
        }
        field(11; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            TableRelation = Customer;
        }
        field(12; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation =
            if (Type = const(Resource)) "Resource Unit of Measure".Code
                where("Resource No." = field("No."))
            else
            "Unit of Measure";
        }
        field(13; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(14; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }
        field(15; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
        }
        field(16; Registered; Boolean)
        {
            Caption = 'Registered';
        }
    }
    keys
    {
        key(PK; "Seminar Registration No.", "Line No.")
        {
            Clustered = true;
        }
        key(key2; "Job No.")
        {
        }
    }
}
