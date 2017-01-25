    /*****
     * CONFIGURATION
     */
    //Main navigation
    $.navigation = $('nav > ul.nav');

    $.panelIconOpened = 'icon-arrow-up';
    $.panelIconClosed = 'icon-arrow-down';

    //Default colours
    $.brandPrimary =  '#20a8d8';
    $.brandSuccess =  '#4dbd74';
    $.brandInfo =     '#63c2de';
    $.brandWarning =  '#f8cb00';
    $.brandDanger =   '#f86c6b';

    $.grayDark =      '#2a2c36';
    $.gray =          '#55595c';
    $.grayLight =     '#818a91';
    $.grayLighter =   '#d1d4d7';
    $.grayLightest =  '#f8f9fa';

    //convert Hex to RGBA
    function convertHex(hex, opacity){
        hex = hex.replace('#','');
        var r = parseInt(hex.substring(0,2), 16);
        var g = parseInt(hex.substring(2,4), 16);
        var b = parseInt(hex.substring(4,6), 16);

        var result = 'rgba('+r+','+g+','+b+','+opacity/100+')';
        return result;
    }

    //Random Numbers
    function random(min, max) {
        return Math.floor(Math.random()*(max-min+1)+min);
    }

    //Main Chart
    var elements = 27;
    var data1 = [];
    var data2 = [];
    var data3 = [];

    for (var i = 0; i <= elements; i++) {
        //data1.push(random(700000, 6000000));
        //data2.push(random(1200000, 3000000));
        //data3.push(2700000);
    }

    data1 = [700000, 1000000, 1100000, 1200000, 1700000, 2700000, 3700000, 4200000, 4700000, 5200000, 5700000, 6200000];
    data2 = [700000, 1000000, 1100000, 1200000, 1700000, 2650000, 3650000, 4100000, 4200000, 4700000, 5200000, 5700000];

    var data = {
        labels: ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12'],
        datasets: [
            {
                label: 'My First dataset',
                backgroundColor: convertHex($.brandInfo,10),
                borderColor: $.brandInfo,
                pointHoverBackgroundColor: '#fff',
                borderWidth: 2,
                data: data1
            },
            {
                label: 'My Second dataset',
                backgroundColor: 'transparent',
                borderColor: $.brandSuccess,
                pointHoverBackgroundColor: '#fff',
                borderWidth: 2,
                data: data2
            },
            {
                label: 'My Third dataset',
                backgroundColor: 'transparent',
                borderColor: $.brandDanger,
                pointHoverBackgroundColor: '#fff',
                borderWidth: 1,
                borderDash: [8, 5],
                data: data3
            }
        ]
    };

    var options = {
        responsive: true,
        maintainAspectRatio: false,
        legend: {
            display: false
        },
        scales: {
            xAxes: [{
                gridLines: {
                    drawOnChartArea: false,
                }
            }],
            yAxes: [{
                ticks: {
                    beginAtZero: true,
                    maxTicksLimit: 5,
                    stepSize: 1000000,
                    max: 6700000
                }
            }]
        },
        elements: {
            point: {
                radius: 0,
                hitRadius: 10,
                hoverRadius: 4,
                hoverBorderWidth: 3,
            }
        },
    };
    var ctx = $('#main-chart');
    var mainChart = new Chart(ctx, {
        type: 'line',
        data: data,
        options: options
    });