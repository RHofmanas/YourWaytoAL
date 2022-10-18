codeunit 50000 "Seminar Reg.-Show Ledger"
{
    TableNo = "Seminar Register";

    trigger OnRun()
    begin
        SemLedgEntry.SetRange("Entry No.", Rec."From Entry No.", Rec."To Entry No.");
        Page.Run(Page::"Seminar Ledger Entries", SemLedgEntry);
    end;

    var
        SemLedgEntry: Record "Seminar Ledger Entry";
}
