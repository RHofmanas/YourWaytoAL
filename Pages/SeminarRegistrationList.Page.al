page 50010 "Seminar Registration List"
{
    Caption = 'Seminar Registration List';
    PageType = List;                            // Changed from ListPart
    SourceTable = "Seminar Registration Header";
    Editable = false;
    CardPageId = "Seminar Registration";
    AutoSplitKey = true;
    UsageCategory = Administration;
    ApplicationArea = All;

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
                ToolTip = 'Executes the Seminar Registration action.';
            }
            action("Comments")
            {
                Caption = 'Comments';
                ApplicationArea = Comments;
                Image = ViewComments;
                RunObject = Page "Comment Sheet";
                ToolTip = 'Executes the Comments action.';
            }
            action(Charges)
            {
                ApplicationArea = Suite;
                Caption = 'Charges';
                Image = Calculate;
                RunObject = Page "Seminar Charges";
                ToolTip = 'Executes the Charges action.';
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
            action("Send E-mail Confirmations")
            {
                Caption = 'Confirmations';
                ApplicationArea = Basic, Suite;
                Image = Email;
                Promoted = true;
                PromotedCategory = Category5;
                RunObject = Codeunit "Seminar Mail";
                ToolTip = 'Executes the Confirmations action.';

                trigger OnAction()
                var
                    SeminarRegHeader: Record "Seminar Registration Header";
                    SeminarMail: Codeunit "Seminar Mail";
                begin
                    SeminarMail.SendAllConfirmations(SeminarRegHeader);
                end;
            }
            action(XMLParticipantList)
            {
                ApplicationArea = All;
                Caption = 'XML Participant List';
                Image = XMLFile;
                ToolTip = 'Executes the XML Participant List action.';

                trigger OnAction()
                var
                    SeminarRegHeader: Record "Seminar Registration Header";
                    SeminarXMLParticipantLIst: XmlPort "Sem. Reg.-Participant List";
                begin
                    SeminarRegHeader := Rec;
                    SeminarRegHeader.SetRecFilter();
                    SeminarXMLParticipantLIst.SetTableView(SeminarRegHeader);
                    SeminarXMLParticipantLIst.Run();
                end;
            }
            action(InstructorAllocation)
            {
                ApplicationArea = All;
                Caption = 'Instructor Allocation';
                Image = Allocate;
                RunObject = Page "Instructor Class Overview";
                ToolTip = 'Executes the Instructor Allocation action.';
            }
        }
    }
}
