table 50103 "Course Information"
{
    Caption = 'Course Information';
    DataClassification = ToBeClassified;

    fields
    {
        field(10; "Code"; Code[10])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(20; Name; Text[100])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(30; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(40; "Type"; Enum "Training Type")
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
        }
        field(50; "Duration"; Decimal)
        {
            Caption = 'Duration';
            DataClassification = ToBeClassified;
        }
        field(60; Price; Decimal)
        {
            Caption = 'Price';
            DataClassification = ToBeClassified;
        }
        field(70; Active; Boolean)
        {
            Caption = 'Active';
            DataClassification = ToBeClassified;
        }
        field(80; Difficulty; Integer)
        {
            Caption = 'Difficulty';
            DataClassification = ToBeClassified;
        }
        field(90; "Passing Rate"; Integer)
        {
            Caption = 'Passing Rate';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
        key(key2; Name, Description, "Type", "Duration", Price, Active, Difficulty, "Passing Rate")
        {

        }
    }

}
