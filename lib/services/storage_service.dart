import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final storageProvider = Provider<StorageService>((ref) => StorageService(ref),);

class StorageService{
  final Ref _ref;
  
  final _secureStorage = const FlutterSecureStorage();

  StorageService(this._ref);
}