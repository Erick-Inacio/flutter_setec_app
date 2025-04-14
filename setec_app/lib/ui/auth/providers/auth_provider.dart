import 'package:flutter_riverpod/flutter_riverpod.dart';

final isSpeakerProvider = StateProvider<bool>((ref) => false);

final relationshipProvider = StateProvider<String>((ref) => '');
