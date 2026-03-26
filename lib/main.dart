import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/storage/secure_storage.dart';
import 'core/utils/snackbar_service.dart';

late final ProviderContainer providerContainer;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  providerContainer = ProviderContainer();
  ErrorWidget.builder = (details) {
    SnackBarService.show('Something went wrong. Please restart the app.');
    return const ColoredBox(
      color: Color(0xFFFFFFFF),
      child: Center(child: Text('Oops! An unexpected error occurred.')),
    );
  };
  await SecureStorageService.getAccessToken();
  runApp(
    UncontrolledProviderScope(
      container: providerContainer,
      child: const IngredexApp(),
    ),
  );
}
