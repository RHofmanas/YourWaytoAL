page 50103 "Object Runner"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;

    actions
    {
        area(Processing)
        {
            Action("Run Codeunit")
            {
                Caption = 'Run Codeunit';
                ApplicationArea = all;
                //RunObject = Codeunit ######; will NOT work if Codeunit has a TableNo!!
                trigger OnAction()
                var
                    Rec: Record "Seminar Registration Header"; // TableNo of the Codeunit
                    TestUnit: Codeunit "Seminar-Post(Yes/No)"; // Codeunit to test
                begin
                    Rec.Init();
                    TestUnit.Run(Rec);
                end;
            }
        }
    }


}

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