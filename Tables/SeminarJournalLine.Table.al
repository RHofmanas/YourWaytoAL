#pragma warning disable LC0015
table 50008 "Seminar Journal Line"
#pragma warning restore LC0015
{
    Caption = 'Seminar Journal Line';
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Seminar No."; Code[20])
        {
            Caption = 'Seminar No.';
            TableRelation = Seminar;
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(5; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(6; "Entry Type"; Option)
        {
            Caption = 'Entry Type';
            OptionMembers = Registration,Cancelation;
        }
        field(7; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(8; Description; Text[80])
        {
            Caption = 'Description';
        }
        field(9; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            TableRelation = Customer;
        }
        field(10; "Option Type"; enum "Option Type")
        {
            Caption = 'Option Type';
        }
        field(11; "Charge Type"; enum "Seminar Charge Type")
        {
            Caption = 'Charge Type';
        }
        field(12; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(13; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
            AutoFormatType = 2;
        }
        field(14; "Total Price"; Decimal)
        {
            Caption = 'Total Price';
            AutoFormatType = 1;
        }
        field(15; "Participant Contact No."; Code[20])
        {
            Caption = 'Participant Contact No.';
            TableRelation = Contact;
        }
        field(16; Chargeable; Boolean)
        {
            Caption = 'Chargeable';
            InitValue = true;
        }
        field(17; "Seminar Room Code"; Code[10])
        {
            Caption = 'Seminar Room Code';
            TableRelation = "Seminar Room";
        }
        field(18; "Instructor Code"; Code[10])
        {
            Caption = 'Instructor Code';
            TableRelation = Instructor;
        }
        field(19; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
        }
        field(20; "Seminar Registration No."; Code[20])
        {
            Caption = 'Seminar Registration No.';
            TableRelation = "Seminar Registration Header";
        }
        field(21; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;
        }
        field(22; "Job Ledger Entry No."; Integer)
        {
            Caption = 'Job Ledger Entry No.';
            TableRelation = "Job Ledger Entry";
        }
        field(23; "Source Type"; Option)
        {
            Caption = 'Source Type';
            OptionMembers = ,Seminar;
        }
        field(24; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            TableRelation = if ("Source Type" = const(Seminar)) Seminar;
        }
        field(25; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
        }
        field(26; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            TableRelation = "Source Code";
        }
        field(27; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(28; "Posting No. Series"; Code[10])
        {
            Caption = 'Posting No. Series';
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(PK; "Journal Template Name", "Journal Batch Name", "Line No.")
        {
            Clustered = true;
        }
    }
    procedure EmptyLine(): Boolean
    begin
        if Rec."Seminar No." = '' then exit(true);
    end;
}
