page 50002 "Seminar Setup"
{
    Caption = 'Seminar Setup';
    PageType = Card;
    SourceTable = "Seminar Setup";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(Numbering)
            {
                field("Seminar Nos."; Rec."Seminar Nos.")
                {
                    Caption = 'Seminar Nos.';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Seminar Nos. field.';
                }
                field("Posted Seminar Reg. Nos."; Rec."Posted Seminar Reg. Nos.")
                {
                    Caption = 'Posted Seminar Reg. Nos.';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted Seminar Reg. Nos. field.';
                }
                field("Seminar Registration Nos."; Rec."Seminar Registrant Nos.")
                {
                    Caption = 'Seminar Registrant Nos.';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Seminar Registrant Nos. field.';
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
