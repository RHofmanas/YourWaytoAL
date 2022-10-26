table 50015 "Temp Instructor Load"
{
    Caption = 'Temp Instructor Load';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Instructor Code"; Code[10])
        {
            Caption = 'Instructor Code';
            DataClassification = SystemMetadata;
        }
        field(2; "Allocation Date"; Date)
        {
            Caption = 'Allocation Date';
            DataClassification = SystemMetadata;
        }
        field(3; "Seminar Registration"; Code[20])
        {
            Caption = 'Seminar Registration';
            DataClassification = SystemMetadata;
        }
        field(4; Allocation; Decimal)
        {
            Caption = 'Allocation';
            DataClassification = SystemMetadata;
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
