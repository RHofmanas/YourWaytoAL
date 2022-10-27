#pragma warning disable LC0015
codeunit 50001 "Seminar Jnl.-Check Line"
#pragma warning restore LC0015
{
    TableNo = "Seminar Journal Line";

    trigger OnRun()
    begin
        RunCheck(Rec);
    end;

#pragma warning disable LC0010
    procedure RunCheck(var SeminarJournalLine: Record "Seminar Journal Line")
#pragma warning restore LC0010
    var
        UserSetup: Record "User Setup";
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin
        if SeminarJournalLine.EmptyLine() then
            exit;

        SeminarJournalLine.TestField("Job No.", ErrorInfo.Create(Text000Lbl, true));
        SeminarJournalLine.TestField("Posting Date", ErrorInfo.Create(Text000Lbl, true));
        SeminarJournalLine.TestField("Seminar No.", ErrorInfo.Create(Text000Lbl, true));

        case SeminarJournalLine."Option Type" of
            "Option Type"::Instructor:
                SeminarJournalLine.TestField("Instructor Code", ErrorInfo.Create(Text000Lbl, true));
            "Option Type"::Room:
                SeminarJournalLine.TestField("Seminar Room Code", ErrorInfo.Create(Text000Lbl, true));
            "Option Type"::Participant:
                SeminarJournalLine.TestField("Participant Contact No.", ErrorInfo.Create(Text000Lbl, true));
        end;

        if SeminarJournalLine.Chargeable then
            SeminarJournalLine.TestField("Bill-to Customer No.", ErrorInfo.Create(Text000Lbl, true));

        if SeminarJournalLine."Posting Date" <> NormalDate(SeminarJournalLine."Posting Date") then
            SeminarJournalLine.FieldError("Posting Date", ErrorInfo.Create(Text001Lbl, true));

        UserSetup.Get(UserId()); // <---------------------------------------------------------

        if (UserSetup."Allow Posting From" <> 0D) and (UserSetup."Allow Posting To" <> 0D) then begin
            if not ((SeminarJournalLine."Posting Date" >= UserSetup."Allow Posting From")
            and (SeminarJournalLine."Posting Date" <= UserSetup."Allow Posting To")) then
                SeminarJournalLine.FieldError("Posting Date", ErrorInfo.Create(Text002Lbl, true))
        end
        else begin
            GeneralLedgerSetup.Get();
            if (GeneralLedgerSetup."Allow Posting From" <> 0D) and (GeneralLedgerSetup."Allow Posting To" <> 0D) then begin
                if not ((SeminarJournalLine."Posting Date" >= GeneralLedgerSetup."Allow Posting From")
                and (SeminarJournalLine."Posting Date" <= GeneralLedgerSetup."Allow Posting To")) then
                    SeminarJournalLine.FieldError("Posting Date", ErrorInfo.Create(Text002Lbl, true));
            end
            else begin
                GeneralLedgerSetup.TestField("Allow Posting From", 0D, ErrorInfo.Create(Text000Lbl, true));
                GeneralLedgerSetup.TestField("Allow Posting To", 0D, ErrorInfo.Create(Text000Lbl, true));
            end;
        end;

        if SeminarJournalLine."Document Date" <> NormalDate(SeminarJournalLine."Document Date") then
            SeminarJournalLine.FieldError("Document Date", ErrorInfo.Create(Text001Lbl, true));
    end;

    var
        Text000Lbl: Label 'Must not be blank';
        Text001Lbl: Label 'Cannot be a closing date';
        Text002Lbl: Label 'Must be within allowed period';
}
