page 50009 "Seminar Registration"
{
    Caption = 'Seminar Registration';
    PageType = Card;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Seminar Registration Header";
    Permissions = tabledata "Seminar Registration Header" = RIDM;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    Caption = 'No.';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    Caption = 'Starting Date';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Starting Date field.';
                }
                field("Seminar No."; Rec."Seminar No.")
                {
                    Caption = 'Seminar No.';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Seminar No. field.';
                }
                field("Seminar Name"; Rec."Seminar Name")
                {
                    Caption = 'Seminar Name';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Seminar Name field.';
                }
                field("Instructor Code"; Rec."Instructor Code")
                {
                    Caption = 'Instructor Code';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Instructor Code field.';
                }
                field("Instructor Name"; Rec."Instructor Name")
                {
                    Caption = 'Instructor Name';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Instructor Name field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    Caption = 'Document Date';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Date field.';
                }
                field(Status; Rec.Status)
                {
                    Caption = 'Status';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Duration"; Rec."Duration")
                {
                    Caption = 'Duration';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Duration field.';
                }
                field("Minimum Participants"; Rec."Minimum Participants")
                {
                    Caption = 'Minimum Participants';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Minimum Participants field.';
                }
                field("Maximum Participants"; Rec."Maximum Participants")
                {
                    Caption = 'Maximum Participants';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Maximum Participants field.';
                }
            }
            part(SeminarRegistrationLines; "Seminar Registration Subpage")
            {
                Caption = 'Lines';
                ApplicationArea = All;
                SubPageLink = "Seminar Registration No." = field("No.");
            }
            group("Seminar Room")
            {
                Caption = 'Seminar Room';
                field("Seminar Room Code"; Rec."Seminar Room Code")
                {
                    Caption = 'Seminar Room Code';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of Seminar Room.';
                }
                field("Seminar Room Name"; Rec."Seminar Room Name")
                {
                    Caption = 'Seminar Room Name';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of Seminar Room Name.';
                }
                field("Seminar Room Address"; Rec."Seminar Room Address")
                {
                    Caption = 'Seminar Room Address';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of Seminar Room Address.';
                }
                field("Seminar Room Post Code"; Rec."Seminar Room Post Code")
                {
                    Caption = 'Seminar Room Post Code';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of Seminar Room Post Code.';

                }
                field("Seminar Room City"; Rec."Seminar Room City")
                {
                    Caption = 'Seminar Room City';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of Seminar Room City.';

                }
                field("Seminar Room Phone No."; Rec."Seminar Room Phone No.")
                {
                    Caption = 'Seminar Room Phone No.';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of Seminar Room Phone No.';

                }
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                field("Seminar Price"; Rec."Seminar Price")
                {
                    Caption = 'Seminar Price';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of Seminar Price.';

                }
                field("Job No."; Rec."Job No.")
                {
                    Caption = 'Job No.';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of Job No.';
                }
            }
        }
        area(FactBoxes)
        {
            systempart(Links; Links)
            {
                ApplicationArea = RecordLinks;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = Notes;
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
                RunObject = page "Comment Sheet";
                RunPageLink = "Table Name" = const("Seminar Registration Header"), "No." = field("No.");
                ToolTip = 'Executes the Comments action.';
            }
            action(Charges)
            {
                ApplicationArea = Suite;
                Caption = 'Charges';
                Image = IssueFinanceCharge;
                RunObject = page "Seminar Charges";
                RunPageLink = "Seminar Registration no." = field("No.");
                ToolTip = 'View the Seminar Charges for the record';
            }
            action(Posting)
            {
                ApplicationArea = Suite;
                Caption = 'P&ost';
                Image = Post;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                ShortCutKey = 'F9';
                RunObject = codeunit "Seminar-Post";
                ToolTip = 'Post Seminar';
            }
            action(Print)
            {
                ApplicationArea = Suite;
                Caption = 'Print';
                Image = Print;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                RunObject = report "Participant List";
                ToolTip = 'Executes the Print action.';
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
                RunPageLink = code = field("Instructor Code");
                ToolTip = 'Executes the Instructor Allocation action.';

            }
        }
    }
}

