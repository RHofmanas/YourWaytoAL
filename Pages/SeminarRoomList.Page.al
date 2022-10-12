page 50004 "Seminar Room List"
{
    Caption = 'Seminar Room List';
    PageType = List;
    CardPageId = "Seminar Room Card";
    SourceTable = "Seminar Room";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; rec.Code)
                {
                    Caption = 'Code';
                    ApplicationArea = All;
                }
                field("Name"; rec.Name)
                {
                    Caption = 'Name';
                    ApplicationArea = All;
                }
                field("Maximum Participants"; rec."Maximum Participants")
                {
                    Caption = 'Maximum Participants';
                    ApplicationArea = All;
                }
                field("Resource No."; rec."Resource No.")
                {
                    Caption = 'Resource No.';
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
            group("Related Information")
            {
                caption = 'Related Information';
                Image = RelatedInformation;
                group("Seminar Room")
                {
                    Caption = 'Seminar Room';
                    Image = BookingsLogo;
                    action("Comments")
                    {
                        Caption = 'Comments';
                        ApplicationArea = Comments;
                        Image = ViewComments;
                        RunObject = Page "Comment Sheet";
                        RunPageLink =
                        "Table Name" = const("Seminar Room"),
                        "No." = field(Code);
                    }
                    action("Extended Texts")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Extended Texts';
                        Image = Text;
                        RunObject = Page "Extended Text List";
                        RunPageLink =
                        "Table Name" = const("Seminar Room"),
                        "No." = field(Code);
                    }
                }
            }
        }
    }
}
