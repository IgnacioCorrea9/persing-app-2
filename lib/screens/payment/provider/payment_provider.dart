import 'dart:convert';
import 'dart:math';

import 'package:credit_card_validator/validation_results.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:persing/core/environment.dart';
import 'package:persing/core/future_listener.dart';
import 'package:persing/core/config.dart';
import 'package:persing/screens/payment/data/payment_repository.dart';
import 'package:persing/screens/payment/data/payment_rt_db.dart';
import 'package:persing/screens/payment/data/wompi_status.dart';
import 'package:persing/screens/payment/exceptions/payment_exceptions.dart';
import 'package:persing/screens/payment/models/acceptancetoken_model.dart';
import 'package:http/http.dart' as http;
import 'package:persing/screens/payment/models/banksresponse_model.dart';
import 'package:persing/screens/payment/models/cardtokenized_model.dart';
import 'package:persing/screens/payment/models/checkpseresponse_model.dart';
import 'package:persing/screens/payment/models/checktransaction_model.dart';
import 'package:persing/screens/payment/models/payment_model.dart';
import 'package:persing/screens/payment/models/paymentcard_model.dart';
import 'package:persing/screens/payment/models/pseresponse_model.dart';
import 'package:persing/screens/payment/models/transactionresponse_model.dart';
import 'package:credit_card_validator/credit_card_validator.dart';
import 'package:provider/provider.dart';

import '../models/checknequiresponse_model.dart';
import '../models/nequiresponse_model.dart';
import '../models/transaction_model.dart';

part './extensions/payment_form_ext.dart';

class PaymentProvider with ChangeNotifier {
  static PaymentProvider get(
    BuildContext context, {
    bool listen = false,
  }) {
    return Provider.of<PaymentProvider>(
      context,
      listen: listen,
    );
  }

  CreditCardValidator _ccValidator = CreditCardValidator();

  bool _validateCreditCardInfo = false;
  bool get getValidateCreditCardInfo => _validateCreditCardInfo;
  Future<bool> validateCreditCardInfo(
    String ccNum,
    String expDate,
    String cvc,
  ) async {
    CCNumValidationResults ccNumResults = _ccValidator.validateCCNum(ccNum);
    ValidationResults expDateResults = _ccValidator.validateExpDate(expDate);
    ValidationResults cvvResults =
        _ccValidator.validateCVV(cvc, ccNumResults.ccType);

    if (ccNumResults.isPotentiallyValid) {
      if (ccNumResults.isValid &&
          expDateResults.isValid &&
          cvvResults.isValid) {
        return _validateCreditCardInfo = true;
      } else {
        return _validateCreditCardInfo = false;
      }
    } else {
      return false;
    }
  }

  final TextEditingController _bankPseSelect = TextEditingController();
  TextEditingController get bankPseSelect => _bankPseSelect;
  set setBankPseSelect(String value) {
    _bankPseSelect.text = value;
    notifyListeners();
  }

  final TextEditingController _bankPseCodeSelect = TextEditingController();
  TextEditingController get bankPseCodeSelect => _bankPseCodeSelect;
  set setBankPseCodeSelect(String value) {
    _bankPseCodeSelect.text = value;
    notifyListeners();
  }

  List<Bank> _banksPse = [
    Bank(
      financialInstitutionCode: '',
      financialInstitutionName: '',
    )
  ];

  void getCode() {
    for (final bank in banksPse) {
      if (bank.financialInstitutionName == bankPseSelect.text) {
        setBankPseCodeSelect = bank.financialInstitutionCode;
      }
    }
  }

  void initPayment() {
    isNequi = false;
    isPaymentPse = false;
    paymentCard = false;
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    _cardNumberController.text = creditCardModel.cardNumber;
    _expDateController.text = creditCardModel.expiryDate;
    _ownerCardController.text = creditCardModel.cardHolderName;
    _cvcCardController.text = creditCardModel.cvvCode;
    _isCvvFocused = creditCardModel.isCvvFocused;
    notifyListeners();
  }

  List<Bank> get banksPse => _banksPse.map((element) => element).toList();

  set banksPse(List<Bank> value) {
    _banksPse = value;
    notifyListeners();
  }

  final TextEditingController _cardNumberController = TextEditingController();
  TextEditingController get cardNumberController => _cardNumberController;
  set setCardNumberController(String value) {
    _cardNumberController.text = value;
    notifyListeners();
  }

  final TextEditingController _expDateController = TextEditingController();
  TextEditingController get expDateController => _expDateController;
  set setExpDateController(String value) {
    notifyListeners();
  }

  final TextEditingController _cvcCardController = TextEditingController();
  TextEditingController get cvcCardController => _cvcCardController;
  setCvcCardController(String value) {
    if (_cvcCardController.text.length <= 3) {
      _cvcCardController.text = value;
    }
  }

