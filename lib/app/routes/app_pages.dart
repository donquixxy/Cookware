import 'package:get/get.dart';

import '../modules/addData/bindings/add_data_binding.dart';
import '../modules/addData/views/add_data_view.dart';
import '../modules/detailscreen/bindings/detailscreen_binding.dart';
import '../modules/detailscreen/views/detailscreen_view.dart';
import '../modules/editData/bindings/edit_data_binding.dart';
import '../modules/editData/views/edit_data_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/overview/bindings/overview_binding.dart';
import '../modules/overview/views/overview_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.OVERVIEW,
      page: () => OverviewView(),
      binding: OverviewBinding(),
    ),
    GetPage(
      name: _Paths.ADD_DATA,
      page: () => AddDataView(),
      binding: AddDataBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_DATA,
      page: () => EditDataView(),
      binding: EditDataBinding(),
    ),
    GetPage(
      name: _Paths.DETAILSCREEN,
      page: () => DetailscreenView(),
      binding: DetailscreenBinding(),
    ),
  ];
}
