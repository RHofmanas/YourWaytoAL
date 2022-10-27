
#pragma warning disable LC0015
page 50004 "Seminar Room List"
#pragma warning restore LC0015

{
    Caption = 'Seminar Room List';
    PageType = List;
    CardPageId = "Seminar Room Card";
    SourceTable = "Seminar Room";
    UsageCategory = Administration;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    Caption = 'Code';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Name; Rec.Name)
                {
                    Caption = 'Name';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("Maximum Participants"; Rec."Maximum Participants")
                {
                    Caption = 'Maximum Participants';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Maximum Participants field.';
                }
                field("Resource No."; Rec."Resource No.")
                {
                    Caption = 'Resource No.';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Resource No. field.';
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
                        ToolTip = 'Executes the Comments action.';
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
                        ToolTip = 'Executes the Extended Texts action.';
                    }
                }
            }
        }
    }
}
