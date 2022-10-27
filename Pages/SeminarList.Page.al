#pragma warning disable LC0015
page 50006 "Seminar List"
#pragma warning restore LC0015
{
    Caption = 'Seminar List';
    PageType = List;
    SourceTable = Seminar;
    Editable = false;
    CardPageId = "Seminar Card";
    AutoSplitKey = true;
    UsageCategory = Administration;
    ApplicationArea = all;

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
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Name; Rec.Name)
                {
                    Caption = 'Name';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("Seminar Duration"; Rec."Seminar Duration")
                {
                    Caption = 'Seminar Duration';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Seminar Duration field.';
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
                    ToolTip = 'Specifies the value of the Maximimum Participants field.';
                }
                field("Seminar Price"; Rec."Seminar Price")
                {
                    Caption = 'Seminar Price';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Seminar Price field.';
                }
                field("Job No."; Rec."Job No.")
                {
                    Caption = 'Job No.';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job No. field.';
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
        area(Navigation)
        {
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
                    ToolTip = 'Executes the Comments action.';
                }
                action("Extended Texts")
                {
                    Caption = 'Extended Texts';
                    ApplicationArea = Suite;
                    Image = Text;
                    RunObject = Page "Extended Text List";
                    RunPageLink = "Table Name" = const("Seminar"), "No." = field("No.");
                    ToolTip = 'Executes the Extended Texts action.';
                }
            }
            group(SeminarManagement)
            {
                Caption = 'Seminar Management';
                action(SeminarLedgerEntries)
                {
                    ShortcutKey = 'Ctrl+Shift+N';
                    Caption = 'Entries';
                    ApplicationArea = All;
                    Image = EntriesList;
                    RunObject = Page "Seminar Ledger Entries";
                    ToolTip = 'Executes the Entries action.';
                    //RunPageLink =
                }
                action(SeminarRegistrations)
                {
                    Caption = 'Registrations';
                    ApplicationArea = All;
                    Image = Registered;
                    RunObject = Page "Seminar Registration List";
                    ToolTip = 'Executes the Registrations action.';
                    //RunPageLink = 
                }
            }
        }
    }
}
