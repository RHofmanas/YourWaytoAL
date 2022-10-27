#pragma warning disable LC0015
page 50005 "Seminar Card"
#pragma warning restore LC0015
{
    Caption = 'Seminar Card';
    PageType = Card;
    SourceTable = Seminar;
    UsageCategory = Administration;

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
                        if Rec.AssistEdit() then
                            CurrPage.Update();
                    end;
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
                field("Search Name"; Rec."Search Name")
                {
                    Caption = 'Search Name';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Search Name field.';
                }
                field("Minimum Participants"; Rec."Minimum Participants")
                {
                    Caption = 'Minimum Participants';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Minimum Participants field.';
                }
                field("Maximum Participants"; Rec."Maximum Participants")
                {
                    Caption = 'Maximimum Participants';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Maximimum Participants field.';
                }
                field(Blocked; Rec.Blocked)
                {
                    Caption = 'Blocked';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Blocked field.';
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    Caption = 'Last Date Modified';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Last Date Modified field.';
                }

            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
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
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    Caption = 'Gen. Prod. Posting Group';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Gen. Prod. Posting Group field.';
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    Caption = 'VAT Prod. Posting Group';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the VAT Prod. Posting Group field.';
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
                    RunObject = Page "Seminar Ledger Entries";
                    ToolTip = 'Executes the Entries action.';
                    //RunPageLink = "Seminar No." = field("No.");// "Posting Date" = ;
                }
                action(SeminarRegistrations)
                {
                    Caption = 'Registrations';
                    ApplicationArea = All;
                    RunObject = Page "Seminar Registration";
                    ToolTip = 'Executes the Registrations action.';
                    //RunPageLink = "Seminar Registration";
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Rec.SetRange("No.");
    end;
}