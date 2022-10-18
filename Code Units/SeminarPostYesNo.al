codeunit 50021 "Seminar-Post(Yes/No)"
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
        Answer := Dialog.Confirm(Question, true);
        if not Answer then exit;
        SeminarPost.Run(SeminarRegHeader);
        Commit();
    end;

    var
        SeminarRegHeader: Record "Seminar Registration Header";
        SeminarPost: Codeunit "Seminar-Post";
}
