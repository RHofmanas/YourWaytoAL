table 50005 "Seminar Registration Line"
{
    Caption = 'Seminar Registration Line';
    DataClassification = ToBeClassified;
    LookupPageId = "Seminar Registration Subpage";

    fields
    {
        field(1; "Seminar Registration No."; Code[20])
        {
            Caption = 'Seminar Registration No.';
            DataClassification = ToBeClassified;
            TableRelation = "Seminar Registration Header";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            DataClassification = ToBeClassified;
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
            DataClassification = ToBeClassified;
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
                    if Page.RunModal(0, Contact) = Action::OK then
                        Rec.Validate("Participant Contact No.", Contact."No.");
                end;
            end;
        }
        field(5; "Participant Name"; Text[100])
        {
            Caption = 'Participant Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Contact."Lookup Contact No.");
        }
        field(6; "Register Date"; Date)
        {
            Caption = 'Register Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "To Invoice"; Boolean)
        {
            Caption = 'To Invoice';
            DataClassification = ToBeClassified;
            InitValue = true;
        }
        field(8; Participated; Boolean)
        {
            Caption = 'Participated';
            DataClassification = ToBeClassified;
        }
        field(9; "Confirmation Date"; Date)
        {
            Caption = 'Confirmation Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; "Seminar Price"; Decimal)
        {
            Caption = 'Seminar Price';
            DataClassification = ToBeClassified;
            AutoFormatType = 2;
            trigger OnValidate()
            begin
                Validate("Line Discount %");
            end;
        }
        field(11; "Line Discount %"; Decimal)
        {
            Caption = 'Line Discount %';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            MaxValue = 100;
            trigger OnValidate()
            begin
                if "Seminar Price" = 0 then begin
                    "Line Discount Amount" := 0;
                end else begin
                    GLSetup.Get();
                    "Line Discount Amount" := Round("Line Discount %" * "Seminar Price" * 0.01,
                    GLSetup."Amount Rounding Precision")
                end;
                UpdateAmount();
            end;
        }
        field(12; "Line Discount Amount"; Decimal)
        {
            Caption = 'Line Discount Amount';
            DataClassification = ToBeClassified;
            AutoFormatType = 1;
            trigger OnValidate()
            begin
                if "Seminar Price" = 0 then begin
                    "Line Discount %" := 0;
                end else begin
                    GLSetup.Get();
                    "Line Discount %" := Round("Line Discount Amount" / "Seminar Price" * 100,
                    GLSetup."Amount Rounding Precision")
                end;
                UpdateAmount();
            end;
        }
        field(13; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = ToBeClassified;
            AutoFormatType = 1;
            trigger OnValidate()
            begin
                TestField("Bill-to Customer No.");
                TestField("Seminar Price");
                GLSetup.Get();
                Amount := Round(Amount, GLSetup."Amount Rounding Precision");
                "Line Discount Amount" := "Seminar Price" - Amount;
                if "Seminar Price" = 0 then begin
                    "Line Discount %" := 0;
                end else begin
                    "Line Discount %" := Round("Line Discount Amount" / "Seminar Price" * 100,
                    GLSetup."Amount Rounding Precision");
                end;
            end;
        }
        field(14; Registered; Boolean)
        {
            Caption = 'Registered';
            DataClassification = ToBeClassified;
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
        if SeminarRegHeader.Get("Seminar Registration No.") then begin
            "Register Date" := WorkDate();
            "Seminar Price" := SeminarRegHeader."Seminar Price";
            Amount := SeminarRegHeader."Seminar Price";
        end;
    end;

    trigger OnDelete()
    begin
        TestField(Registered, false);
    end;

    local procedure GetSeminarRegHeader()
    begin
        if SeminarRegHeader."No." <> "Seminar Registration No." then
            SeminarRegHeader.Get("Seminar Registration No.");
    end;

    local procedure CalculateAmount()
    begin
        Amount := Round(("Seminar Price" / 100) * (100 - "Line Discount %"));
    end;

    local procedure UpdateAmount()
    begin
        GLSetup.Get();
        Amount := Round("Seminar Price" - "Line Discount Amount",
        GLSetup."Amount Rounding Precision")
    end;

    var
        Contact: Record Contact;
        SeminarRegHeader: Record "Seminar Registration Header";

        GLSetup: Record "General Ledger Setup";

}
