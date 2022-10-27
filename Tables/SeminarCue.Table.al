
#pragma warning disable LC0015
table 50007 "Seminar Cue"
#pragma warning restore LC0015

{
    Caption = 'Seminar Cue';
    DataClassification = AccountData;
    LookupPageId = "Seminar Activities";

    fields
    {
        field(1; Code; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; "Active Seminars"; Integer)
        {
            Caption = 'Active Seminars';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("Seminar Registration Header"
                where(Status = const(Registration)));
        }
        field(3; "Todays Seminars"; Integer)
        {
            Caption = 'Todays Seminars';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("Seminar Registration Header"
                where(Status = const(Registration), "Starting Date" = field("Today Date filter")));
        }
        field(4; "Upcoming Seminars"; Integer)
        {
            Caption = 'Upcoming Seminars';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("Seminar Registration Header"
                where(Status = const(Registration), "Starting Date" = field("Next Week Date Filter")));
        }
        field(100; "Next Week Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(101; "Today Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
