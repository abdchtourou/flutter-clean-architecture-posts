import 'package:internet_connection_checker/internet_connection_checker.dart';
abstract class NetworkInf{
  Future<bool> get isConnected;

}
class NetworkInfImpl implements NetworkInf{
  final InternetConnectionChecker connectionChecker;

  NetworkInfImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}