#pragma warning disable LC0015
codeunit 50000 "Seminar Reg.-Show Ledger"
#pragma warning restore LC0015
{
    TableNo = "Seminar Register";

    trigger OnRun()
    begin
        SeminarLedgerEntry.SetRange("Entry No.", Rec."From Entry No.", Rec."To Entry No.");
        Page.Run(Page::"Seminar Ledger Entries", SeminarLedgerEntry);
    end;

    var
        SeminarLedgerEntry: Record "Seminar Ledger Entry";
}
