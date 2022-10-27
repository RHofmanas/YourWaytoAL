#pragma warning disable LC0015
codeunit 50021 "Seminar-Post(Yes/No)"
#pragma warning restore LC0015
{
    TableNo = "Seminar Registration Header";

    trigger OnRun()
    begin
        SeminarRegHeader := Rec;
        Code();
        Rec := SeminarRegHeader;
    end;

    local procedure Code()
    var
        Question: Text;
        Answer: Boolean;
        Text000: Label 'Post the registration?';
    begin
        Question := Text000;
#pragma warning disable LC0021
        Answer := Dialog.Confirm(Question, true);
#pragma warning restore LC0021
        if not Answer then exit;
        SeminarPost.Run(SeminarRegHeader);
#pragma warning disable LC0002
        Commit();
#pragma warning restore LC0002
    end;

    var
        SeminarRegHeader: Record "Seminar Registration Header";
        SeminarPost: Codeunit "Seminar-Post";
}
