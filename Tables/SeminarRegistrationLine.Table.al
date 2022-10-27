table 50005 "Seminar Registration Line"
{
    Caption = 'Seminar Registration Line';
    DataClassification = SystemMetadata;
    LookupPageId = "Seminar Registration Subpage";


    fields
    {
        field(1; "Seminar Registration No."; Code[20])
        {
            Caption = 'Seminar Registration No.';
            TableRelation = "Seminar Registration Header";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            TableRelation = Customer;

            trigger OnValidate()
            begin
                if Rec."Bill-to Customer No." <> xRec."Bill-to Customer No." then
                    TestField(Registered, false);
            end;
        }
        field(4; "Participant Contact No."; Code[20])
        {
            Caption = 'Participant Contact No.';
            TableRelation = Contact;
            trigger OnLookup()
            var
                ContactBusinessRelation: Record "Contact Business Relation";
                Contact: Record Contact;
            begin
                TestField("Bill-to Customer No.");
                ContactBusinessRelation.Reset();
                ContactBusinessRelation.SetRange("Link to Table", ContactBusinessRelation."Link to Table"::Customer);
                ContactBusinessRelation.SetRange("No.", "Bill-to Customer No.");
                if ContactBusinessRelation.FindFirst() then begin
                    Contact.SetRange(Type, Contact.Type::Person);
                    Contact.SetRange("Company No.", ContactBusinessRelation."Contact No.");
                    if Page.RunModal(0, Contact) = Action::LookupOK then begin
                        Rec.Validate("Participant Contact No.", Contact."No.");
                        Rec.CalcFields("Participant Name");
                    end;
                end;
            end;
        }
        field(5; "Participant Name"; Text[100])
        {
            Caption = 'Participant Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Contact.Name where("No." = field("Participant Contact No.")));
        }
        field(6; "Register Date"; Date)
        {
            Caption = 'Register Date';
            Editable = false;
        }
        field(7; "To Invoice"; Boolean)
        {
            Caption = 'To Invoice';
            InitValue = true;
        }
        field(8; Participated; Boolean)
        {
            Caption = 'Participated';
        }
        field(9; "Confirmation Date"; Date)
        {
            Caption = 'Confirmation Date';
            Editable = false;
        }
        field(10; "Seminar Price"; Decimal)
        {
            Caption = 'Seminar Price';
            AutoFormatType = 2;
            trigger OnValidate()
            begin
                Validate("Line Discount %");
            end;
        }
        field(11; "Line Discount %"; Decimal)
        {
            Caption = 'Line Discount %';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            MaxValue = 100;
            trigger OnValidate()
            begin
                if "Seminar Price" = 0 then
                    "Line Discount Amount" := 0
                else begin
                    GeneralLedgerSetup.Get();
                    "Line Discount Amount" := Round("Line Discount %" * "Seminar Price" * 0.01,
                    GeneralLedgerSetup."Amount Rounding Precision")
                end;
                UpdateAmount();
            end;
        }
        field(12; "Line Discount Amount"; Decimal)
        {
            Caption = 'Line Discount Amount';
            AutoFormatType = 1;
            trigger OnValidate()
            begin
                if "Seminar Price" = 0 then
                    "Line Discount %" := 0
                else begin
                    GeneralLedgerSetup.Get();
                    "Line Discount %" := Round("Line Discount Amount" / "Seminar Price" * 100,
                    GeneralLedgerSetup."Amount Rounding Precision")
                end;
                UpdateAmount();
            end;
        }
        field(13; Amount; Decimal)
        {
            Caption = 'Amount';
            AutoFormatType = 1;
            trigger OnValidate()
            begin
                TestField("Bill-to Customer No.");
                TestField("Seminar Price");
                GeneralLedgerSetup.Get();
                Amount := Round(Amount, GeneralLedgerSetup."Amount Rounding Precision");
                "Line Discount Amount" := "Seminar Price" - Amount;
                if "Seminar Price" = 0 then
                    "Line Discount %" := 0
                else
                    "Line Discount %" := Round("Line Discount Amount" / "Seminar Price" * 100,
                        GeneralLedgerSetup."Amount Rounding Precision")

            end;
        }
        field(14; Registered; Boolean)
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
    }

    trigger OnInsert()
    begin
        if SeminarRegistrationHeader.Get("Seminar Registration No.") then begin
            "Register Date" := WorkDate();
            "Seminar Price" := SeminarRegistrationHeader."Seminar Price";
            Amount := SeminarRegistrationHeader."Seminar Price";
        end;
    end;

    trigger OnDelete()
    begin
        TestField(Registered, false);
    end;

    local procedure UpdateAmount()
    begin
        GeneralLedgerSetup.Get();
        Amount := Round("Seminar Price" - "Line Discount Amount",
        GeneralLedgerSetup."Amount Rounding Precision")
    end;

    var
        SeminarRegistrationHeader: Record "Seminar Registration Header";
        GeneralLedgerSetup: Record "General Ledger Setup";

}
