#pragma warning disable LC0015
page 50003 "Seminar Room Card"
#pragma warning restore LC0015
{
    Caption = 'Seminar Room Card';
    PageType = Card;
    SourceTable = "Seminar Room";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Code"; Rec."Code")
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
                field(Address; Rec.Address)
                {
                    Caption = 'Address';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Address field.';
                }
                field("Address 2"; Rec."Address 2")
                {
                    Caption = 'Address 2';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Address 2 field.';
                }
                field(City; Rec.City)
                {
                    Caption = 'City';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the City field.';
                }
                field("Post Code"; Rec."Post Code")
                {
                    Caption = 'Post Code';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Post Code field.';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    Caption = 'Country/Region Code';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Country/Region Code field.';
                }
                field("Internal/External"; Rec."Internal/External")
                {
                    Caption = 'Internal/External';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Internal/External field.';
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
                field("Contact No."; Rec."Contact No.")
                {
                    Caption = 'Contact No.';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contact No. field.';
                }
            }
            group(Communication)
            {
                Caption = 'Communication';
                field("Phone No."; Rec."Phone No.")
                {
                    Caption = 'Phone No.';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Phone No. field.';
                }
                field("Telex No."; Rec."Telex No.")
                {
                    Caption = 'Telex No.';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Telex No. field.';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    Caption = 'E-Mail';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the E-Mail field.';
                }
                field("Home Page"; Rec."Home Page")
                {
                    Caption = 'Home Page';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Home Page field.';
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
                Caption = 'Seminar Room';
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
                    Caption = 'Extended Texts';
                    ApplicationArea = Suite;
                    Image = Text;
                    RunObject = Page "Extended Text List";
                    RunPageLink = "Table Name" = const("Seminar Room"),
                       "No." = field(Code);
                    ToolTip = 'Executes the Extended Texts action.';
                }
            }
        }
    }
}
