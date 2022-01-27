import 'package:injectable/injectable.dart';

@injectable
abstract class NetworkInfo {
  Future<bool> get isConnected;
}
