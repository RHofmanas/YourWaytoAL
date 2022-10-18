codeunit 50010 "Seminar Trigger Management"
{
    TableNo = "Job Journal Line";

    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, 1012, 'OnBeforeJobLedgEntryInsert', '', false, false)]

    local procedure OnBeforeJobLedgEntryInsert(JobJournalLine: Record "Job Journal Line";
        var JobLedgerEntry: Record "Job Ledger Entry")
    begin
        JobLedgerEntry."Seminar Registration No." := JobJournalLine."Seminar Registration No.";    // <--- Changed from "Seminar Registre Code"
    end;

}
