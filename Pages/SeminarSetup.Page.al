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
                }
                field("Posted Seminar Reg. Nos."; Rec."Posted Seminar Reg. Nos.")
                {
                    Caption = 'Posted Seminar Reg. Nos.';
                    ApplicationArea = All;
                }
                field("Seminar Registration Nos."; Rec."Seminar Registrant Nos.")
                {
                    Caption = 'Seminar Registrant Nos.';
                    ApplicationArea = All;
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
