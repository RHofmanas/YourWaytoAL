page 50005 "Seminar Card"
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
                }
                field("Seminar Duration"; Rec."Seminar Duration")
                {
                    Caption = 'Seminar Duration';
                    ApplicationArea = All;
                }
                field("Search Name"; Rec."Search Name")
                {
                    Caption = 'Search Name';
                    ApplicationArea = All;
                }
                field("Minimum Participants"; Rec."Minimum Participants")
                {
                    Caption = 'Minimum Participants';
                    ApplicationArea = All;
                }
                field("Maximum Participants"; Rec."Maximum Participants")
                {
                    Caption = 'Maximimum Participants';
                    ApplicationArea = All;
                }
                field(Blocked; Rec.Blocked)
                {
                    Caption = 'Blocked';
                    ApplicationArea = All;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    Caption = 'Last Date Modified';
                    ApplicationArea = All;
                }

            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
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
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    Caption = 'Gen. Prod. Posting Group';
                    ApplicationArea = All;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    Caption = 'VAT Prod. Posting Group';
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
    trigger OnAfterGetRecord()
    begin
        Rec.SetRange("No.");
    end;
}