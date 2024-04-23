import 'package:flutter/material.dart';
import 'package:myapp/page-1/product-detail.dart';
import 'package:myapp/page-1/submit-ad.dart';
import 'package:flutter/material.dart';
import 'package:myapp/page-1/product-detail.dart';
import 'package:myapp/page-1/submit-ad.dart';
import 'package:myapp/page-1/usuario.dart';

Widget criarAnuncio(double fem, double ffem, BuildContext context,
    {Usuario? usuario}) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SubmitAd(
              usuario: usuario), // Passa o parâmetro usuario para SubmitAd
        ),
      );
    },
    child: Container(
      padding: EdgeInsets.fromLTRB(5 * fem, 4 * fem, 0 * fem, 3 * fem),
      width: double.infinity,
      height: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 13 * fem, 1 * fem),
            width: 14 * fem,
            height: 14 * fem,
            child: Image.asset(
              'assets/page-1/images/plus-1-KR4.png',
              width: 14 * fem,
              height: 14 * fem,
            ),
          ),
          Text(
            'Criar Anuncio',
            style: TextStyle(
              fontSize: 11 * ffem,
              fontWeight: FontWeight.w500,
              height: 1.5 * ffem / fem,
              letterSpacing: 0.0275 * fem,
              color: Color(0xffffffff),
            ),
          ),
        ],
      ),
    ),
  );
}
