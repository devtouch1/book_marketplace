import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/utils.dart';
import 'package:myapp/page-1/product-detail.dart';
import 'package:myapp/page-1/livro.dart';
import 'package:myapp/page-1/usuario.dart';

class Recentes extends StatelessWidget {
  final double fem;
  final double ffem;
  final ListaDeLivros library;
  final Usuario? usuario;

  Recentes(
      {required this.fem,
      required this.ffem,
      this.usuario,
      required this.library});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(16 * fem, 0 * fem, 0 * fem, 16 * fem),
          width: 342 * fem,
          height: 22 * fem,
          child: Text(
            'Mais recentes',
            style: TextStyle(
              fontSize: 15 * ffem,
              fontWeight: FontWeight.w700,
              color: Color(0xff2e384d),
            ),
          ),
        ),
        library,
      ],
    );
  }
}
