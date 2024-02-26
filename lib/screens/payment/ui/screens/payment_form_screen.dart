import 'package:flutter/material.dart';
import 'package:persing/core/ui/widgets/action_button.dart';
import 'package:persing/core/ui/widgets/persing_scaffold.dart';
import 'package:persing/core/ui/widgets/labeled_textform.dart';
import 'package:persing/screens/payment/models/payment_model.dart';
import 'package:persing/screens/payment/provider/wompi_provider.dart';
import 'package:persing/screens/payment/ui/screens/wompi_screen.dart';
import 'package:provider/provider.dart';

final _key = GlobalKey<FormState>();

class PaymentFormScreen extends StatefulWidget {
  const PaymentFormScreen();

  @override
  State<PaymentFormScreen> createState() => _PaymentFormScreenState();
}

class _PaymentFormScreenState extends State<PaymentFormScreen> {
  late TextEditingController _paisController, _ciudadController, _dirController;

  @override
  void initState() {
    _paisController = TextEditingController();
    _ciudadController = TextEditingController();
    _dirController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _paisController.dispose();
    _ciudadController.dispose();
    _dirController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return PersingScaffold(
      title: 'Formulario de envío',
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10.3,
        ),
        child: Form(
          key: _key,
          child: Column(
            children: [
              LabeledTextFormField(
                controller: _paisController,
                hintText: 'Escribe tu país',
                labelText: ' • País',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Debes proporcionar un país';
                  }
                  return "";
                },
                keyboardType: TextInputType.name,
              ),
              SizedBox(
                height: 10,
              ),
              LabeledTextFormField(
                controller: _ciudadController,
                hintText: 'Escribe tu ciudad',
                labelText: ' • Ciudad',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Debes proporcionar una ciudad';
                  }
                  return "";
                },
                keyboardType: TextInputType.name,
              ),
              SizedBox(
                height: 10,
              ),
              LabeledTextFormField(
                controller: _dirController,
                hintText: 'Escribe tu dirección',
                labelText: ' • Dirección',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Debes proporcionar una dirección';
                  }
                  return "";
                },
                keyboardType: TextInputType.name,
              ),
            ],
          ),
        ),
      ),
      bottom: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ActionButton(
                size: size,
                purpleColor: Colors.white,
                title: 'Volver',
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              ActionButton(
                size: size,
                purpleColor: Colors.white,
                title: 'Pagar',
                onPressed: () {
                  final validated = _key?.currentState?.validate() ?? false;

                  if (validated) {
                    Provider.of<WompiProvider>(
                      context,
                      listen: false,
                    )..succeed = false;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WompiScreen(
                          data: getData(),
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
        ],
      ),
    );
  }

  ///obtiene los datos de los campos del form y crea una clase especifica para estos
  LocationData getData() {
    return LocationData(
      country: _paisController.text,
      city: _ciudadController.text,
      address: _dirController.text,
    );
  }
}
