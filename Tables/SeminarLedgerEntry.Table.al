table 50009 "Seminar Ledger Entry"
{
    Caption = 'Seminar Ledger Entry';
    DataClassification = SystemMetadata;
    LookupPageId = "Seminar Ledger Entries";
    DrillDownPageId = "Seminar Ledger Entries";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Seminar No."; Code[20])
        {
            Caption = 'Seminar No.';
            TableRelation = Seminar;
        }
        field(3; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(4; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(5; "Action Type"; Option)
        {
            Caption = 'Action Type';
            OptionMembers = Registration,Cancelation;
        }
        field(6; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(7; Description; Text[80])
        {
            Caption = 'Description';
        }
        field(8; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            TableRelation = Customer;
        }
        field(9; "Option Type"; Enum "Option Type")
        {
            Caption = 'Option Type';
        }
        field(10; "Charge Type"; Enum "Seminar Charge Type")
        {
            Caption = 'Type';
        }
        field(11; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(12; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
            AutoFormatType = 2;
        }
        field(13; "Total Price"; Decimal)
        {
            Caption = 'Total Price';
            AutoFormatType = 1;
        }
        field(14; "Participant Contact No."; Code[20])
        {
            Caption = 'Participant Contact No.';
            TableRelation = Contact;
        }
        field(15; "Participant Name"; Text[100])
        {
            Caption = 'Participant Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Contact.Name where("No." = field("Participant Contact No.")));
        }
        field(16; Chargeable; Boolean)
        {
            Caption = 'Chargeable';
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
        }
        field(21; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;
        }
        field(22; "Source Type"; Option)
        {
            Caption = 'Source Type';
            OptionMembers = ,Seminar;
        }
        field(23; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            TableRelation = if ("Source Type" = const(Seminar)) Seminar;
        }
        field(24; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
        }
        field(25; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            TableRelation = "Source Code";
        }
        field(26; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(27; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(28; "User ID"; Code[50])
        {
            Caption = 'User ID';
            TableRelation = User."User Name";
        }
        field(29; "Job Ledger Entry No."; Integer)
        {
            Caption = 'Job Ledger Entry No.';
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(key2; "Seminar No.", "Posting Date")
        {

        }
        key(key3; "Bill-to Customer No.", "Seminar Registration No.", "Charge Type", "Participant Contact No.")
        {

        }
        key(key4; "Document No.", "Posting Date")
        {

        }
    }
    procedure GetLastEntryNo(): Integer
    var
        FindRecordManagement: Codeunit "Find Record Management";
    begin
        exit(FindRecordManagement.GetLastEntryIntFieldValue(Rec, FieldNo("Entry No.")))
    end;

    procedure CopyFromSeminarJnlLine(SeminarJnlLine: Record "Seminar Journal Line")
    begin
        SeminarLedgEntry."Bill-to Customer No." := SeminarJnlLine."Bill-to Customer No.";
        SeminarLedgEntry.Chargeable := SeminarJnlLine.Chargeable;
        SeminarLedgEntry.Description := SeminarJnlLine.Description;
        SeminarLedgEntry."Document Date" := SeminarJnlLine."Document Date";
        SeminarLedgEntry."Document No." := SeminarJnlLine."Document No.";
        SeminarLedgEntry."Option Type" := SeminarJnlLine."Option Type";
        SeminarLedgEntry."Charge Type" := SeminarJnlLine."Charge Type";
        SeminarLedgEntry."Instructor Code" := SeminarJnlLine."Instructor Code";
        SeminarLedgEntry."Job No." := SeminarJnlLine."Job No.";
        SeminarLedgEntry."Journal Batch Name" := SeminarJnlLine."Journal Batch Name";
        SeminarLedgEntry."Participant Contact No." := SeminarJnlLine."Participant Contact No.";
        SeminarLedgEntry."Posting Date" := SeminarJnlLine."Posting Date";
        SeminarLedgEntry.Quantity := SeminarJnlLine.Quantity;
        SeminarLedgEntry."Reason Code" := SeminarJnlLine."Reason Code";
        SeminarLedgEntry."Seminar No." := SeminarJnlLine."Seminar No.";
        SeminarLedgEntry."No. Series" := SeminarJnlLine."Posting No. Series";
        SeminarLedgEntry."Seminar Registration No." := SeminarJnlLine."Seminar Registration No.";
        SeminarLedgEntry."Seminar Room Code" := SeminarJnlLine."Seminar Room Code";
        SeminarLedgEntry."Source Code" := SeminarJnlLine."Source Code";
        SeminarLedgEntry."Source No." := SeminarJnlLine."Source No.";
        SeminarLedgEntry."Source Type" := SeminarJnlLine."Source Type";
        SeminarLedgEntry."Starting Date" := SeminarJnlLine."Starting Date";
    end;

    [IntegrationEvent(false, false)]
    local procedure AfterCopyFromSeminarJnlLine(sender: Codeunit "Seminar Jnl.-Post Line"; var
        SeminarLedgEntry: Record "Seminar Ledger Entry")
    begin
    end;

    var
        SeminarLedgEntry: Record "Seminar Ledger Entry";

}
