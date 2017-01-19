import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

@Component(selector: 'dashboard', templateUrl: 'dashboard_component.html')
class DashboardComponent implements OnInit {
  static const String route_name = "Dashboard";
  static const String route_path = "dashboard";
  static const Route route = const Route(
      path: DashboardComponent.route_path,
      component: DashboardComponent,
      name: DashboardComponent.route_name);

  final Router _router;

  DashboardComponent(this._router) {}

  @override
  void ngOnInit() {}

  onSubmit() {}
}
