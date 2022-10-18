tableextension 50002 "Job Ledger Entry Extension" extends "Job Ledger Entry"
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
