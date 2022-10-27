#pragma warning disable LC0015
page 50014 "Seminar Registers"
#pragma warning restore LC0015
{
    ApplicationArea = All;
    Caption = 'Seminar Registers';
    PageType = List;
    SourceTable = "Seminar Register";
    UsageCategory = History;
    Editable = false;

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
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Creation Date field.';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User ID field.';
                }
                field("Source Code"; Rec."Source Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Source Code field.';
                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Journal Batch Name field.';
                }
                field("From Entry No."; Rec."From Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the From Entry No. field.';
                }
                field("To Entry No."; Rec."To Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the To Entry No. field.';
                }
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            action(Register)
            {
                Caption = 'Register';
                Image = Register;
                ApplicationArea = Suite;
                RunObject = Codeunit "Seminar Reg.-Show Ledger";
                ToolTip = 'Executes the Register action.';
            }
        }
    }
}
