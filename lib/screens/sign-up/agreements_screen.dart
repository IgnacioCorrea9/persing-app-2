import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persing/core/colors.dart';

class AgreementsScreen extends StatelessWidget {
  const AgreementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xFFF7F7FF),
      appBar: AppBar(
        //
        backgroundColor: primaryColor,
        centerTitle: true,
        title:
            Image.asset('assets/images/splash/logo-onboarding.png', width: 100),

        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.06, vertical: size.height * 0.03),
          child: ListView(
            children: [
              Text(
                'POLÍTICA DE TRATAMIENTO DE DATOS PERSONALES\n',
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                'Dando cumplimiento a lo dispuesto en la Ley 1581 de 2012 y a su Decreto Reglamentario 1377 de 2013, la aplicación  Persing (en adelante “PERSING”) respetuosa de la importancia del manejo y la protección de Datos Personales suministrados por sus usuarios de la aplicación Persing (en adelante los “TITULARES”), ha diseñado la presente  Política de Tratamiento de Datos Personales (en adelante la “Política”) con el fin de informar los TITULARES las  finalidades, medidas y procedimientos para el manejo de Bases de Datos Personales, así como los mecanismos con  que los TITULARES cuentan para conocer, actualizar, rectificar y suprimir los Datos Personales suministrados o  revocar la autorización de uso de los mismos.',
                style: GoogleFonts.nunito(),
              ),
              Text(
                '\n1. DEFINICIONES:\n\n a) Autorización: Consentimiento previo, expreso e informado del TITULAR para llevar a cabo el Tratamiento  de Datos Personales.',
                style: GoogleFonts.nunito(),
              ),
              Text(
                'b) Base de Datos: Conjunto organizado de Datos Personales que sea objeto de tratamiento. Se consideran  Bases de Datos Personales en PERSING, todas las Bases de Datos de personas naturales que hayan  suministrado sus Datos Personales a través de la aplicación PERSING o cualquier otra persona natural cuya  información sea objeto de Tratamiento por parte de PERSING. ',
                style: GoogleFonts.nunito(),
              ),
              Text(
                'c) Dato personal: Cualquier información vinculada o que pueda asociarse a una o varias personas naturales  determinadas o determinables. ',
                style: GoogleFonts.nunito(),
              ),
              Text(
                'd) Datos sensibles: Son aquellos que afectan la intimidad del titular o pueden dar lugar a que lo discriminen,  es decir, aquellos que revelan su origen racial o étnico, su orientación política, las convicciones religiosas o  filosóficas, la pertenencia a sindicatos, organizaciones sociales, de derechos humanos, así como los datos  relativos a la salud, a la vida sexual, y los datos biométricos, entre otros.',
                style: GoogleFonts.nunito(),
              ),
              Text(
                'e) Encargado del Tratamiento: Persona natural o jurídica, pública o privada, que por sí misma o en asocio con  otros, realice el Tratamiento de Datos Personales por cuenta del Responsable del Tratamiento. f) Responsable del Tratamiento: Persona natural o jurídica, pública o privada, que por sí misma o en asocio  con otros, decida sobre la base de datos y/o el Tratamiento de los datos, en este caso PERSING. g) Titular: Persona natural cuyos Datos Personales sean objeto de Tratamiento. ',
                style: GoogleFonts.nunito(),
              ),
              Text(
                'h) Tratamiento: Cualquier operación o conjunto de operaciones sobre Datos Personales, tales como la  recolección, almacenamiento, uso, circulación o supresión. ',
                style: GoogleFonts.nunito(),
              ),
              Text(
                'i) Transferencia: Se trata de la operación que realiza el responsable o el encargado del tratamiento de los  Datos Personales, cuando envía la información a otro receptor, que, a su vez, se convierte en responsable del tratamiento de esos datos. ',
                style: GoogleFonts.nunito(),
              ),
              Text(
                '\n2. OBJETIVO:\n',
                style: GoogleFonts.nunito(),
              ),
              Text(
                'Definir los lineamientos generales para el cumplimento de la Ley 1581 de 2012 y del Decreto 1377 de 2013,  que regula el manejo de Bases de Datos Personales, así como los criterios de recolección, almacenamiento, uso, circulación y supresión de los Datos Personales tratados por PERSING.',
                style: GoogleFonts.nunito(),
              ),
              Text(
                '\n3. ALCANCE:\n\n Esta Política aplica para toda la información personal registrada en la aplicación PERSING, quien actúa en  calidad de Responsable del tratamiento de los Datos Personales.',
                style: GoogleFonts.nunito(),
              ),
              Text(
                '\n4. OBLIGACIONES:\n\n Esta Política es de obligatorio y estricto cumplimiento para:',
                style: GoogleFonts.nunito(),
              ),
              Text(
                'a) PERSING como Responsable del Tratamiento de Bases de Datos Personales.\n b) Los terceros que tengan acceso a las Bases de Datos serán Encargados del Tratamiento y por tanto  deberán dar cumplimiento a lo establecido por la Ley 1581 de 2012, el Decreto 1377 de 2013, las  normas que las complementen y modifiquen y a la presente Política. \n\n No es necesaria la aplicación de la presente Política, cuando:\n\n a) Cuando la información es requerida por una entidad pública o administrativa en ejercicio de sus  funciones legales o por orden judicial.\nb) En caso de hacer tratamiento de datos de naturaleza pública.  \n c) Casos de urgencia médica o sanitaria. \n d) Para el tratamiento de información autorizado por la ley para fines históricos, estadísticos o científicos. \n e) Cuando se trata de datos relacionados con el Registro Civil. ',
                style: GoogleFonts.nunito(),
              ),
              Text(
                '\n5. RESPONSABLE DEL TRATAMIENTO: \n',
                style: GoogleFonts.nunito(),
              ),
              Text(
                'Aplicación PERSING propiedad de Ignacio Correa Molina, con domicilio principal en la calle 67 # 28B -36, de la  ciudad de Manizales, Caldas, República de Colombia. Página Web: https://www.persinglatam.com/ Teléfono  (+57) 310-8211831.',
                style: GoogleFonts.nunito(),
              ),
              Text(
                '\n6. TRATAMIENTO Y FINALIDAD:  \n',
                style: GoogleFonts.nunito(),
              ),
              Text(
                'El tratamiento que realizará PERSING con los Datos Personales será el siguiente: \n\n a) Mostrar al Titular contenidos basados en sus gustos e intereses a través de la aplicación Persing. \n b) Realizar análisis estadísticos, comerciales, estratégicos, financieros, sociales y técnicos. \n c) Realizar invitaciones a eventos y ofrecer nuevos productos o servicios. \n d) Comunicación con los Titulares para efectos comerciales o de mercadeo. \n e) Realizar estrategias de mercado mediante el estudio del comportamiento del Titular frente a las ofertas  y con ello mejorar el contenido de la aplicación Persing. \n f) Utilizar los datos suministrados en campañas de comunicación, divulgación y promoción u oferta de  productos, actividades y/o servicios. \n g) Ordenar, catalogar, clasificar, dividir o separar la información suministrada. \n h) Recabar o recolectar los datos personales e incorporarlos y almacenarlos en nuestra base de datos. \n  i) Realizar encuestas de satisfacción y ofrecimiento para calificar el servicio y la atención por medio de  los canales dispuestos para ello. \n j) Conservar registros históricos y mantener contacto con los Titulares del dato. \n k) Verificar, comprobar o validar los datos suministrados. \n l) Estudiar y analizar la información entregada para el seguimiento y mejoramiento de los productos Y  servicios. \n m) Transferir los datos personales a cualquier país o servidor en otro país de compañías filiales o matrices  de Persing. \n n) Comunicar y permitir el acceso a los datos personales suministrados a terceros proveedores y a las  personas naturales empleadas de Persing. \n o) Prestar el mantenimiento, desarrollo y/o control de la aplicación Persing. \n p) Gestionar trámites de solicitudes, peticiones, quejas o reclamos. \n q) Dar cumplimiento a las obligaciones impuestas por leyes y normas en cabeza de Persing.   \n',
                style: GoogleFonts.nunito(),
              ),
              Text(
                '7. TRATAMIENTO DE DATOS SENSIBLES:   \n',
                style: GoogleFonts.nunito(),
              ),
              Text(
                'PERSING únicamente realiza el tratamiento de Datos Personales sensibles de usuarios que los suministren a  través de la aplicación Persing. Para realizar el tratamiento de estas categorías de Datos Personales, PERSING  solicita autorización previa, expresa e informada a sus Titulares y así mismo le informa cuando el dato solicitado  tiene carácter de sensible. Los datos sensibles recolectados a través de la aplicación Persing pueden estar relacionados con: origen racial  o étnico, datos relativos a hábitos de salud o vida sexual y son tratados para los fines indicados en el numeral 6  de la presente Política. En todo caso, los usuarios de la aplicación podrán en cualquier momento solicitar  conocer, actualizar, rectificar o suprimir los Datos Personales sensibles a través de solicitudes que serán  tramitadas de acuerdo con los numerales 9 y 10 de este documento.',
                style: GoogleFonts.nunito(),
              ),
              Text(
                '\n\n8. DERECHOS DE LOS TITULARES:     \n',
                style: GoogleFonts.nunito(),
              ),
              Text(
                'Como titular de sus Datos Personales Usted tiene derecho a: (i) Acceder de forma gratuita a los datos  proporcionados que hayan sido objeto de tratamiento. (ii) Conocer, actualizar y rectificar su información frente  a datos parciales, inexactos, incompletos, fraccionados, que induzcan a error, o aquellos cuyo tratamiento esté  prohibido o no haya sido autorizado. (iii) Solicitar prueba de la autorización otorgada. (iv) Presentar ante la  Superintendencia de Industria y Comercio (SIC) quejas por infracciones a lo dispuesto en la normatividad  vigente. (v) Revocar la autorización y/o solicitar la supresión del dato, siempre que no exista un deber legal o  contractual que impida eliminarlos. (vi) Abstenerse de responder las preguntas sobre datos sensibles. Tendrá  carácter facultativo las respuestas que versen sobre datos sensibles o sobre datos de las niñas y niños y  adolescentes. ',
                style: GoogleFonts.nunito(),
              ),
              Text(
                '\n9. ATENCIÓN DE PETICIONES, CONSULTAS Y RECLAMOS: \n',
                style: GoogleFonts.nunito(),
              ),
              Text(
                'PERSING dispone de los medios y recursos para atender y gestionar las peticiones, consultas y reclamos de los  Titulares para ejercer sus derechos a conocer, actualizar, rectificar y suprimir sus datos y revocar su  autorización. Los medios de comunicación para los anteriores fines son: \n\n • Correo electrónico: persinglatam@gmail.com \n\n • Dirección: calle 67 #28B 36 apto 904B, Manizales, Caldas, Colombia. \n\n Cualquier duda o información adicional será recibida y tramitada mediante su envío a la dirección física o  electrónica de contacto establecidas anteriormente. ',
                style: GoogleFonts.nunito(),
              ),
              Text(
                '\n10. PROCEDIMIENTO PARA EL EJERCICIO DEL DERECHO DE HABEAS DATA:  \n',
                style: GoogleFonts.nunito(),
              ),
              Text(
                'El procedimiento y requisitos mínimos para el ejercicio de los derechos del Titular sobre sus Datos Personales es el siguiente: ',
                style: GoogleFonts.nunito(),
              ),
              Text(
                '\na) Información para radicación de solicitudes: Para la radicación y atención solicitudes se deberá suministrar  la siguiente información: \n\n• Nombre completo y apellidos. \n\n• Datos de contacto (Dirección física y/o electrónica y teléfonos de contacto). \n\n• Medios para recibir respuesta a su solicitud. \n\n• Motivo(s)/hecho(s) que dan lugar al reclamo con una breve descripción del derecho que desea  ejercer (conocer, actualizar, rectificar, solicitar prueba de la autorización otorgada, revocarla,  suprimir, acceder a la información). \n\n• Firma y número de identificación.  \n\n En caso de que la solicitud sea presentada por el causahabiente del Titular, este deberá demostrar dicha  condición por documento que pruebe la calidad de sucesor de la persona fallecida. En caso de que la  solicitud sea presentada por el representante o apoderado del Titular, éste deberá acreditar dicha  representación o apoderamiento, a través de documento idóneo legalmente. \n\n b) Termino para resolver solicitudes: El término máximo previsto por la ley para resolver la reclamación del  Titular es de quince (15) días hábiles, contado a partir del día siguiente a la fecha de su recibo. Cuando no  fuere posible atender el reclamo dentro de dicho término, PERSING informará al interesado los motivos de  la demora y la fecha en que se atenderá su reclamo, la cual en ningún caso podrá superar los ocho (8) días  hábiles siguientes al vencimiento del primer término. \n\n Si el reclamo resulta incompleto, PERSING podrá requerir al interesado dentro de los cinco (5) días  calendario siguientes a la recepción del reclamo para que subsane las fallas. Transcurridos dos (2) meses  desde la fecha del requerimiento, sin que el solicitante presente la información requerida, se entenderá  que ha desistido del reclamo. \n\n En caso de que PERSING no sea competente para resolver el reclamo, dará traslado a quien corresponda  en un término máximo de dos (2) días hábiles e informará de la situación al Titular, con lo cual quedará  relevada de cualquier reclamación o responsabilidad por el uso, rectificación o supresión de los datos. ',
                style: GoogleFonts.nunito(),
              ),
              Text(
                '\n11. CAMBIOS EN LA POLÍTICA DE PRIVACIDAD:\n',
                style: GoogleFonts.nunito(),
              ),
              Text(
                'Cualquier cambio sustancial en la Política de Tratamiento de Datos, será comunicado oportunamente a los  Titulares mediante la publicación en la aplicación PERSING.\n',
                style: GoogleFonts.nunito(),
              ),
              Text(
                '12. VIGENCIA:\n',
                style: GoogleFonts.nunito(),
              ),
              Text(
                'La presente Política para el Tratamiento de Datos Personales rige a partir del 14 de febrero de 2022. Las Bases de Datos en las que se registrarán los Datos Personales tendrán una vigencia igual al tiempo en que  se mantenga y utilice la información para las finalidades para los cuales fueron recolectados, a menos, que  el Titular contacte a PERSING por los medios definidos en el numeral 9 y 10 de esta Política y ejerza su  derecho a la supresión o eliminación de sus Datos Personales.\n',
                style: GoogleFonts.nunito(),
              ),
            ],
          )),
    ));
  }
}
