import 'package:get_it/get_it.dart';
import 'package:reminder/services/database_helper.dart';

GetIt locator = GetIt.instance;
DatabaseHelper db = DatabaseHelper();

void setupLocator() {
  print('service locator');
  locator.registerSingleton(DatabaseHelper());
}
