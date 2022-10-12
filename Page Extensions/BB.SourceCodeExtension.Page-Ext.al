pageextension 50000 "Source Code Setup Ext" extends "Source Code Setup"

{
    layout
    {
        addlast(Content)
        {
            group(SeminarGroup)
            {
                Caption = 'Seminar';
                field(Seminar; Rec.Seminar)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Source Code of the Seminar application';
                }
            }
        }
    }
}

tableextension 50000 "Sourse Code Setup Ext" extends "Source Code Setup"
{
    fields
    {
        field(50000; Seminar; Code[10])
        {
            TableRelation = "Source Code Setup";
        }
    }
}



