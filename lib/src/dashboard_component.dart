import 'dart:html';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:resources_loader/resources_loader.dart';

@Component(selector: 'dashboard',
  templateUrl: 'dashboard_component.html')
class DashboardComponent implements OnInit {
  static const String route_name = 'Dashboard';
  static const String route_path = 'dashboard';
  static const Route route = const Route(
      path: DashboardComponent.route_path,
      component: DashboardComponent,
      name: DashboardComponent.route_name);

  final Router _router;
  final ResourcesLoaderService _resourcesLoaderService;

  DashboardComponent(this._router, this._resourcesLoaderService) {}

  @override
  void ngOnInit() {
    var script = new ScriptElement()
      ..async = true
      ..type = 'text/javascript'
      ..src = 'vendor/chart.js/dist/Chart.min.js';
    document.body.append(script);
    script.onLoad.listen(initChart);

    //_resourcesLoaderService.loadScript('vendor/chart.js/dist/', 'Chart.min.js', false);
    //_resourcesLoaderService.loadScript('packages/dashboard/src/', 'dashboard-init.js', false);
  }

  void initChart(Event e) {
    _resourcesLoaderService.loadScript('packages/dashboard/src/', 'dashboard-init.js', false);
  }
}
