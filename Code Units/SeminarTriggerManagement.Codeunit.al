#pragma warning disable LC0015
codeunit 50010 "Seminar Trigger Management"
#pragma warning restore LC0015
{
    TableNo = "Job Journal Line";

    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Jnl.-Post Line", 'OnBeforeJobLedgEntryInsert', '', false, false)]

    local procedure OnBeforeJobLedgEntryInsert(JobJournalLine: Record "Job Journal Line";
        var JobLedgerEntry: Record "Job Ledger Entry")
    begin
        JobLedgerEntry."Seminar Registration No." := JobJournalLine."Seminar Registration No.";    // <--- Changed from "Seminar Registre Code"
    end;
}
