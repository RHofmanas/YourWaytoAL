page 50008 "Seminar Registration Subpage"
{
    Caption = 'Lines';
    PageType = ListPart;
    SourceTable = "Seminar Registration Line";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    Caption = 'Bill-to Customer';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bill-to Customer No. field.';
                }
                field("Participant Contact No."; Rec."Participant Contact No.")
                {
                    Caption = 'Participant Contact No.';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Participant Contact No. field.';
                }
                field("Participant Name"; Rec."Participant Name")
                {
                    Caption = 'Participant Name';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Participant Name field.';
                }
                field(Participated; Rec.Participated)
                {
                    Caption = 'Participated';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Participated field.';
                }
                field("Register Date"; Rec."Register Date")
                {
                    Caption = 'Register Date';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Register Date field.';
                }
                field("Confirmation Date"; Rec."Confirmation Date")
                {
                    Caption = 'Confirmation Date';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Confirmation Date field.';
                }
                field("To Invoice"; Rec."To Invoice")
                {
                    Caption = 'To Invoice';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the To Invoice field.';
                }
                field(Registered; Rec.Registered)
                {
                    Caption = 'Registered';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Registered field.';
                }
                field("Seminar Price"; Rec."Seminar Price")
                {
                    Caption = 'Seminar Price';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Seminar Price field.';
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    Caption = 'Line Discount %';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line Discount% field.';
                    BlankZero = true;
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    Caption = 'Line Discount Amount';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line Discount Amount field.';
                    BlankZero = true;
                }
                field(Amount; Rec.Amount)
                {
                    Caption = 'Amount';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert()
        end;
    end;
}
