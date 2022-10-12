table 50006 "Seminar Charge"
{
    Caption = 'Seminar Charge';
    DataClassification = ToBeClassified;
    LookupPageId = "Seminar Charges";

    fields
    {
        field(1; "Seminar Registration No."; Code[20])
        {
            Caption = 'Seminar Registration No.';
            DataClassification = ToBeClassified;
            TableRelation = "Seminar Registration Header";
            NotBlank = true;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            DataClassification = ToBeClassified;
            TableRelation = Job;
            trigger OnValidate()
            var
                Job: Record Job;
            begin
                Job.Get("Job No.");
                Job.TestField(Blocked, Job.Blocked::" ");
                Job.TestField(Status, Job.Status::Open);
            end;
        }
        field(4; "Charge Type"; Enum "Seminar Charge Type")
        {
            Caption = 'Charge Type';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                Description := '';
                "No." := '';
                "Unit of Measure Code" := '';
                "Qty. per Unit of Measure" := 0;
                Quantity := 0;
                "Unit Price" := 0;
                UpdateAmounts();
            end;
        }
        field(5; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                Case "Charge Type" of
                    "Charge Type"::Resource:
                        begin
                            Resource.Get("No.");
                            Resource.TestField(Blocked, false);
                            Resource.TestField("Gen. Prod. Posting Group");
                            Description := Resource.Name;
                            "Gen. Prod. Posting Group" := Resource."Gen. Prod. Posting Group";
                            "VAT Prod. Posting Group" := Resource."VAT Prod. Posting Group";
                            "Unit of Measure Code" := Resource."Base Unit of Measure";
                            "Unit Price" := Resource."Unit Price";
                        end;
                    "Charge Type"::"G/L Account":
                        begin
                            GLAccount.Get("No.");
                            GLAccount.CheckGLAcc();
                            GLAccount.TestField("Direct Posting", true);
                            Description := GLAccount.Name;
                            "Gen. Prod. Posting Group" := GLAccount."Gen. Prod. Posting Group";
                            "VAT Prod. Posting Group" := GLAccount."VAT Prod. Posting Group";
                        end;
                End;
            end;
        }
        field(6; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(7; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            trigger OnValidate()
            begin
                UpdateAmounts();
            end;
        }
        field(8; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
            DataClassification = ToBeClassified;
            AutoFormatType = 2;
            MinValue = 0;
            trigger OnValidate()
            begin
                UpdateAmounts();
            end;
        }
        field(9; "Total Price"; Decimal)
        {
            Caption = 'Total Price';
            Editable = false;
            DataClassification = ToBeClassified;
            AutoFormatType = 1;
        }
        field(10; "To Invoice"; Boolean)
        {
            Caption = 'To Invoice';
            DataClassification = ToBeClassified;
            InitValue = true;
        }
        field(11; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            DataClassification = ToBeClassified;
            TableRelation = Customer;
        }
        field(12; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin

            end;
        }
        field(13; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Product Posting Group";
        }
        field(14; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            DataClassification = ToBeClassified;
            TableRelation = "VAT Product Posting Group";
        }
        field(15; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DataClassification = ToBeClassified;
        }
        field(16; Registered; Boolean)
        {
            Caption = 'Registered';
            Editable = false;
            DataClassification = ToBeClassified;
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

    local procedure UpdateAmounts()
    begin
        "Total Price" := round(Quantity * "Unit Price")
    end;

    trigger OnInsert()
    var
        SeminarRegistrationHeader: Record "Seminar Registration Header";
    begin
        SeminarRegistrationHeader.Get("No.");
        "Job No." := SeminarRegistrationHeader."Job No.";
    end;

    trigger OnModify()
    var
        Job: Record Job;
    begin
        if rec."Job No." <> xRec."Job No." then begin
            Job.Get(rec."Job No.");
            Job.TestField(Blocked, Job.Blocked::" ");
            Job.TestField(Status, Job.Status::Open);
        end;
        if rec."Charge Type" <> xRec."Charge Type" then begin
            Description := '';
            "No." := '';
            "Unit of Measure Code" := '';
            "Qty. per Unit of Measure" := 0;
            Quantity := 0;
            "Unit Price" := 0;
        end;
        UpdateAmounts();
    end;

    trigger OnDelete()
    begin
        rec.TestField(Registered, false);
    end;

    var
        Resource: Record Resource;
        ResourceUofM: Record "Resource Unit of Measure";
        GLAccount: Record "G/L Account";

}
