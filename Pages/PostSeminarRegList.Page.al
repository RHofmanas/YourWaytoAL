#pragma warning disable LC0015
page 50015 "Post. Seminar Reg. List"
#pragma warning restore LC0015
{
    ApplicationArea = All;
    Caption = 'Post. Seminar Reg. List';
    PageType = List;   // Changed from List Part
    Editable = false;
    SourceTable = "Posted Seminar Reg. Header";
    UsageCategory = Administration;

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
                field("Seminar Name"; Rec."Seminar Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Seminar Name field.';
                }
                field("Instructor Code"; Rec."Instructor Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Instructor Code field.';
                }
                field("Instructor Name"; Rec."Instructor Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Instructor Name field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Seminar Price"; Rec."Seminar Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Seminar Price field.';
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Starting Date field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Comments)
            {
                Caption = 'Comments';
                ApplicationArea = Comments;
                Image = ViewComments;
                RunObject = Page "Comment Sheet";
                RunPageLink = "Table Name" = const("Posted Seminar Registration"), "No." = field("No.");
                ToolTip = 'Executes the Comments action.';

                trigger OnAction()
                begin
                    CurrPage.Update();
                end;
            }
            action(Charges)
            {
                ApplicationArea = Suite;
                Caption = 'Charges';
                Image = IssueFinanceCharge;
                RunObject = Page "Seminar Charges";
                RunPageLink = "Seminar Registration no." = field("No.");
                ToolTip = 'Executes the Charges action.';

                trigger OnAction()
                begin
                    CurrPage.Update();
                end;
            }
            action("&Navigate")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Find entries...';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Category4;
                ShortCutKey = 'Ctrl+Alt+Q';
                ToolTip = 'Find entries and documents that exist for the document number and posting date on the selected document. (Formerly this action was named Navigate.)';

                trigger OnAction()
                var
                    PostedSeminarRegLine: Record "Posted Seminar Reg. Line";
                    Navigate: Page Navigate;
                begin
                    Navigate.SetDoc(PostedSeminarRegLine."Register Date", PostedSeminarRegLine."Seminar Registration No.");
                    Navigate.Run();
                end;
            }
        }
    }
}
