import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:image/image.dart' as img;
import 'dart:ui';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/utils.dart';
import 'package:myapp/page-1/usuario.dart';
import 'package:myapp/page-1/product-detail.dart';

class Livro extends StatelessWidget {
  final double fem;
  final double ffem;
  final String categoria;
  final String titulo;
  final String preco;
  final String cidade;
  final String estado;
  final String foto;
  final String descricao;
  Usuario? usuario;
  final Usuario u2 = Usuario(
      nome: '',
      email: '',
      celular: '',
      estado: '',
      cidade: '',
      descricao: '',
      senha: '',
      fotoPerfil: '');

  Livro(
      {required this.fem,
      required this.ffem,
      required this.categoria,
      required this.titulo,
      required this.cidade,
      required this.preco,
      required this.estado,
      required this.foto,
      required this.descricao,
      this.usuario});

  factory Livro.fromJson(Map<String, dynamic> json) {
    return Livro(
      fem: json['fem'] != null ? json['fem'].toDouble() : 1.0,
      ffem: json['ffem'] != null ? json['ffem'].toDouble() : 1.0,
      categoria: json['categoria'] ?? '',
      titulo: json['titulo'] ?? '',
      preco: json['preco'] ?? '',
      cidade: json['cidade'] ?? '',
      estado: json['estado'] ?? '',
      foto: json['foto'] ?? '',
      descricao: json['descricao'] ?? '',
    );
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("SEGUE FOTO ${foto}");
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Product(
                  livro: Livro(
                    fem: fem, ffem: ffem, categoria: categoria, titulo: titulo,
                    cidade: cidade,
                    preco: preco,
                    estado: estado,
                    foto: foto,
                    descricao: descricao,
                    usuario: usuario,
                    // Ajuste o tamanho do livro conforme necessário
                  ),
                  usuario: usuario)),
        );
      },
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 160 * fem,
              height: 136 * fem,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4 * fem),
                  color: Color(0xff2f303b),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: MemoryImage(base64.decode(foto)),
                  )),
            ),
            SizedBox(height: 8 * fem),
            Text(
              '$titulo',
              style: TextStyle(
                fontSize: 15 * ffem,
                fontWeight: FontWeight.w400,
                color: Color(0xff2e384d),
              ),
            ),
            SizedBox(height: 4 * fem),
            Row(
              children: [
                Image.asset(
                  'assets/page-1/images/location-sg6.png',
                  width: 8.18 * fem,
                  height: 10 * fem,
                ),
                Text(
                  '$estado',
                  style: TextStyle(
                    fontSize: 10 * ffem,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.025 * fem,
                    color: Color(0xff3eb78c),
                  ),
                ),
                SizedBox(width: 8 * fem),
                Text(
                  '$categoria',
                  style: TextStyle(
                    fontSize: 10 * ffem,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.025 * fem,
                    color: Color(0xffeb5757),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4 * fem),
            Text(
              'R\$ $preco',
              style: TextStyle(
                fontSize: 15 * ffem,
                fontWeight: FontWeight.w400,
                color: Color(0xff8798ad),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListaDeLivros extends StatelessWidget {
  final List<Livro> livros;
  final double fem;
  final double ffem;

  ListaDeLivros({
    required this.livros,
    required this.fem,
    required this.ffem,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate((livros.length / 2).ceil(), (index) {
        int startIndex = index * 2;
        int endIndex = startIndex + 1;
        bool isLastRow = endIndex >= livros.length;

        return Row(
          children: [
            Container(
              width: 200 * fem,
              margin: EdgeInsets.all(6.0),
              child: Livro(
                fem: fem,
                ffem: ffem,
                categoria: livros[startIndex].categoria,
                titulo: livros[startIndex].titulo,
                cidade: livros[startIndex].cidade,
                preco: livros[startIndex].preco,
                estado: livros[startIndex].estado,
                foto: livros[startIndex].foto,
                descricao: livros[startIndex].descricao,
              ),
            ),
            if (!isLastRow)
              Container(
                width: 200 * fem,
                margin: EdgeInsets.all(6.0),
                child: Livro(
                  fem: fem,
                  ffem: ffem,
                  categoria: livros[endIndex].categoria,
                  titulo: livros[endIndex].titulo,
                  cidade: livros[endIndex].cidade,
                  preco: livros[endIndex].preco,
                  estado: livros[endIndex].estado,
                  foto: livros[endIndex].foto,
                  descricao: livros[endIndex].descricao,
                ),
              ),
          ],
        );
      }),
    );
  }
}
