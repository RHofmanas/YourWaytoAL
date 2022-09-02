page 50102 "Custom Page L3"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Item;

    actions
    {
        area(Processing)
        {

            Action("Run Codeunit I")
            {
                ApplicationArea = all;
                RunObject = codeunit Codeunit_I;
            }

            Action("Run Codeunit II")
            {
                ApplicationArea = all;
                RunObject = codeunit Codeunit_II;
            }

            Action("Run Codeunit III")
            {
                ApplicationArea = all;
                RunObject = codeunit Codeunit_III;
            }

        }
    }

}

