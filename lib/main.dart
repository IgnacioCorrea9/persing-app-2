import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:persing/screens/payment/provider/payment_controller.dart';
import 'package:provider/provider.dart';

import 'package:persing/core/colors.dart';
import 'package:persing/core/environment.dart';
import 'package:persing/core/injection/global_injection.dart';
import 'package:persing/providers/auth.dart';
import 'package:persing/providers/comentario.dart';
import 'package:persing/providers/profile_provider.dart';
import 'package:persing/providers/publicacion.dart';
import 'package:persing/providers/recompensa.dart';
import 'package:persing/providers/sector.dart';
import 'package:persing/providers/user.dart';
import 'package:persing/screens/payment/provider/payment_provider.dart';
import 'package:persing/screens/payment/provider/wompi_provider.dart';
import 'package:persing/screens/products/provider/product_provider.dart';
import 'package:persing/screens/splash_screen/splash_screen.dart';

import 'screens/orders/provider/order_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  Environment();

  await Hive.initFlutter();

  //funcion que validara las transacciones que no se han subido
  //y reintentara subirlas
  Timer _timer = Timer.periodic(
    Duration(hours: 1),
    (timer) async {
      PaymentController.get().searchForPaymentErrors();
    },
  );
  void cancelTimer() {
    _timer.cancel();
  }

  init();
  runApp(Persing());

  WidgetsBinding.instance.addObserver(
    AppLifecycleObserver(
      cancelTimer: cancelTimer,
    ),
  );
}

class AppLifecycleObserver extends WidgetsBindingObserver {
  final void Function() cancelTimer;
  AppLifecycleObserver({
    required this.cancelTimer,
  });
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      cancelTimer.call();
    }
  }
}

class Persing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Auth>(
          create: (context) => Auth(),
        ),
        ChangeNotifierProvider<User>(
          create: (context) => User(),
        ),
        ChangeNotifierProvider<Publicacion>(
          create: (context) => Publicacion(),
        ),
        ChangeNotifierProvider<Comentario>(
          create: (context) => Comentario(),
        ),
        ChangeNotifierProvider<Sector>(
          create: (context) => Sector(),
        ),
        ChangeNotifierProvider<Recompensa>(
          create: (context) => Recompensa(),
        ),
        ChangeNotifierProvider<ProfileProvider>(
          create: (context) => ProfileProvider(),
        ),
        ChangeNotifierProvider<ProductProvider>(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider<OrderProvider>(
          create: (context) => OrderProvider(),
        ),
        ChangeNotifierProvider<PaymentProvider>(
          create: (context) => PaymentProvider(),
        ),
        ChangeNotifierProvider<WompiProvider>(
          create: (context) => WompiProvider(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Persing',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: primaryColor,
            scaffoldBackgroundColor: Color(0xffF7F7FF),
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  secondary: Color(0xFFFF0094),
                ),
            fontFamily: 'Poppins',
          ),
          home: SplashScreen(),
        ),
      ),
    );
  }
}