  final TextEditingController _ownerCardController = TextEditingController();
  TextEditingController get ownerCardController => _ownerCardController;
  setOwnerCardController(String value) {
    _ownerCardController.text = value;
    notifyListeners();
  }

  final TextEditingController _phoneController = TextEditingController();
  TextEditingController get phoneController => _phoneController;
  set setPhoneController(String value) {
    _phoneController.text = value;
    notifyListeners();
  }

  bool _isCvvFocused = false;
  bool get isCvvFocused => _isCvvFocused;
  set setIsCvvFocused(bool value) {
    _isCvvFocused = value;
    notifyListeners();
  }

  bool _paymentCard = false;
  bool get paymentCard => _paymentCard;
  set paymentCard(bool value) {
    _paymentCard = value;
    notifyListeners();
  }

  bool _isNequi = false;
  bool get isNequi => _isNequi;
  set isNequi(bool value) {
    _isNequi = value;
    notifyListeners();
  }

  bool _isPaymentPse = false;
  bool get isPaymentPse => _isPaymentPse;
  set isPaymentPse(bool value) {
    _isPaymentPse = value;
    notifyListeners();
  }

  bool _inProcess = false;
  bool get inProcess => _inProcess;
  set inProcess(bool value) {
    _inProcess = value;
    notifyListeners();
  }

  bool get areBankPseValid =>
      _bankPseSelect.text.isNotEmpty &&
      _bankPseSelect.text != 'Selecciona un banco';

  Future<AcceptanceTokenResponse> getMerchantInfo() async {
    try {
      final response = await http.get(
        Uri.parse(
            '${Config.wompiUrl}/merchants/${dotenv.env['WOMPI_PROD_KEY']}'),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['WOMPI_PROD_KEY']}',
        },
      );

      final decoded = jsonDecode(response.body);

