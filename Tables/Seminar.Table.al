table 50003 Seminar
{
    Caption = 'Seminar';
    DataClassification = CustomerContent;
    LookupPageId = "Seminar List";
    DrillDownPageId = "Seminar List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            trigger OnValidate()
            var
                SeminarSetup: Record "Seminar Setup";
                NoSeriesManagement: Codeunit NoSeriesManagement;
            begin
                if "No." <> xRec."No." then begin
                    SeminarSetup.Get();
                    NoSeriesManagement.TestManual(SeminarSetup."Seminar Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Name; Text[80])
        {
            Caption = 'Name';
            trigger OnValidate()
            begin
                if ("Search Name" = UpperCase(xRec.Name)) or ("Search Name" = '') then
                    "Search Name" := Name;
            end;
        }
        field(3; "Seminar Duration"; Decimal)
        {
            Caption = 'Seminar Duration';
            DecimalPlaces = 1 : 0;
        }
        field(4; "Minimum Participants"; Integer)
        {
            Caption = 'Minimum Participants';
            trigger OnValidate()
            begin
                MinMaxParticipantsCheck()
            end;
        }
        field(5; "Maximum Participants"; Integer)
        {
            Caption = 'Maximum Participants';
            trigger OnValidate()
            begin
                MinMaxParticipantsCheck()
            end;
        }
        field(6; "Search Name"; Code[80])
        {
            Caption = 'Search Name';
        }
        field(7; Blocked; Boolean)
        {
            Caption = 'Blocked';
        }
        field(8; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
        }
        field(9; Comment; Boolean)
        {
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = exist("Comment Line" where("Table Name" = filter("Seminar")));
        }
        field(10; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;
            trigger OnValidate()
            var
                Job: Record Job;
            begin
                Job.Get("Job No.");
                Job.TestField(Blocked, Job.Blocked::" ");
            end;
        }
        field(11; "Seminar Price"; Decimal)
        {
            Caption = 'Seminar Price';
            AutoFormatType = 1;
        }
        field(12; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
            trigger OnValidate()
            var
                GenProdPostingGrp: Record "Gen. Product Posting Group";
            begin
                if xRec."Gen. Prod. Posting Group" <> "Gen. Prod. Posting Group" then
                    if GenProdPostingGrp.ValidateVatProdPostingGroup(
                        GenProdPostingGrp, "Gen. Prod. Posting Group") then
                        Validate("VAT Prod. Posting Group",
                        GenProdPostingGrp."Def. VAT Prod. Posting Group");
            end;
        }
        field(13; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }
        field(14; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(key2; "Search Name")
        {

        }
    }

    procedure AssistEdit() Return: Boolean
    var
        Seminar: Record Seminar;
        SeminarSetup: Record "Seminar Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
    begin
        Seminar := Rec;
        SeminarSetup.Get();
        SeminarSetup.TestField("Seminar Nos.");
        if NoSeriesManagement.SelectSeries(SeminarSetup."Seminar Nos.",
            xRec."No. Series", "No. Series") then begin
            SeminarSetup.Get();
            SeminarSetup.TestField("Seminar Nos.");
            NoSeriesManagement.SetSeries("No.");
            Rec := Seminar;
            exit(true);
        end;
    end;

    procedure MinMaxParticipantsCheck()
    begin
        if ("Minimum Participants" <> 0) and not
             ("Maximum Participants" > "Minimum Participants") then
            Error('Number of maximum participants must be higher then number'
            + ' of minimum participants and both fields must be filled');
    end;

    trigger OnInsert()
    var
        SeminarSetup: Record "Seminar Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
    begin
        if "No." = '' then begin
            SeminarSetup.Get();
            SeminarSetup.TestField("Seminar Nos.");
            NoSeriesManagement.InitSeries(SeminarSetup."Seminar Nos.",
                xRec."No. Series", 0D, "No.", "No. Series");
        end;
        MinMaxParticipantsCheck()
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := Today();
        MinMaxParticipantsCheck()
    end;

    trigger OnRename()
    begin
        "Last Date Modified" := Today();
    end;

    trigger OnDelete()
    var
        CommentLine: Record "Comment Line";
        ExtendedTextHeader: Record "Extended Text Header";
    begin
        CommentLine.Reset();
        CommentLine.SetRange("Table Name", CommentLine."Table Name"::Seminar);
        CommentLine.SetRange("No.", "Search Name");
        CommentLine.DeleteAll(true);
        ExtendedTextHeader.Reset();
        ExtendedTextHeader.SetRange("Table Name", ExtendedTextHeader."Table Name"::Seminar);
        ExtendedTextHeader.SetRange("No.", "Search Name");
        ExtendedTextHeader.DeleteAll(true);
    end;
}
