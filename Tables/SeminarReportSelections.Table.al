
#pragma warning disable LC0015
table 50014 "Seminar Report Selections"
#pragma warning restore LC0015

{
    Caption = 'Seminar Report Selections';
    DataClassification = SystemMetadata;
    DataPerCompany = false;

    fields
    {
        field(1; Usage; Enum "Seminar Report Selections")
        {
            Caption = 'Usage';
        }
        field(2; Sequence; Code[10])
        {
            Caption = 'Sequence';
        }
        field(3; "Report ID"; Integer)
        {
            Caption = 'Report ID';
            TableRelation = Object.ID where(Type = const(Report));
            trigger OnValidate()
            begin
                CalcFields("Report Name");
            end;
        }
        field(4; "Report Name"; Text[250])
        {
            Caption = 'Report Name';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup(AllObjWithCaption."Object Caption"
                where("Object Type" = const(Report), "Object ID" = field("Report ID")));
        }
    }

    keys
    {
        key(PK; Usage, Sequence)
        {
            Clustered = true;
        }
    }

    procedure NewRecord()
    begin
        SetRange(Usage, Usage::"S. Registration");
        if FindLast() and (not (Sequence = '')) then
            Sequence := IncStr(Sequence)
        else
            Sequence := '1';
    end;
}
