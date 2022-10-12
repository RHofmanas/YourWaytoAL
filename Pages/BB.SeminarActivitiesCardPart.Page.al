page 50011 "Seminar Activities"
{
    Caption = 'Seminar Activities';
    PageType = CardPart;
    SourceTable = "Seminar Cue";

    layout
    {
        area(content)
        {
            cuegroup(Seminar)
            {
                field("Active Seminars"; Rec."Active Seminars")
                {
                    Caption = 'Active Seminars';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Active Seminars field.';
                }
                field("Todays Seminars"; Rec."Todays Seminars")
                {
                    Caption = 'Todays Seminars';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Todays Seminars field.';
                }
                field("Upcoming Seminars"; Rec."Upcoming Seminars")
                {
                    Caption = 'Upcoming Seminars';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Upcoming Seminars field.';
                }
            }

        }
    }
    trigger OnOpenPage()
    var
        Date: Record Date;
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
        Date.SetRange("Period Type", Date."Period Type"::Week);
        Date.SetFilter("Period Start", '>%1', WorkDate());
        Date.FindFirst();
        Rec.SetRange("Next Week Date filter", Date."Period Start", Date."Period End");
        Rec.SetRange("Today Date filter", WorkDate());
        Rec.CalcFields("Active Seminars", "Todays Seminars", "Upcoming Seminars");
    end;
}
