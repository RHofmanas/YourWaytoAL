#pragma warning disable LC0015
codeunit 50002 "Seminar Jnl.-Post Line"
#pragma warning restore LC0015
{
    TableNo = "Seminar Journal Line";

    trigger OnRun()
    begin
        RunWithCheck(Rec);
    end;

    procedure RunWithCheck(var SeminarJournalLine2: Record "Seminar Journal Line"): Integer
    var
        JobLedgEntryNo: Integer;
    begin
        SeminarJournalLine.Copy(SeminarJournalLine2);
        JobLedgEntryNo := Code();
        SeminarJournalLine2 := SeminarJournalLine;
        exit(JobLedgEntryNo);
    end;

    procedure Code(): Integer
    begin
        if SeminarJournalLine.EmptyLine() then
            exit;

        SeminarJnlCheckLine.RunCheck(SeminarJournalLine);

        if NextEntryNo = 0 then begin
            SeminarLedgerEntry.LockTable();
            NextEntryNo := SeminarLedgerEntry.GetLastEntryNo() + 1;
        end;

        if SeminarJournalLine."Document Date" = 0D then
            SeminarJournalLine."Document Date" := SeminarJournalLine."Posting Date";

        if SeminarRegister."No." = 0 then begin
            SeminarRegister.LockTable();
            if (not SeminarRegister.FindLast()) or (SeminarRegister."To Entry No." <> 0) then begin
                SeminarRegister.Init();
                SeminarRegister."No." := SeminarRegister."No." + 1;
                SeminarRegister."From Entry No." := NextEntryNo;
                SeminarRegister."To Entry No." := NextEntryNo;
                SeminarRegister."Creation Date" := Today();
                SeminarRegister."Source Code" := SeminarJournalLine."Source Code";
                SeminarRegister."Journal Batch Name" := SeminarJournalLine."Journal Batch Name";
                SeminarRegister."User ID" := CopyStr(UserId(), 1, MaxStrLen(SeminarRegister."User ID"));
                SeminarRegister.Insert();
            end;
        end;
        SeminarRegister."To Entry No." := NextEntryNo;
        SeminarRegister.Modify();

        SeminarLedgerEntry.Init();
        SeminarLedgerEntry.CopyFromSeminarJnlLine(SeminarJournalLine);
        SeminarLedgerEntry."Total Price" := Round(SeminarLedgerEntry."Total Price");
        SeminarLedgerEntry."User ID" := CopyStr(UserId(), 1, MaxStrLen(SeminarLedgerEntry."User ID"));
        SeminarLedgerEntry."Entry No." := NextEntryNo;
        SeminarLedgerEntry.Insert();
        NextEntryNo := NextEntryNo + 1;
        exit(NextEntryNo);
    end;

    var
        SeminarJournalLine: Record "Seminar Journal Line";
        SeminarLedgerEntry: Record "Seminar Ledger Entry";
        SeminarRegister: Record "Seminar Register";
        SeminarJnlCheckLine: Codeunit "Seminar Jnl.-Check Line";
        NextEntryNo: Integer;
}
