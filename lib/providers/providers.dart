import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cross/repositories/auth_repository.dart';


final authProvider = Provider(
  (ref) => AuthRepository(),
);