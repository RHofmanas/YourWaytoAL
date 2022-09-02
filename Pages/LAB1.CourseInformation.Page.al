page 50101 "Course List Page"
{
    ApplicationArea = All;
    Caption = 'Course List Page';
    PageType = List;
    SourceTable = "Course Information";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Difficulty; Rec.Difficulty)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Difficulty field.';
                }
                field("Duration"; Rec."Duration")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Duration field.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("Passing Rate"; Rec."Passing Rate")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Passing Rate field.';
                }
                field(Price; Rec.Price)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Price field.';
                }
                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("Active"; Rec.Active)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Active field.';
                }
                field("Level"; Level)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Level field.';
                }
                field("Suggestion"; Suggestion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Suggestion field.';
                }
                field("SPA"; SPA)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SPA field.';
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Level := '';
        Suggestion := '';
        SPA := False;
        CASE Rec.Difficulty OF
            1 .. 5:
                begin
                    Level := 'Beginner';
                    Suggestion := 'Take e-Learning or Remote training';
                end;
            6 .. 8:
                begin
                    Level := 'Intermediate';
                    Suggestion := 'Attend Instructor-led';
                end;
            9 .. 10:
                begin
                    Level := 'Advanced';
                    Suggestion := 'Attend Instructor-led and self study';
                end;
        END;
        If (Rec."Passing Rate" >= 70) and (Rec.Difficulty >= 6) Then SPA := True;
    end;

    var
        Level: Text[30];
        Suggestion: Text[80];
        SPA: Boolean;
}
