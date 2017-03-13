import 'dart:async';
import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:resources_loader/resources_loader.dart';
import 'package:chartjs/chartjs.dart';
import 'package:gauge/gauge.dart';
import 'package:aside/aside_service.dart';
import 'package:aside/pane_types.dart';

import 'dart:html';
import 'dart:math' as math;

@Component(selector: 'dashboard', templateUrl: 'dashboard_component.html')
class DashboardComponent implements OnInit, OnDestroy {
  static const String route_name = 'Dashboard';
  static const String route_path = 'dashboard';
  static const Route route = const Route(
      path: DashboardComponent.route_path,
      component: DashboardComponent,
      name: DashboardComponent.route_name,
      useAsDefault: true);

  final Router _router;
  final AsideService _asideService;
  final ResourcesLoaderService _resourcesLoaderService;

  DashboardComponent(this._router, this._resourcesLoaderService,
      this._asideService) {}

  // import 'dart:html';
  void breadcrumbInit() {
  }

  @override
  Future ngOnInit() async {

    this._asideService.addPane(PaneType.Dashboard);

    breadcrumbInit();

    await _resourcesLoaderService.loadScriptAsync(
        'packages/dashboard/src/bower_components/chart.js/dist/',
        'Chart.min.js', false);

    initMainChart();
    initGauge1();
  }

  @override
  void ngOnDestroy() {
    this._asideService.removePane(PaneType.Dashboard);
  }

  Future initGauge1() async {
    var grayDark = '#2a2c36';
    var brandInfo = '#63c2de';
    var grayLighter = '#d1d4d7';

    var options = new GaugeOptions()
      ..angle = 0.35
      ..lineWidth = 0.1
      ..pointer =
      new PointerOptions(length: 0.9, strokeWidth: 0.035, color: grayDark)
      ..limitMax = false
      ..colorStart = brandInfo
      ..colorStop = brandInfo
      ..strokeColor = grayLighter
      ..generateGradient = true;

    var gauge = new DonutStatic(querySelector('#gauge1') as CanvasElement);

    gauge.setOptions(options);

    gauge.maxValue = 100; // set max gauge value
    gauge.animationSpeed = 32; // set animation speed (32 is default value)
    gauge.set(77); // set actual value

  }

  void initMainChart() {
    var brandInfo = '#63c2de';
    var brandSuccess = '#4dbd74';

    var xAxes = new List<ChartXAxe>();
    xAxes.add(
        new ChartXAxe(gridLines: new GridLineOptions(drawOnChartArea: false)));

    var yAxes = new List<ChartYAxe>();
    yAxes.add(new ChartYAxe(
        ticks: new LinearTickOptions(
            beginAtZero: true,
            maxTicksLimit: 5,
            stepSize: 1000000,
            max: 6700000)));

    var chartScales = new ChartScales(xAxes: xAxes, yAxes: yAxes);

    var legend = new ChartLegendOptions(display: false);

    var chartElementsOptions = new ChartElementsOptions(
        point: new ChartPointOptions(
            radius: 0, hitRadius: 10, hoverRadius: 4, hoverBorderWidth: 3));

    var chartOptions = new ChartOptions(
        responsive: true,
        maintainAspectRatio: false,
        legend: legend,
        scales: chartScales,
        elements: chartElementsOptions);

    var data1 = <int>[
      700000,
      1000000,
      1100000,
      1200000,
      1700000,
      2700000,
      3700000,
      4200000,
      4700000,
      5200000,
      5700000,
      6200000
    ];
    var data2 = <int>[
      700000,
      1000000,
      1100000,
      1200000,
      1700000,
      2650000,
      3650000,
      4100000,
      4200000,
      4700000,
      5200000,
      5700000
    ];

    var data = new LinearChartData(labels: <String>[
      '01',
      '02',
      '03',
      '04',
      '05',
      '06',
      '07',
      '08',
      '09',
      '10',
      '11',
      '12'
    ], datasets: <ChartDataSets>[
      new ChartDataSets(
          label: 'План',
          backgroundColor: 'rgba(99,194,222,0.1)',
          //convertHex($.brandInfo,10),
          borderColor: brandInfo,
          pointHoverBackgroundColor: '#fff',
          borderWidth: 2,
          data: data1),
      new ChartDataSets(
          label: 'Факт',
          backgroundColor: 'transparent',
          borderColor: brandSuccess,
          pointHoverBackgroundColor: '#fff',
          borderWidth: 2,
          data: data2)
    ]);

    var config =
    new ChartConfiguration(type: 'line', data: data, options: chartOptions);

    new Chart(querySelector('#main-chart') as CanvasElement, config);
  }
}