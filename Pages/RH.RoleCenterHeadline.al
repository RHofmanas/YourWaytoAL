page 50120 RoleCenterHeadline
{
    PageType = HeadLinePart;

    layout
    {
        area(content)
        {
            field(Headline1; hdl1Txt)
            {
                ApplicationArea = all;

            }
            field(Headline2; hdl2Txt)
            {

            }
            field(Headline3; hdl3Txt)
            {

            }
            field(Headline4; hdl4Txt)
            {

            }
        }
    }

    var
        hdl1Txt: Label 'This is My Wonderful Role Center';
        hdl2Txt: Label 'This is headline 2';
        hdl3Txt: Label 'This is headline 3';
        hdl4Txt: Label 'This is headline 4';
}