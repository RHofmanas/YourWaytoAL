table 50011 "Posted Seminar Reg. Header"
{
    Caption = 'Posted Seminar Reg. Header';
    DataClassification = ToBeClassified;
    LookupPageId = "Post. Seminar Reg. Header List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            DataClassification = ToBeClassified;
        }
        field(3; "Seminar No."; Code[10])
        {
            Caption = 'Seminar No.';
            DataClassification = ToBeClassified;
            TableRelation = Seminar;
        }
        field(4; "Seminar Name"; Text[50])
        {
            Caption = 'Seminar Name';
            DataClassification = ToBeClassified;
        }
        field(5; "Instructor Code"; Code[10])
        {
            Caption = 'Instructor Code';
            DataClassification = ToBeClassified;
            TableRelation = Instructor;
        }
        field(6; "Instructor Name"; Text[80]) // <--- changed from Text[50] due possible conflict with source table
        {
            Caption = 'Instructor Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Instructor.Name);
        }
        field(7; "Duration"; Decimal)
        {
            Caption = 'Duration';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 1;
        }
        field(8; "Maximum Participants"; Integer)
        {
            Caption = 'Maximum Participants';
            DataClassification = ToBeClassified;
        }
        field(9; "Minimum Participants"; Integer)
        {
            Caption = 'Minimum Participants';
            DataClassification = ToBeClassified;
        }
        field(10; "Seminar Room Code"; Code[20])
        {
            Caption = 'Seminar Room Code';
            DataClassification = ToBeClassified;
            TableRelation = "Seminar Room";
        }
        field(11; "Seminar Room Name"; Text[30])
        {
            Caption = 'Seminar Room Name';
            DataClassification = ToBeClassified;
        }
        field(12; "Seminar Room Address"; Text[30])
        {
            Caption = 'Seminar Room Address';
            DataClassification = ToBeClassified;
        }
        field(13; "Seminar Room Post Code"; Code[20])
        {
            Caption = 'Seminar Room Post Code';
            DataClassification = ToBeClassified;
            TableRelation = "Post Code";
            ValidateTableRelation = false;
            // TestTableRelation = false; <--- depricated in the future releases
        }
        field(14; "Seminar Room City"; Text[30])
        {
            Caption = 'Seminar Room City';
            DataClassification = ToBeClassified;
        }
        field(15; "Seminar Room Phone No."; Text[30])
        {
            Caption = 'Seminar Room Phone No.';
            DataClassification = ToBeClassified;
        }
        field(16; "Seminar Price"; Decimal)
        {
            Caption = 'Seminar Price';
            DataClassification = ToBeClassified;
            AutoFormatType = 1;
        }
        field(17; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Product Posting Group";
        }
        field(18; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            DataClassification = ToBeClassified;
            TableRelation = "VAT Product Posting Group";
        }
        field(19; Comment; Boolean)
        {
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = exist("Comment Line" WHERE("Table Name" = filter("Seminar Registration Header"))); // <--- not sure it is correct, p. 172
        }
        field(20; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = ToBeClassified;
        }
        field(21; "Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification = ToBeClassified;
        }
        field(22; "Job no."; Code[20])
        {
            Caption = 'Job no.';
            DataClassification = ToBeClassified;
            TableRelation = Job;
        }
        field(23; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            DataClassification = ToBeClassified;
            TableRelation = "Reason Code";
        }
        field(24; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(25; "Registration No. Series"; Code[10])
        {
            Caption = 'Registration No. Series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(26; "Registration No."; Code[20])
        {
            Caption = 'Registration No.';
            DataClassification = ToBeClassified;
        }
        field(27; "User ID"; Code[20])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
            TableRelation = User;
            //TestTableRelation = false;  <--- depricated in the future releases
        }
        field(28; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            DataClassification = ToBeClassified;
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
