controladdin GoogleDateChart
{
    StartupScript = 'Scripts/GoogleDateChart_Start.js';
    Scripts = 'Scripts/GoogleDateChart_Main.js',
        'https://www.gstatic.com/charts/loader.js';
    StyleSheets = 'CSS/GoogleDateChart.css';
    HorizontalStretch = true;
    VerticalStretch = true;
    RequestedHeight = 300;
    VerticalShrink = false;
    HorizontalShrink = false;


    event ControlReady();

    event CallBackBC(message: text);

    procedure createDateChart(JsonArray: JsonArray);

    procedure refresh();
}