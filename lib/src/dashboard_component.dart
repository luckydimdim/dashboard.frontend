import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:resources_loader/resources_loader.dart';
import 'package:chartjs/chartjs.dart';

import 'dart:html';
import 'dart:math' as math;

@Component(selector: 'dashboard',
    templateUrl: 'dashboard_component.html')
class DashboardComponent implements OnInit {
  static const String route_name = 'Dashboard';
  static const String route_path = 'dashboard';
  static const Route route = const Route(
      path: DashboardComponent.route_path,
      component: DashboardComponent,
      name: DashboardComponent.route_name,
      useAsDefault: true);

  final Router _router;
  final ResourcesLoaderService _resourcesLoaderService;

  DashboardComponent(this._router, this._resourcesLoaderService) {}

  @override
  void ngOnInit() {
    _resourcesLoaderService.loadScript(
        'vendor/chart.js/dist/', 'Chart.min.js', false, onData: initMainChart);
  }

  void initMainChart() {

    var brandInfo = '#63c2de';
    var brandSuccess =  '#4dbd74';

    var xAxes = new List<ChartXAxe> ();
    xAxes.add(
        new ChartXAxe(gridLines: new GridLineOptions(drawOnChartArea: false)));

    var yAxes = new List<ChartYAxe> ();
    yAxes.add(new ChartYAxe(ticks: new LinearTickOptions(
        beginAtZero: true, maxTicksLimit: 5, stepSize: 1000000, max: 6700000)));

    var chartScales = new ChartScales(xAxes: xAxes, yAxes: yAxes);

    var legend = new ChartLegendOptions(display: false);

    var chartElementsOptions = new ChartElementsOptions(point: new ChartPointOptions(radius: 0, hitRadius: 10,hoverRadius: 4, hoverBorderWidth: 3 ));

    var chartOptions = new ChartOptions(responsive: true,
        maintainAspectRatio: false,
        legend: legend,
        scales: chartScales,
        elements: chartElementsOptions
    );

    var data1 = <int>[700000, 1000000, 1100000, 1200000, 1700000, 2700000, 3700000, 4200000, 4700000, 5200000, 5700000, 6200000];
    var data2 = <int>[700000, 1000000, 1100000, 1200000, 1700000, 2650000, 3650000, 4100000, 4200000, 4700000, 5200000, 5700000];

    var data = new LinearChartData(labels: <String>['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12'],
        datasets: <ChartDataSets>[
      new ChartDataSets(
          label: 'My First dataset',
          backgroundColor: 'rgba(99,194,222,0.1)',//convertHex($.brandInfo,10),
          borderColor: brandInfo,
          pointHoverBackgroundColor: '#fff',
          borderWidth: 2,
          data: data1),
      new ChartDataSets(
          label: 'My Second dataset',
          backgroundColor: 'transparent',
          borderColor: brandSuccess,
          pointHoverBackgroundColor: '#fff',
          borderWidth: 2,
          data: data2)
    ]);


    var config = new ChartConfiguration(
        type: 'line', data: data, options: chartOptions);

    new Chart(querySelector('#main-chart') as CanvasElement, config);
  }
}
