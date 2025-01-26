import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:mobile_app_development/Routes.dart';
import 'package:mobile_app_development/services/NotificationService.dart';
import 'package:mobile_app_development/services/auth/AuthService.dart';

import 'DependencyInjection.dart';

final authService = DependencyInjection.getIt.get<AuthService>();

final _router = getRouter();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection.configure();
  final notificationService =
      DependencyInjection.getIt.get<NotificationService>();
  notificationService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          List<ConnectivityResult> connectivity,
          Widget child,
        ) {
          final bool connected =
              !connectivity.contains(ConnectivityResult.none);
          return Stack(
            fit: StackFit.expand,
            children: [
              MaterialApp.router(
                routerConfig: _router,
                theme: ThemeData(
                  primarySwatch: Colors.indigo,
                  scaffoldBackgroundColor: const Color(0xFF6F82F8),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).padding.top,
                left: 0.0,
                right: 0.0,
                height: 24.0,
                child: connected
                    ? const SizedBox.shrink()
                    : Container(
                        color: const Color(0xFFEE4400),
                        child: const Center(
                          child: Text(
                            'Offline',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
              ),
            ],
          );
        },
        child: const SizedBox.shrink(),
      ),
    );
  }
}
