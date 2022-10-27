tableextension 50000 "Source Code Setup Ext" extends "Source Code Setup"
{
    fields
    {
        field(50000; Seminar; Code[10])
        {
            Caption = 'Seminar';
            TableRelation = "Source Code";
            DataClassification = CustomerContent;
        }
    }
}