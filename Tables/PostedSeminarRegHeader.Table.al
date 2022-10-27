table 50011 "Posted Seminar Reg. Header"
{
    Caption = 'Posted Seminar Reg. Header';
    DataClassification = SystemMetadata;
    LookupPageId = "Post. Seminar Reg. List";
    DrillDownPageId = "Post. Seminar Reg. List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
        }
        field(3; "Seminar No."; Code[10])
        {
            Caption = 'Seminar No.';
            TableRelation = Seminar;
        }
        field(4; "Seminar Name"; Text[50])
        {
            Caption = 'Seminar Name';
        }
        field(5; "Instructor Code"; Code[10])
        {
            Caption = 'Instructor Code';
            TableRelation = Instructor;
        }
        field(6; "Instructor Name"; Text[100])
        {
            Caption = 'Instructor Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Instructor.Name where(Code = field("Instructor Code")));
        }
        field(8; "Duration"; Decimal)
        {
            Caption = 'Duration';
            DecimalPlaces = 0 : 1;
        }
        field(9; "Maximum Participants"; Integer)
        {
            Caption = 'Maximum Participants';
        }
        field(10; "Minimum Participants"; Integer)
        {
            Caption = 'Minimum Participants';
        }
        field(11; "Seminar Room Code"; Code[20])
        {
            Caption = 'Seminar Room Code';
            TableRelation = "Seminar Room";
        }
        field(12; "Seminar Room Name"; Text[30])
        {
            Caption = 'Seminar Room Name';
        }
        field(13; "Seminar Room Address"; Text[30])
        {
            Caption = 'Seminar Room Address';
        }
        field(14; "Seminar Room Post Code"; Code[20])
        {
            Caption = 'Seminar Room Post Code';
        }
        field(15; "Seminar Room City"; Text[30])
        {
            Caption = 'Seminar Room City';
        }
        field(16; "Seminar Room Phone No."; Text[30])
        {
            Caption = 'Seminar Room Phone No.';
        }
        field(17; "Seminar Price"; Decimal)
        {
            Caption = 'Seminar Price';
            AutoFormatType = 1;
        }
        field(18; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(19; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }
        field(20; Comment; Boolean)
        {
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = exist("Comment Line" where("Table Name" = filter("Seminar Registration Header"), "No." = field("No.")));
        }
        field(21; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(22; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(23; "Job no."; Code[20])
        {
            Caption = 'Job no.';
            TableRelation = Job;
        }
        field(24; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(25; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(26; "Registration No. Series"; Code[20])
        {
            Caption = 'Registration No. Series';
            TableRelation = "No. Series";
        }
        field(27; "Registration No."; Code[20])
        {
            Caption = 'Registration No.';
        }
        field(28; "User ID"; Code[20])
        {
            Caption = 'User ID';
        }
        field(29; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            TableRelation = "Source Code";
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(key2; "Seminar Room Code")
        {
            SumIndexFields = Duration;
        }
    }
}