      if (decoded['data'] != null) {
        final AcceptanceTokenResponse acceptanceAnswer =
            AcceptanceTokenResponse.fromMap(
          decoded as Map<String, dynamic>,
        );
        return acceptanceAnswer;
      } else {
        throw Exception("Error with the consume");
      }
    } catch (err) {
      throw Exception("Error with the consume");
    }
  }

  Future<CardTokenizedResponse> tokenizeCard(CardModel card) async {
    try {
      final response = await http.post(
        Uri.parse(
          '${Config.wompiUrl}/tokens/cards',
        ),
        body: card.toJson(),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['WOMPI_PROD_KEY']}',
        },
      );

      final decoded = jsonDecode(response.body);

      if (decoded['status'] == 'CREATED') {
        final CardTokenizedResponse cardResponse =
            CardTokenizedResponse.fromMap(
          decoded as Map<String, dynamic>,
        );
        return cardResponse;
      } else {
        throw Exception("Error with the consume");
      }
    } catch (err) {
      throw Exception("Error with the consume");
    }
  }

  Future<TransactionResponse> createTransaction(
    Transaction transaction,
  ) async {
    try {
      final Transaction newTransaction = transaction.copyWith(
          publicKey: 'Bearer ${dotenv.env['WOMPI_PROD_KEY']}');

      final response = await http.post(
        Uri.parse(
          Config.localTesting
              ? '${Config.localApiUrl}api/transaction'
              : '${Config.apiUrl}transaction',
        ),
        body: newTransaction.toJson(),
        headers: {
          "Content-Type": "application/json",
          "Authorization": 'Bearer ${dotenv.env['WOMPI_PROD_KEY']}',
          "acceptance_token": newTransaction.acceptanceToken
        },
      );

      print(Config.localTesting);

      print(response.body);

      final decoded = jsonDecode(response.body);
      if (decoded['success']) {
        final TransactionResponse transactionResponse =
            TransactionResponse.fromMap(decoded as Map<String, dynamic>);
        return transactionResponse;
      } else {
        throw Exception("Error with the consume");
      }
    } catch (err) {
      throw Exception("Error with the consume");
    }
  }

  Future<NequiResponse> paymentNequi(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse(
          Config.localTesting
              ? '${Config.localApiUrl}api/transaction/nequi'
              : '${Config.apiUrl}transaction/nequi',
        ),
        body: jsonEncode(data),
        headers: {
          "Content-Type": "application/json",
        },
      );
      print(response.body);
      final decoded = jsonDecode(response.body);
      if (decoded['success']) {
        final NequiResponse transactionResponse =
            NequiResponse.fromMap(decoded as Map<String, dynamic>);
        return transactionResponse;
      } else {
        throw Exception("Error with the consume");
      }
    } catch (err) {
      throw Exception("Error with the consume");
    }
  }

  Future<bool> checkTransactionById(
    String transactionId,
  ) async {
    try {
      final response = await http.get(
        Uri.parse('${Config.wompiUrl}/transactions/$transactionId'),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['WOMPI_PROD_KEY']}',
        },
      );

      final decoded = jsonDecode(response.body);

      print(decoded);

      if (decoded['data'] != null) {
        final CheckTransactionResponse newTransactionResp =
            CheckTransactionResponse.fromMap(
          decoded as Map<String, dynamic>,
        );
        if (newTransactionResp.data.status == 'PENDING') {
          //se genera una espera de 5 segundos para qque la transaccion se apruebe
          await Future.delayed(
            Duration(seconds: 5),
          );
          return await checkTransactionById(transactionId);
        } else {
          if (newTransactionResp.data.status == 'APPROVED') {
            return true;
          } else {
            return false;
          }
        }
      } else {
        return false;
      }
    } catch (err) {
      return false;
    }
  }

  ///Check transaction status
  Future<bool> checkTransactionStatus(
    TransactionResponse transactionResponse,
  ) async {
    try {
      final response = await http.get(
        Uri.parse(
            '${Config.wompiUrl}/transactions/${transactionResponse.data.data.id}'),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['WOMPI_PROD_KEY']}',
        },
      );

      final decoded = jsonDecode(response.body);

      if (decoded['data'] != null) {
        final CheckTransactionResponse newTransactionResp =
            CheckTransactionResponse.fromMap(
          decoded as Map<String, dynamic>,
        );
        if (newTransactionResp.data.status == 'PENDING') {
          checkTransactionStatus(transactionResponse);
        } else {
          if (newTransactionResp.data.status == 'APPROVED') {
            return true;
          } else {
            return false;
          }
        }
        return false;
      } else {
        return false;
      }
    } catch (err) {
      return false;
    }
  }

  Future<PseResponse> paymentPse(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse(Config.localTesting
            ? '${Config.localApiUrl}api/transaction/pse'
            : '${Config.apiUrl}transaction/pse'),
        body: jsonEncode(data),
        headers: {
          "Content-Type": "application/json",
          "Authorization": 'Bearer ${dotenv.env['WOMPI_PROD_KEY']}',
          "acceptance_token": data['acceptance_token']
        },
      );

      print(response.body);

      final decoded = jsonDecode(response.body);
      if (decoded['success']) {
        final PseResponse transactionResponse = PseResponse.fromMap(
          decoded as Map<String, dynamic>,
        );
        return transactionResponse;
      } else {
        throw Exception("Error with the consume");
      }
    } catch (err) {
      throw Exception("Error with the consume");
    }
  }

  Future<CheckPseResponse> checkPseTransactionStatus(
    PseResponse transactionResponse,
  ) async {
    try {
      final response = await http.get(
        Uri.parse(
          '${Config.wompiUrl}/transactions/${transactionResponse.data.data.id}',
        ),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['WOMPI_PROD_KEY']}',
        },
      );

      final decoded = jsonDecode(response.body);
      if (decoded['data'] != null) {
        final CheckPseResponse newTransactionResp =
            CheckPseResponse.fromMap(decoded as Map<String, dynamic>);
        if (newTransactionResp.data.status == 'PENDING') {
          checkPseTransactionStatus(transactionResponse);
        } else {
          if (newTransactionResp.data.status == 'APPROVED') {
            return newTransactionResp;
          } else {
            throw Exception("Error with the consume");
          }
        }
        throw Exception("Error with the consume");
      } else {
        throw Exception("Error with the consume");
      }
    } catch (err) {
      throw Exception("Error with the consume");
    }
  }

  Future<CheckPseResponse> checkPseTransactionByIdStatus(String id) async {
    try {
      final response = await http.get(
        Uri.parse(
          '${Config.wompiUrl}/transactions/$id',
        ),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['WOMPI_PROD_KEY']}',
        },
      );

      final decoded = jsonDecode(response.body);
      if (decoded['data'] != null) {
        final CheckPseResponse newTransactionResp =
            CheckPseResponse.fromMap(decoded as Map<String, dynamic>);
        if (newTransactionResp.data.status == 'PENDING') {
          checkPseTransactionByIdStatus(id);
        } else {
          if (newTransactionResp.data.status == 'APPROVED') {
            return newTransactionResp;
          } else {
            throw Exception("Error with the consume");
          }
        }
        throw Exception("Error with the consume");
      } else {
        throw Exception("Error with the consume");
      }
    } catch (err) {
      throw Exception("Error with the consume");
    }
  }

  ///Get list of banks the the payment method chose is PSE
  Future<List<Bank>> getBanksList() async {
    try {
      final response = await http.get(
        Uri.parse(
          '${Config.wompiUrl}/pse/financial_institutions',
        ),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['WOMPI_PROD_KEY']}',
        },
      );

      final decoded = jsonDecode(response.body);

      if (decoded['data'] != null) {
        final BanksResponse bankResponse = BanksResponse.fromMap(
          decoded as Map<String, dynamic>,
        );
        return bankResponse.data;
      } else {
        return [];
      }
    } catch (err) {
      return [];
    }
  }

  Future<bool> checkNequiTransactionStatus(
    NequiResponse transactionResponse,
  ) async {
    try {
      final response = await http.get(
        Uri.parse(
          '${Config.wompiUrl}/transactions/${transactionResponse.data.data.id}',
        ),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['WOMPI_PROD_KEY']}',
        },
      );
      final decoded = jsonDecode(response.body);
      if (decoded['data'] != null) {
        final CheckNequiResponse newTransactionResp =
            CheckNequiResponse.fromMap(
          decoded as Map<String, dynamic>,
        );
        if (newTransactionResp.data.status == 'PENDING') {
          checkNequiTransactionStatus(transactionResponse);
        } else {
          if (newTransactionResp.data.status == 'APPROVED') {
            return true;
          } else {
            return false;
          }
        }
        return false;
      } else {
        return false;
      }
    } catch (err) {
      return false;
    }
  }

  Future<bool> wompiTransaction(
    CardModel card,
  ) async {
    bool wasApproved = false;
    try {
      final AcceptanceTokenResponse merchantInfo = await getMerchantInfo();

      final CardTokenizedResponse cardTokenizedResponse =
          await tokenizeCard(card);
      if (cardTokenizedResponse != null) {
        final Transaction transactionRequest = Transaction(
          acceptanceToken:
              merchantInfo.data.presignedAcceptance.acceptanceToken,
          amountInCents: (1500 * 100).toInt(),
          currency: 'COP',
          customerEmail: 'luiszapata124@gmail.com',
          reference: (1000000 + Random().nextInt(9999999 - 1000000)).toString(),
          paymentMethod: PaymentMethod(
            installments: 2,
            token: cardTokenizedResponse.data.id,
            type: 'CARD',
          ),
          publicKey: '',
        );

        final TransactionResponse transactionResponse =
            await createTransaction(transactionRequest);
        wasApproved = await checkTransactionStatus(transactionResponse);
      }
      return wasApproved;
    } catch (e) {
      return wasApproved;
    }
  }

  Future<bool> transactionNequi(String email) async {
    try {
      final Map<String, dynamic> transactionRequest = {
        'nequiAccount': {'phone_number': '${dotenv.env['WOMPI_TEST_PHONE']}'},
        'userInformation': {
          'amount_in_cents': 1500 * 100,
          'reference':
              (1000000 + Random().nextInt(9999999 - 1000000)).toString(),
          'customer_email': email,
          'currency': 'COP'
        }
      };
      //Create transaction
      final NequiResponse transactionResponse =
          await paymentNequi(transactionRequest);

      final bool wasApproved =
          await checkNequiTransactionStatus(transactionResponse);
      return wasApproved;
    } catch (e) {
      return false;
    }
  }

  Future<bool> transactionPse(String email) async {
    bool wasApproved = false;
    try {
      final AcceptanceTokenResponse merchantInfo = await getMerchantInfo();

      final transactionRequest = {
        'amount_in_cents': (1500 * 100).toInt(),
        'reference': (1000000 + Random().nextInt(9999999 - 1000000)).toString(),
        'customer_email': email,
        'currency': 'COP',
        'public_key': 'Bearer ${dotenv.env['WOMPI_PROD_KEY']}',
        'acceptance_token':
            merchantInfo.data.presignedAcceptance.acceptanceToken,
        'payment_method': {
          'type': 'PSE',
          'user_type': 0,
          'user_legal_id_type': 'CC',
          'user_legal_id': '123456',
          'financial_institution_code': bankPseCodeSelect.text,
          'payment_description': 'TEST'
        },
      };
      //Create transaction
      final PseResponse transactionResponse =
          await paymentPse(transactionRequest);
      final CheckPseResponse checkPseResponse =
          await checkPseTransactionStatus(transactionResponse);

      if (checkPseResponse != null) {
        final CheckPseResponse response =
            await checkPseTransactionByIdStatus(checkPseResponse.data.id);
        if (response != null) {
          if (response.data.status == 'APPROVED') {
            wasApproved = true;
            return wasApproved;
          } else {
            return wasApproved;
          }
        } else {
          return wasApproved;
        }
      } else {
        return wasApproved;
      }
    } catch (e) {
      return wasApproved;
    }
  }
}
