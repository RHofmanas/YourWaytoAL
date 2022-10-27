
#pragma warning disable LC0015
page 50103 "Object Runner"
#pragma warning restore LC0015

{
    Caption = 'Object Runner';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;

    actions
    {
        area(Processing)
        {
            action("Run Codeunit")
            {
                Caption = 'Run Codeunit';
                ApplicationArea = all;
                Image = Action;
                ToolTip = 'Executes the Run Codeunit action.';
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
