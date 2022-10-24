page 50019 "Report Selection-Seminar"
{
    Caption = 'Report Selection-Seminar';
    PageType = Worksheet;
    SourceTable = "Seminar Report Selections";
    UsageCategory = Administration;
    ApplicationArea = Basic, Suite;
    SaveValues = true;

    layout
    {
        area(content)
        {
            field(Usage; ReportUsage::Registration)
            {
                Caption = 'Usage';
                ApplicationArea = Basic, Suite;

                trigger OnValidate()
                begin
                    SetUsageFilter(true);
                    CurrPage.Update();
                end;
            }
            repeater(General)
            {
                field(Sequence; Rec.Sequence)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sequence field.';
                }
                field("Report ID"; Rec."Report ID")
                {
                    ApplicationArea = All;
                    LookupPageId = Objects;
                    ToolTip = 'Specifies the value of the Report ID field.';
                }
                field("Report Name"; Rec."Report Name")
                {
                    ApplicationArea = All;
                    DrillDown = false;
                    ToolTip = 'Specifies the value of the Report Name field.';
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.NewRecord();
    end;

    local procedure SetUsageFilter(ModifyRec: Boolean)
    begin
        if ModifyRec then
            if Rec.Modify() then;
        Rec.FilterGroup(2);
        if (ReportUsage = ReportUsage::Registration) then
            Rec.SetRange(Usage, Rec.Usage::"S. Registration");
        Rec.FilterGroup(0);
    end;

    var
        ReportUsage: Option ,Registration;
}
