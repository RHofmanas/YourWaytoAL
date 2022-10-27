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
    procedure RunCheck(var SeminarJnlLine: Record "Seminar Journal Line")
#pragma warning restore LC0010
    var
        UserSetup: Record "User Setup";
        GLSetup: Record "General Ledger Setup";
    begin
        if SeminarJnlLine.EmptyLine then
            exit;

        SeminarJnlLine.TestField("Job No.", ErrorInfo.Create(Text000, true));
        SeminarJnlLine.TestField("Posting Date", ErrorInfo.Create(Text000, true));
        SeminarJnlLine.TestField("Seminar No.", ErrorInfo.Create(Text000, true));

        case SeminarJnlLine."Option Type" of
            "Option Type"::Instructor:
                SeminarJnlLine.TestField("Instructor Code", ErrorInfo.Create(Text000, true));
            "Option Type"::Room:
                SeminarJnlLine.TestField("Seminar Room Code", ErrorInfo.Create(Text000, true));
            "Option Type"::Participant:
                SeminarJnlLine.TestField("Participant Contact No.", ErrorInfo.Create(Text000, true));
        end;

        if SeminarJnlLine.Chargeable then
            SeminarJnlLine.TestField("Bill-to Customer No.", ErrorInfo.Create(Text000, true));

        if SeminarJnlLine."Posting Date" <> NormalDate(SeminarJnlLine."Posting Date") then
            SeminarJnlLine.FieldError("Posting Date", ErrorInfo.Create(Text001, true));

        UserSetup.Get(UserId()); // <---------------------------------------------------------

        if (UserSetup."Allow Posting From" <> 0D) and (UserSetup."Allow Posting To" <> 0D) then begin
            if not ((SeminarJnlLine."Posting Date" >= UserSetup."Allow Posting From")
            and (SeminarJnlLine."Posting Date" <= UserSetup."Allow Posting To")) then
                SeminarJnlLine.FieldError("Posting Date", ErrorInfo.Create(Text002, true))
        end
        else begin
            GLSetup.Get();
            if (GLSetup."Allow Posting From" <> 0D) and (GLSetup."Allow Posting To" <> 0D) then begin
                if not ((SeminarJnlLine."Posting Date" >= GLSetup."Allow Posting From")
                and (SeminarJnlLine."Posting Date" <= GLSetup."Allow Posting To")) then
                    SeminarJnlLine.FieldError("Posting Date", ErrorInfo.Create(Text002, true));
            end
            else begin
                GLSetup.TestField("Allow Posting From", 0D, ErrorInfo.Create(Text000, true));
                GLSetup.TestField("Allow Posting To", 0D, ErrorInfo.Create(Text000, true));
            end;
        end;

        if SeminarJnlLine."Document Date" <> NormalDate(SeminarJnlLine."Document Date") then
            SeminarJnlLine.FieldError("Document Date", ErrorInfo.Create(Text001, true));
    end;

    var
        Text000: Label 'Must not be blank';
        Text001: Label 'Cannot be a closing date';
        Text002: Label 'Must be within allowed period';
}
