codeunit 50002 "Seminar Jnl.-Post Line"
{
    TableNo = "Seminar Journal Line";

    trigger OnRun()
    begin
        RunWithCheck(Rec);
    end;

    procedure RunWithCheck(var SeminarJnlLine2: Record "Seminar Journal Line"): integer
    var
        JobLedgEntryNo: Integer;
    begin
        SeminarJnlLine.Copy(SeminarJnlLine2);
        JobLedgEntryNo := Code();
        SeminarJnlLine2 := SeminarJnlLine;
        exit(JobLedgEntryNo);
    end;
    /*
        procedure RunWithCheck(var JobJnlLine2: Record "Job Journal Line"): Integer
        var
            JobLedgEntryNo: Integer;
        begin
            OnBeforeRunWithCheck(JobJnlLine2);

            JobJnlLine.Copy(JobJnlLine2);
            JobLedgEntryNo := Code(true);
            JobJnlLine2 := JobJnlLine;
            exit(JobLedgEntryNo);
        end;
    */
    procedure Code(): Integer
    begin
        if SeminarJnlLine.EmptyLine then
            exit;

        SeminarJnlCheckLine.RunCheck(SeminarJnlLine);

        if NextEntryNo = 0 then begin
            SeminarLedgEntry.LockTable();
            NextEntryNo := SeminarLedgEntry.GetLastEntryNo() + 1;
        end;

        if SeminarJnlLine."Document Date" = 0D then
            SeminarJnlLine."Document Date" := SeminarJnlLine."Posting Date";

        if SeminarRegister."No." = 0 then begin
            SeminarRegister.LockTable();
            if (not SeminarRegister.FindLast) or (SeminarRegister."To Entry No." <> 0) then begin
                SeminarRegister.Init();
                SeminarRegister."No." := SeminarRegister."No." + 1;
                SeminarRegister."From Entry No." := NextEntryNo;
                SeminarRegister."To Entry No." := NextEntryNo;
                SeminarRegister."Creation Date" := Today;
                SeminarRegister."Source Code" := SeminarJnlLine."Source Code";
                SeminarRegister."Journal Batch Name" := SeminarJnlLine."Journal Batch Name";
                SeminarRegister."User ID" := UserId;
                SeminarRegister.Insert();
            end;
        end;
        SeminarRegister."To Entry No." := NextEntryNo;
        SeminarRegister.Modify();

        SeminarLedgEntry.Init();
        SeminarLedgEntry.CopyFromSeminarJnlLine(SeminarJnlLine);
        SeminarLedgEntry."Total Price" := Round(SeminarLedgEntry."Total Price");
        SeminarLedgEntry."User ID" := UserId;
        SeminarLedgEntry."Entry No." := NextEntryNo;
        SeminarLedgEntry.Insert(true);
        NextEntryNo := NextEntryNo + 1;
        exit(NextEntryNo);
    end;




    var
        SeminarJnlLine: Record "Seminar Journal Line";
        SeminarLedgEntry: Record "Seminar Ledger Entry";
        SeminarRegister: Record "Seminar Register";
        SeminarJnlCheckLine: Codeunit "Seminar Jnl.-Check Line";
        NextEntryNo: Integer;
}
