pageextension 50000 "Source Code Setup Ext" extends "Source Code Setup"
{
    layout
    {
        addlast(Content)
        {
            group(SeminarGroup)
            {
                Caption = 'Seminar Group';
                field(Seminar; Rec.Seminar)
                {
                    Caption = 'Seminar';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Source Code of the Seminar application';
                }
            }
        }
    }
}



