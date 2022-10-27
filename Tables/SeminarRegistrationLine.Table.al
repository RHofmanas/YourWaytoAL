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
            AutoFormatType = 1;
            trigger OnValidate()
            begin
                if "Seminar Price" = 0 then
                    "Line Discount %" := 0
                else begin
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
            AutoFormatType = 1;
            trigger OnValidate()
            begin
                TestField("Bill-to Customer No.");
                TestField("Seminar Price");
                GLSetup.Get();
                Amount := Round(Amount, GLSetup."Amount Rounding Precision");
                "Line Discount Amount" := "Seminar Price" - Amount;
                if "Seminar Price" = 0 then
                    "Line Discount %" := 0
                else
                    "Line Discount %" := Round("Line Discount Amount" / "Seminar Price" * 100,
                        GLSetup."Amount Rounding Precision")

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
    /*
    local procedure GetSeminarRegHeader()
    begin
        if SeminarRegHeader."No." <> "Seminar Registration No." then
            SeminarRegHeader.Get("Seminar Registration No.");
    end;

    local procedure CalculateAmount()
    begin
        Amount := Round(("Seminar Price" / 100) * (100 - "Line Discount %"));
    end;
    */
    local procedure UpdateAmount()
    begin
        GLSetup.Get();
        Amount := Round("Seminar Price" - "Line Discount Amount",
        GLSetup."Amount Rounding Precision")
    end;

    var
#pragma warning disable AA0137
        Contact: Record Contact;
#pragma warning restore AA0137


#pragma warning disable AA0072
        SeminarRegHeader: Record "Seminar Registration Header";
        GLSetup: Record "General Ledger Setup";
#pragma warning restore AA0072

}
