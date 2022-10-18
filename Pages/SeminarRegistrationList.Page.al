page 50010 "Seminar Registration List"
{
    Caption = 'Seminar Registration List';
    PageType = List;                            // Changed from ListPart
    SourceTable = "Seminar Registration Header";
    Editable = false;
    CardPageId = "Seminar Registration";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Starting Date field.';
                }
                field("Seminar No."; Rec."Seminar No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Seminar No. field.';
                }
                field("Seminar Name"; Rec."Seminar Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Seminar Name field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Duration"; Rec."Duration")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Duration field.';
                }
                field("Maximum Participants"; Rec."Maximum Participants")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Maximum Participants field.';
                }
                field("Seminar Room Code"; Rec."Seminar Room Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Seminar Room Code field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {

            action("Seminar Registration")
            {
                Caption = 'Seminar Registration';
                Image = BookingsLogo;
                ApplicationArea = Comments;
                RunObject = Page "Seminar Registration";
            }
            action("Comments")
            {
                Caption = 'Comments';
                ApplicationArea = Comments;
                Image = ViewComments;
                RunObject = Page "Comment Sheet";
            }
            action(Charges)
            {
                ApplicationArea = Suite;
                Caption = 'Charges';
                Image = Calculate;
                RunObject = Page "Seminar Charges";
            }
            action(Posting) // added page 185
            {
                ApplicationArea = Suite;
                Caption = 'P&post';
                Image = Post;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                ShortCutKey = 'F9';
                RunObject = Codeunit "Seminar-Post(Yes/No)";
                ToolTip = 'Post Seminar';
            }
        }
    }
}
