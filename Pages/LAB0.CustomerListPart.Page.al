page 50107 "My Customer Subpage"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Comment Line";
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(Comments)
            {
                field(Date; rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Comment; rec.Comment)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}