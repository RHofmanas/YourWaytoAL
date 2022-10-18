page 50018 "Posted Seminar Registration"
{
    Caption = 'Posted Seminar Registration';
    PageType = Card;
    Editable = false;
    UsageCategory = Administration;
    SourceTable = "Posted Seminar Reg. Header";

    layout
    {
        area(content)
        {
            group(General)
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
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Date field.';
                }
                field("Duration"; Rec."Duration")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Duration field.';
                }
                field("Minimum Participants"; Rec."Minimum Participants")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Minimum Participants field.';
                }
                field("Maximum Participants"; Rec."Maximum Participants")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Maximum Participants field.';
                }
            }
            group(Lines)
            {
                part("Posted Seminar Reg. Lines"; "Posted Seminar Reg. Subpage")
                {
                    Caption = 'Posted Seminar Registrations';
                    ApplicationArea = All;
                    SubPageLink = "Seminar Registration No." = field("No.");
                }
            }
            group("Seminar Room")
            {
                field("Seminar Room Code"; Rec."Seminar Room Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Seminar Room Code field.';
                }
                field("Seminar Room Name"; Rec."Seminar Room Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of Seminar Room Name.';
                }
                field("Seminar Room Address"; Rec."Seminar Room Address")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of Seminar Room Address.';
                }
                field("Seminar Room Post Code"; Rec."Seminar Room Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of Seminar Room Post Code.';
                }
                field("Seminar Room City"; Rec."Seminar Room City")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of Seminar Room City.';
                }
                field("Seminar Room Phone No."; Rec."Seminar Room Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of Seminar Room Phone No.';
                }
            }
            group(Invoicing)
            {
                field("Seminar Price"; Rec."Seminar Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of Seminar Price.';
                }
                field("Job No."; Rec."Job No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of Job No.';
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

                trigger OnAction()
                begin
                    CurrPage.Update();
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        PostedSeminarHeader: Record "Posted Seminar Reg. Header";
    begin
        PostedSeminarHeader.SetRange("No.");
    end;
}