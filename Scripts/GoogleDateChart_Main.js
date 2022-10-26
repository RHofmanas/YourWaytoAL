function createDateChart(json)
{
    console.log(json);
    
    google.charts.load("current", {packages:["calendar"],'language': 'da'});
    google.charts.setOnLoadCallback(drawChart);
    
    function drawChart(){
        var data = new google.visualization.arrayToDataTable(json);
        var chart = new google.visualization.Calendar(document.getElementById('controlAddIn'));
        var options = {
            title: "Instructor allocation",
            height: 450,
            calender:{ cellSize: 13,
                underYearSpace: 10,
                dayOfWeekRightSpace: 10,
                daysOfWeek: 'SMTWTFS',
                daysOfWeekLabel: {
                    fontName: 'Segoe UI',
                    fontSize: 7,
                    color: '#A7ADB6',
                    bold: false,
                },
                yearLabel: {
                    fontName: 'Segoe UI',
                    fontSize: 20,
                    color: '#00B7C3',
                    bold: true,
                },
                noDataPattern: {
                    backgroundColor: '#75D8E7',
                    color: '#505C6D'
                }
            }
        };
        chart.draw(data, options);
        google.visualization.events.addListener(chart, 'select', selectHandler);

        function selectHandler(){
            var selection = chart.getSelection();
            var message = '';
            for(var i = 0; i < selection.length; i++){
                var item = selection[i];
                if (item.row != null){
                    var str = data.getFormattedValue(item.row, 0);
                    message += str;
                }
            }
            if (message != '') {
                CallBackBc(message);
            }
        }
    }

}
function refresh()
{
    document.location.refresh();
}

function CallBackBc(message)
{
    Microsoft.Dynamics.NAV.InvokeExtensibilityMethod("callbackBC", [message]);
}