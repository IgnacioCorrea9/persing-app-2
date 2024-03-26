// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persing/core/future_listener.dart';
import 'package:persing/providers/auth.dart';
import 'package:persing/providers/recompensa.dart';
import 'package:persing/screens/payment/data/wompi_status.dart';
import 'package:persing/screens/payment/ui/widgets/failedpayment_alert.dart';
import 'package:persing/screens/payment/ui/widgets/succesful_alert.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:persing/core/colors.dart';
import 'package:persing/screens/index/index_screen.dart';
import 'package:persing/screens/orders/provider/order_provider.dart';
import 'package:persing/screens/payment/models/payment_model.dart';
import 'package:persing/screens/payment/provider/payment_provider.dart';
import 'package:persing/screens/payment/provider/wompi_provider.dart';

class WompiScreen extends StatefulWidget {
  final LocationData data;
  const WompiScreen({
    Key? key,
    required this.data,
  }) : super(key: key);
  @override
  State<WompiScreen> createState() => _WompiScreenState();
}

class _WompiScreenState extends State<WompiScreen> {
  late String reference;
  Timer? _timer;
  int total = 0;
  @override
  void initState() {
    reference = Uuid().v4();
    final orderProvider = OrderProvider.get(context);

    final function = PaymentProvider.get(context).checkReference;

    total = orderProvider.getTotal(0);
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => watchWompi(function),
    );

    super.initState();
  }

  void watchWompi(
    Future<TransactionStatus> Function(String reference) onTimer,
  ) {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) async {
      final status = await onTimer.call(reference);
      onWathWompi(timer, status);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final wompiProvider = Provider.of<WompiProvider>(context);

    final paymentProvider = Provider.of<PaymentProvider>(context);

    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: true,
        title:
            Image.asset('assets/images/splash/logo-onboarding.png', width: 100),
        backgroundColor: primaryColor,
        actions: [
          if (wompiProvider.succeed)
            Padding(
              padding: EdgeInsets.only(
                  right: size.width * 0.03,
                  top: size.height * 0.011,
                  bottom: size.height * 0.011),
              child: InkWell(
                onTap: () async {
                  wompiProvider.succeed = false;
                  await Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => IndexScreen(),
                    ),
                    (route) => false,
                  );
                },
                child: Container(
                  width: size.width * 0.23,
                  decoration: BoxDecoration(
                      color: Color(0xFFFF0094),
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: Text(
                      'Continuar',
                      style: GoogleFonts.nunito(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
      body: Container(
        height: size.height * 0.8,
        child: SafeArea(
          child: Center(
            child: WebView(
              javascriptMode: JavascriptMode.unrestricted,
              gestureNavigationEnabled: true,
              onPageFinished: (response) async {
                // print(response);
                if (response.startsWith('https') &&
                    response.contains('transaction')) {
                  if (await paymentProvider.checkTransactionById(
                      await wompiProvider.getTransactionId(response))) {
                    wompiProvider.succeed = true;
                    //obteniendo ids de productos
                  }
                }
              },
              onWebViewCreated: (webController) {
                wompiProvider.webController = webController;
                wompiProvider.loadHtml(
                  (total * 100).toString(),
                  reference: reference,
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  bool errorShown = false;

  void onWathWompi(
    Timer timer,
    TransactionStatus status,
  ) async {
    if (status == TransactionStatus.approved) {
      //se marca la transacción como exitosa

      final productos = <String>[];
      final paymentProvider = PaymentProvider.get(context);

      final userId = Auth.get(context).userId;
      final orderProvider = OrderProvider.get(context);

      //obteniendo los productos del carrito
      for (var product in orderProvider.cart) {
        productos.add(product.id ?? '');
      }

      //enviando la información al servidor
      timer.cancel();

      await paymentProvider.sendPaymentData(
        PaymentData(
          userId: userId,
          data: widget.data,
          pago: total,
          productos: productos,
          reference: reference,
        ),
        listener: FutureListener(
          onSuccess: (value) async {
            if (value) {
              await successfulAlert(
                context,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              );
              orderProvider.clearCart();
              Recompensa.get(context).discountBySector?.clear();
              await Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => IndexScreen(),
                ),
                (route) => false,
              );
            }
          },
          onError: (error) {
            orderProvider.clearCart();
            Recompensa.get(context).discountBySector?.clear();
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => IndexScreen(),
              ),
              (route) => false,
            );
          },
        ),
      );
    } else if (status == TransactionStatus.declined ||
        status == TransactionStatus.error) {
      if (!errorShown) {
        errorShown = true;
        await failedPaymentAlert(context);
        Navigator.of(context).pop();
      }
    } else if (status != null && status != TransactionStatus.pending) {
      //si ya no se encuentra en estado pendiente, entonces significa que ya se termino el proceso
      timer.cancel();
    }
  }
}
