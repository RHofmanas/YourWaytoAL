 page 50101 "Course Information Page"
{
    ApplicationArea = All;
    Caption = 'Course Information Page';
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
            }
        }
    }
}
