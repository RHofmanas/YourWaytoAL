#pragma warning disable LC0015
codeunit 50021 "Seminar-Post(Yes/No)"
#pragma warning restore LC0015
{
    TableNo = "Seminar Registration Header";

    trigger OnRun()
    begin
        SeminarRegistrationHeader := Rec;
        Code();
        Rec := SeminarRegistrationHeader;
    end;

    local procedure Code()
    var
        Question: Text;
        Answer: Boolean;
        Text000Lbl: Label 'Post the registration?';
    begin
        Question := Text000Lbl;
#pragma warning disable LC0021
        Answer := Dialog.Confirm(Question, true);
#pragma warning restore LC0021
        if not Answer then exit;
        SeminarPost.Run(SeminarRegistrationHeader);
#pragma warning disable LC0002
        Commit();
#pragma warning restore LC0002
    end;

    var
        SeminarRegistrationHeader: Record "Seminar Registration Header";
        SeminarPost: Codeunit "Seminar-Post";
}
