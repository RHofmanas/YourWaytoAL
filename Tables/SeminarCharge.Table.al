table 50006 "Seminar Charge"
{
    Caption = 'Seminar Charge';
    DataClassification = SystemMetadata;
    LookupPageId = "Seminar Charges";

    fields
    {
        field(1; "Seminar Registration No."; Code[20])
        {
            Caption = 'Seminar Registration No.';
            TableRelation = "Seminar Registration Header";
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
            trigger OnValidate()
            var
                Job: Record Job;
            begin
                Job.Get("Job No.");
                Job.TestField(Blocked, Job.Blocked::" ");
                Job.TestField(Status, Job.Status::Open);
            end;
        }
        field(4; "Charge Type"; enum "Seminar Charge Type")
        {
            Caption = 'Charge Type';
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
            TableRelation = if ("Charge Type" = const(Resource)) Resource else
            if ("Charge Type" = const("G/L Account")) "G/L Account";

            trigger OnValidate()
            begin
                case "Charge Type" of
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
        }
        field(7; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                UpdateAmounts();
            end;
        }
        field(8; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
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
            AutoFormatType = 1;
        }
        field(10; "To Invoice"; Boolean)
        {
            Caption = 'To Invoice';
            InitValue = true;
        }
        field(11; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            TableRelation = Customer;
        }
        field(12; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            trigger OnValidate()
            begin
                case
                 "Charge Type" of
                    "Charge Type"::Resource:
                        begin
                            Resource.Get("No.");
                            if "Unit of Measure Code" = '' then
                                "Unit of Measure Code" := Resource."Base Unit of Measure";
                            ResourceUofM.Get("No.", "Unit of Measure Code");
                            "Qty. per Unit of Measure" := ResourceUofM."Qty. per Unit of Measure";
                            "Unit Price" := Round(Resource."Unit Price" * "Qty. per Unit of Measure");
                        end;
                    "Charge Type"::"G/L Account":
                        "Qty. per Unit of Measure" := 1;
                end;
            end;
        }
        field(13; "Gen. Prod. Posting Group"; Code[20])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(14; "VAT Prod. Posting Group"; Code[20])
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
            Editable = false;
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
        "Total Price" := Round(Quantity * "Unit Price")
    end;

    trigger OnInsert()
    var
        SeminarRegistrationHeader: Record "Seminar Registration Header";
    begin
        SeminarRegistrationHeader.Get("Seminar Registration No.");
        "Job No." := SeminarRegistrationHeader."Job No.";
    end;

    trigger OnModify()
    var
        Job: Record Job;
    begin
        if Rec."Job No." <> xRec."Job No." then begin
            Job.Get(Rec."Job No.");
            Job.TestField(Blocked, Job.Blocked::" ");
            Job.TestField(Status, Job.Status::Open);
        end;
        if Rec."Charge Type" <> xRec."Charge Type" then begin
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
        Rec.TestField(Registered, false);
    end;

    var
        Resource: Record Resource;
        ResourceUofM: Record "Resource Unit of Measure";
        GLAccount: Record "G/L Account";

}
