table 50015 "Temp Instructor Load"
{
    Caption = 'Temp Instructor Load';
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "Instructor Code"; Code[10])
        {
            Caption = 'Instructor Code';
        }
        field(2; "Allocation Date"; Date)
        {
            Caption = 'Allocation Date';
        }
        field(3; "Seminar Registration"; Code[20])
        {
            Caption = 'Seminar Registration';
        }
        field(4; Allocation; Decimal)
        {
            Caption = 'Allocation';
        }
    }
    keys
    {
        key(PK; "Instructor Code", "Allocation Date", "Seminar Registration")
        {
            Clustered = true;
            SumIndexFields = Allocation;
        }
    }
}
