tableextension 50001 "Job Journal Line Extension" extends "Job Journal Line"
{
    fields
    {
        field(50000; "Seminar Registration No."; Code[20])
        {
            Caption = 'Seminar Registration No.';
            DataClassification = ToBeClassified;
        }
    }
}
