import 'package:flutter/material.dart';

class ComentarioWidget extends StatelessWidget {
  final String data;
  final String nomeUsuario;
  final String fotoPerfil;
  final String conteudo;
  final double fem;
  final double ffem;

  ComentarioWidget({
    required this.data,
    required this.nomeUsuario,
    required this.fotoPerfil,
    required this.conteudo,
    required this.fem,
    required this.ffem,
  });

  factory ComentarioWidget.fromJson(Map<String, dynamic> json) {
    return ComentarioWidget(
      data: json['data'],
      nomeUsuario: json['nomeUsuario'],
      fotoPerfil: json['fotoPerfil'],
      conteudo: json['conteudo'],
      fem: json['fem'],
      ffem: json['ffem'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'nomeUsuario': nomeUsuario,
      'fotoPerfil': fotoPerfil,
      'conteudo': conteudo,
      'fem': fem,
      'ffem': ffem,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 16 * fem),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16 * fem,
                backgroundImage: AssetImage(fotoPerfil),
              ),
              SizedBox(width: 8 * fem),
              Text(
                nomeUsuario,
                style: TextStyle(
                  fontSize: 16 * ffem,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 8 * fem, 0, 8 * fem),
            child: Text(
              data,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14 * ffem,
                fontWeight: FontWeight.w600,
                color: Color(0xffacaec1),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16 * fem),
            child: Text(
              conteudo,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 15 * ffem,
                color: Color(0xff2e384d),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ListaComentarios extends StatelessWidget {
  final List<ComentarioWidget> comentarios;

  ListaComentarios({required this.comentarios});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: comentarios.map((comentario) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: comentario,
          );
        }).toList(),
      ),
    );
  }
}
