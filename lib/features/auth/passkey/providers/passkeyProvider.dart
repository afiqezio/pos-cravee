import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginErrorProvider = StateProvider<String>((ref) => "");
final pinProvider = StateProvider<String>((ref) => '');