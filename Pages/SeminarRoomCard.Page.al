page 50003 "Seminar Room Card"
{
    Caption = 'Seminar Room Card';
    PageType = Card;
    SourceTable = "Seminar Room";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec."Code")
                {
                    Caption = 'Code';
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    Caption = 'Name';
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    Caption = 'Address';
                    ApplicationArea = All;
                }
                field("Address 2"; Rec."Address 2")
                {
                    Caption = 'Address 2';
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    Caption = 'City';
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code")
                {
                    Caption = 'Post Code';
                    ApplicationArea = All;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    Caption = 'Country/Region Code';
                    ApplicationArea = All;
                }
                field("Internal/External"; Rec."Internal/External")
                {
                    Caption = 'Internal/External';
                    ApplicationArea = All;
                }
                field("Maximum Participants"; Rec."Maximum Participants")
                {
                    Caption = 'Maximum Participants';
                    ApplicationArea = All;
                }
                field("Resource No."; Rec."Resource No.")
                {
                    Caption = 'Resource No.';
                    ApplicationArea = All;
                }
                field("Contact No."; Rec."Contact No.")
                {
                    Caption = 'Contact No.';
                    ApplicationArea = All;
                }
            }
            group(Communication)
            {
                field("Phone No."; Rec."Phone No.")
                {
                    Caption = 'Phone No.';
                    ApplicationArea = All;
                }
                field("Telex No."; Rec."Telex No.")
                {
                    Caption = 'Telex No.';
                    ApplicationArea = All;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    Caption = 'E-Mail';
                    ApplicationArea = All;
                }
                field("Home Page"; Rec."Home Page")
                {
                    Caption = 'Home Page';
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
            group("Seminar Room")
            {
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
                    Caption = 'Extended Texts';
                    ApplicationArea = Suite;
                    Image = Text;
                    RunObject = Page "Extended Text List";
                    RunPageLink = "Table Name" = const("Seminar Room"),
                       "No." = field(Code);
                }
            }
        }
    }
}
