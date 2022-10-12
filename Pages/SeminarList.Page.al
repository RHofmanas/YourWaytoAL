page 50006 "Seminar List"
{
    Caption = 'Seminar List';
    PageType = List;
    SourceTable = Seminar;
    Editable = false;
    CardPageId = "Seminar Card";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    Caption = 'No.';
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    Caption = 'Name';
                    ApplicationArea = All;
                }
                field("Seminar Duration"; Rec."Seminar Duration")
                {
                    Caption = 'Seminar Duration';
                    ApplicationArea = All;
                }
                field("Minimum Participants"; Rec."Minimum Participants")
                {
                    Caption = 'Minimum Participants';
                    ApplicationArea = All;
                }
                field("Maximum Participants"; Rec."Maximum Participants")
                {
                    Caption = 'Maximum Participants';
                    ApplicationArea = All;
                }
                field("Seminar Price"; Rec."Seminar Price")
                {
                    Caption = 'Seminar Price';
                    ApplicationArea = All;
                }
                field("Job No."; Rec."Job No.")
                {
                    Caption = 'Job No.';
                    ApplicationArea = All;
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
            group(SeminarCardSetupContainer)
            {
                Caption = 'Related Information';
                Image = RelatedInformation;
                group(Seminar)
                {
                    Caption = 'Seminar';
                    action("Comments")
                    {
                        Caption = 'Comments';
                        ApplicationArea = Comments;
                        Image = ViewComments;
                        RunObject = Page "Comment Sheet";
                        RunPageLink = "Table Name" = const("Seminar"), "No." = field("No.");
                    }
                    action("Extended Texts")
                    {
                        Caption = 'Extended Texts';
                        ApplicationArea = Suite;
                        Image = Text;
                        RunObject = Page "Extended Text List";
                        RunPageLink = "Table Name" = const("Seminar"), "No." = field("No.");
                    }
                }
            }
        }
    }
}
