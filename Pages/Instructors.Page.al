page 50001 Instructors
{
    ApplicationArea = All;
    Caption = 'Instructors';
    PageType = List;
    SourceTable = Instructor;

    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
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
                field("Type"; Rec."Type")
                {
                    Caption = 'Type';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field.';
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
        }
    }
}
