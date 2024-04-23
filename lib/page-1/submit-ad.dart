import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:image/image.dart' as img;
import 'dart:ui';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/page-1/usuario.dart';
import 'package:myapp/utils.dart';
import 'package:myapp/page-1/home.dart';
import 'dart:convert';

class SubmitAd extends StatefulWidget {
  Usuario? usuario;
  SubmitAd({this.usuario});

  @override
  _SubmitAdState createState() => _SubmitAdState();
}

class _SubmitAdState extends State<SubmitAd> {
  TextEditingController _categoriaController = TextEditingController();
  TextEditingController _tituloController = TextEditingController();
  TextEditingController _precoController = TextEditingController();
  TextEditingController _descricaoController = TextEditingController();
  TextEditingController _autorController = TextEditingController();

  String _categoria = '';
  String _titulo = '';
  String _preco = '';
  String _descricao = '';
  String _autor = '';
  File? _imagemSelecionada;
  Uint8List? _imagemBytes;

  @override
  void initState() {
    super.initState();
    _categoriaController.text = _categoria;
    _tituloController.text = _titulo;
    _precoController.text = _preco;
    _descricaoController.text = _descricao;
    _autorController.text = _autor;
  }

// Função para selecionar uma imagem da galeria

  Future<void> _selecionarImagem() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        PlatformFile file = result.files.first;
        Uint8List? imageBytes = file.bytes;
        if (imageBytes != null) {
          setState(() {
            _imagemBytes = imageBytes;
          });
        } else {
          print('Erro: Não foi possível ler os bytes da imagem.');
        }
      }
    } catch (e) {
      print('Erro ao selecionar a imagem: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    final String? _cidade = widget.usuario?.cidade;
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Container(
              // submitadWXL (1:379)
              padding:
                  EdgeInsets.fromLTRB(16 * fem, 44 * fem, 16 * fem, 278 * fem),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xfff4f6fc),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // criaranncioBtN (1:381)
                    margin:
                        EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 8 * fem),
                    child: Text(
                      'Criar Anúncio',
                      style: SafeGoogleFont(
                        'Poppins',
                        fontSize: 24 * ffem,
                        fontWeight: FontWeight.w700,
                        height: 1.5 * ffem / fem,
                        letterSpacing: -0.48 * fem,
                        color: Color(0xff2e384d),
                      ),
                    ),
                  ),
                  Container(
                    // autogroup6ssv4xA (GDmsy74Cuh9BDof7WS6SSv)
                    width: double.infinity,
                    height: 800 * fem,
                    child: Stack(
                      children: [
                        Positioned(
                          // frame2721Mc (1:382)
                          left: 0 * fem,
                          top: 0 * fem,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 46 * fem),
                            width: 328 * fem,
                            height: 875.97 * fem,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // group283gie (1:383)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 25 * fem),
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // regionheaderbai (1:406)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 0 * fem, 12 * fem),
                                        width: double.infinity,
                                        height: 22 * fem,
                                        child: Text(
                                          'Imagens',
                                          style: SafeGoogleFont(
                                            'Inter',
                                            fontSize: 15 * ffem,
                                            fontWeight: FontWeight.w700,
                                            height: 1.2125 * ffem / fem,
                                            color: Color(0xff2e384d),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // group282t42 (1:384)
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              // group281qjx (1:386)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  0 * fem,
                                                  8.15 * fem),
                                              height: 58.82 * fem,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    // group277x3t (1:387)
                                                    margin: EdgeInsets.fromLTRB(
                                                        0 * fem,
                                                        0 * fem,
                                                        8.76 * fem,
                                                        0 * fem),
                                                    width: 58.82 * fem,
                                                    height: double.infinity,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4 * fem),
                                                    ),
                                                    child: Center(
                                                      // rectangle75GqG (1:388)
                                                      child: SizedBox(
                                                        width: double.infinity,
                                                        height: 58.82 * fem,
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4 * fem),
                                                            border: Border.all(
                                                                color: Color(
                                                                    0x4c359b3f)),
                                                            color: Color(
                                                                0x19359b3f),
                                                            image:
                                                                DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: AssetImage(
                                                                'assets/page-1/images/rectangle-75-bg.png',
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: _selecionarImagem,
                                                    child: Container(
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0 * fem,
                                                              0 * fem,
                                                              8.18 * fem,
                                                              0 * fem),
                                                      width: 58.82 *
                                                          fem, // Largura desejada para o Container
                                                      height: 58.82 *
                                                          fem, // Altura desejada para o Container
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Color(
                                                                0x4c359b3f)),
                                                        color:
                                                            Color(0x19359b3f),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    4 * fem),
                                                      ),
                                                      child: Center(
                                                        child:
                                                            _imagemBytes == null
                                                                ? Image.asset(
                                                                    'assets/page-1/images/plus-1-794.png',
                                                                    width: 12.87 *
                                                                        fem, // Largura desejada para a primeira imagem
                                                                    height: 12.87 *
                                                                        fem, // Altura desejada para a primeira imagem
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  )
                                                                : ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(4 *
                                                                            fem),
                                                                    child: Image
                                                                        .memory(
                                                                      _imagemBytes!,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    // group279y7Q (1:389)
                                                    margin: EdgeInsets.fromLTRB(
                                                        0 * fem,
                                                        0 * fem,
                                                        8.47 * fem,
                                                        0 * fem),
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            22.98 * fem,
                                                            22.98 * fem,
                                                            22.98 * fem,
                                                            22.98 * fem),
                                                    height: double.infinity,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Color(
                                                              0x4c359b3f)),
                                                      color: Color(0x19359b3f),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4 * fem),
                                                    ),
                                                    child: Center(
                                                      // plus1sCn (1:391)
                                                      child: SizedBox(
                                                        width: 12.87 * fem,
                                                        height: 12.87 * fem,
                                                        child: Image.asset(
                                                          'assets/page-1/images/plus-1.png',
                                                          width: 12.87 * fem,
                                                          height: 12.87 * fem,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    // group280PB8 (1:396)
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            22.98 * fem,
                                                            22.98 * fem,
                                                            22.98 * fem,
                                                            22.98 * fem),
                                                    height: double.infinity,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Color(
                                                              0x4c359b3f)),
                                                      color: Color(0x19359b3f),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4 * fem),
                                                    ),
                                                    child: Center(
                                                      // plus16bL (1:398)
                                                      child: SizedBox(
                                                        width: 12.87 * fem,
                                                        height: 12.87 * fem,
                                                        child: Image.asset(
                                                          'assets/page-1/images/plus-1-Dsx.png',
                                                          width: 12.87 * fem,
                                                          height: 12.87 * fem,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              // prepareimagesbeforeuploadingup (1:385)
                                              constraints: BoxConstraints(
                                                maxWidth: 315 * fem,
                                              ),
                                              child: Text(
                                                'Prepare images before uploading. Upload images larger than 750px x 450px. Max number of images is 5. Max image size is 134MB.',
                                                style: SafeGoogleFont(
                                                  'Inter',
                                                  fontSize: 12 * ffem,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.2125 * ffem / fem,
                                                  color: Color(0xff8798ad),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  // regionheaderGeE (1:408)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 20 * fem),
                                  width: double.infinity,
                                  height: 22 * fem,
                                  child: Text(
                                    'Categoria',
                                    style: SafeGoogleFont(
                                      'Inter',
                                      fontSize: 15 * ffem,
                                      fontWeight: FontWeight.w700,
                                      height: 1.2125 * ffem / fem,
                                      color: Color(0xff2e384d),
                                    ),
                                  ),
                                ),
                                Container(
                                  // textinputZdL (18:775)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 24 * fem),
                                  padding: EdgeInsets.fromLTRB(
                                      12 * fem, 6 * fem, 12 * fem, 5 * fem),
                                  width: 316 * fem,
                                  height: 44 * fem,
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Color(0x4c359b3f)),
                                    color: Color(0x19359b3f),
                                    borderRadius:
                                        BorderRadius.circular(4 * fem),
                                  ),
                                  child: Container(
                                    // frame13oQ (I18:775;221:218)
                                    width: 110 * fem,
                                    height: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 2.0 *
                                                  fem), // Adicione um espaço abaixo do rótulo
                                          child: Text(
                                            'CATEGORIA',
                                            style: TextStyle(
                                              fontSize: 10 * fem,
                                              fontWeight: FontWeight.w400,
                                              height: 0.2 * fem,
                                              color: Color(0xffa6b3ac),
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          child: TextField(
                                            maxLength: 20,
                                            controller: _categoriaController,
                                            onChanged: (text) {
                                              setState(() {
                                                _categoria = text;
                                              });
                                            },
                                            obscureText: false,
                                            style:
                                                TextStyle(fontSize: 6.5 * fem),
                                            decoration: InputDecoration(
                                              hintText: '...',
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.transparent),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.transparent),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  // group261zs4 (1:410)
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // regionheaderWqQ (1:411)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 0 * fem, 12 * fem),
                                        width: double.infinity,
                                        height: 22 * fem,
                                        child: Text(
                                          'Detalhes do anúncio',
                                          style: SafeGoogleFont(
                                            'Inter',
                                            fontSize: 15 * ffem,
                                            fontWeight: FontWeight.w700,
                                            height: 1.2125 * ffem / fem,
                                            color: Color(0xff2e384d),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // frame271NMp (1:412)
                                        width: double.infinity,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              // textinputv8S (1:413)
                                              padding: EdgeInsets.fromLTRB(
                                                  12 * fem,
                                                  5 * fem,
                                                  12 * fem,
                                                  4 * fem),
                                              width: double.infinity,
                                              height: 42 * fem,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Color(0x4c359b3f)),
                                                color: Color(0x19359b3f),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        4 * fem),
                                              ),
                                              child: Container(
                                                // frame1pDp (I1:413;221:218)
                                                width: 210 * fem,
                                                height: double.infinity,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 2.0 *
                                                              fem), // Adicione um espaço abaixo do rótulo
                                                      child: Text(
                                                        'TÍTULO',
                                                        style: TextStyle(
                                                          fontSize: 10 * fem,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          height: 0.2 * fem,
                                                          color:
                                                              Color(0xffa6b3ac),
                                                        ),
                                                      ),
                                                    ),
                                                    Flexible(
                                                      child: TextField(
                                                        maxLength: 50,
                                                        controller:
                                                            _tituloController,
                                                        onChanged: (text) {
                                                          setState(() {
                                                            _titulo = text;
                                                          });
                                                        },
                                                        obscureText: false,
                                                        style: TextStyle(
                                                            fontSize:
                                                                6.5 * fem),
                                                        decoration:
                                                            InputDecoration(
                                                          hintText: '...',
                                                          enabledBorder:
                                                              UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .transparent),
                                                          ),
                                                          focusedBorder:
                                                              UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .transparent),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 16 * fem,
                                            ),
                                            Container(
                                              // textinputv8S (1:413)
                                              padding: EdgeInsets.fromLTRB(
                                                  12 * fem,
                                                  5 * fem,
                                                  12 * fem,
                                                  4 * fem),
                                              width: double.infinity,
                                              height: 42 * fem,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Color(0x4c359b3f)),
                                                color: Color(0x19359b3f),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        4 * fem),
                                              ),
                                              child: Container(
                                                // frame1pDp (I1:413;221:218)
                                                width: 210 * fem,
                                                height: double.infinity,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 2.0 *
                                                              fem), // Adicione um espaço abaixo do rótulo
                                                      child: Text(
                                                        'AUTOR',
                                                        style: TextStyle(
                                                          fontSize: 10 * fem,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          height: 0.2 * fem,
                                                          color:
                                                              Color(0xffa6b3ac),
                                                        ),
                                                      ),
                                                    ),
                                                    Flexible(
                                                      child: TextField(
                                                        maxLength: 20,
                                                        controller:
                                                            _autorController,
                                                        onChanged: (text) {
                                                          setState(() {
                                                            _autor = text;
                                                          });
                                                        },
                                                        obscureText: false,
                                                        style: TextStyle(
                                                            fontSize:
                                                                6.5 * fem),
                                                        decoration:
                                                            InputDecoration(
                                                          hintText: '...',
                                                          enabledBorder:
                                                              UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .transparent),
                                                          ),
                                                          focusedBorder:
                                                              UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .transparent),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 16 * fem,
                                            ),
                                            Container(
                                              // group258bdt (1:415)
                                              width: 316 * fem,
                                              height: 42 * fem,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        4 * fem),
                                              ),
                                              child: Container(
                                                // textinputwSr (1:416)
                                                padding: EdgeInsets.fromLTRB(
                                                    12 * fem,
                                                    5 * fem,
                                                    12 * fem,
                                                    4 * fem),
                                                width: double.infinity,
                                                height: double.infinity,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Color(0x4c359b3f)),
                                                  color: Color(0x19359b3f),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4 * fem),
                                                ),
                                                child: Container(
                                                  // frame1Tvz (I1:416;221:218)
                                                  width: 34 * fem,
                                                  height: double.infinity,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: 2.0 *
                                                                fem), // Adicione um espaço abaixo do rótulo
                                                        child: Text(
                                                          'PREÇO',
                                                          style: TextStyle(
                                                            fontSize: 10 * fem,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            height: 0.2 * fem,
                                                            color: Color(
                                                                0xffa6b3ac),
                                                          ),
                                                        ),
                                                      ),
                                                      Flexible(
                                                        child: TextField(
                                                          maxLength: 6,
                                                          controller:
                                                              _precoController,
                                                          onChanged: (text) {
                                                            setState(() {
                                                              _preco = text;
                                                            });
                                                          },
                                                          obscureText: false,
                                                          style: TextStyle(
                                                              fontSize:
                                                                  6.5 * fem),
                                                          decoration:
                                                              InputDecoration(
                                                            hintText: '...',
                                                            enabledBorder:
                                                                UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .transparent),
                                                            ),
                                                            focusedBorder:
                                                                UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .transparent),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 16 * fem,
                                            ),
                                            Container(
                                              // textinput4Qz (1:424)
                                              padding: EdgeInsets.fromLTRB(
                                                  12 * fem,
                                                  5 * fem,
                                                  12 * fem,
                                                  5 * fem),
                                              width: double.infinity,
                                              height: 100 * fem,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Color(0x4c359b3f)),
                                                color: Color(0x19359b3f),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        4 * fem),
                                              ),
                                              child: TextField(
                                                controller:
                                                    _descricaoController,
                                                onChanged: (text) {
                                                  setState(() {
                                                    _descricao =
                                                        text; // Atualiza o valor do _nomeUsuario à medida que o usuário digita
                                                  });
                                                },
                                                obscureText: false,
                                                style: TextStyle(
                                                    fontSize: 6.5 * fem),
                                                decoration: InputDecoration(
                                                  labelText: 'DESCRIÇÃO',
                                                  labelStyle: TextStyle(
                                                    fontSize: 10 * fem,
                                                    fontWeight: FontWeight.w400,
                                                    height: 0.7,
                                                    color: Color(0xffa6b3ac),
                                                  ),
                                                  hintText: 'Digite aqui...',
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            Colors.transparent),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            Colors.transparent),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          // group276ugW (1:430)
                          left: 0 * fem,
                          //top: 755 * fem,
                          bottom: 0,
                          child: Container(
                            width: 328 * fem,
                            height: 40 * fem,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4 * fem),
                            ),
                            child: Container(
                              // group275q4N (1:431)
                              width: double.infinity,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4 * fem),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // simplebtnAcS (1:433)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 15.57 * fem, 0 * fem),
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => MyHome(
                                                    usuario: widget.usuario,
                                                  )), // Chama diretamente o widget Product
                                        );
                                      },
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                      ),
                                      child: Container(
                                        width: 156.7 * fem,
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Color(0xffbdd1d2),
                                          borderRadius:
                                              BorderRadius.circular(4 * fem),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Cancelar',
                                            textAlign: TextAlign.center,
                                            style: SafeGoogleFont(
                                              'Inter',
                                              fontSize: 15 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.2125 * ffem / fem,
                                              color: Color(0xff25666c),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      // Dados a serem enviados no corpo da solicitação POST

                                      Map<String, dynamic> body = {
                                        'categoria': _categoria,
                                        'titulo': _titulo,
                                        'autor': _autor,
                                        'preco':
                                            _preco, // O preço deve ser um número, não uma string,
                                        'descricao': _descricao,
                                        'estado':
                                            widget.usuario?.estado ?? 'MT',
                                        'cidade':
                                            widget.usuario?.celular ?? _cidade,
                                        'foto': _imagemBytes != null
                                            ? base64.encode(_imagemBytes!)
                                            : null
                                      };

                                      // URL da API
                                      String apiUrl =
                                          'http://localhost:3001/api/livros';

                                      // Converte o mapa para uma string JSON usando jsonEncode
                                      String requestBody = jsonEncode(body);

                                      // Realiza a solicitação POST com o corpo em formato JSON
                                      http.Response response = await http.post(
                                        Uri.parse(apiUrl),
                                        headers: <String, String>{
                                          'Content-Type':
                                              'application/json; charset=UTF-8',
                                        },
                                        body: requestBody,
                                      );

                                      // Verifica a resposta
                                      if (response.statusCode == 200) {
                                        print('Solicitação POST bem-sucedida!');

                                        // Navega para a página MyHome após uma resposta bem-sucedida
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => MyHome(
                                              usuario: widget.usuario,
                                            ),
                                          ),
                                        );
                                      } else {
                                        print(
                                            'Erro na solicitação POST. Código de status: ${response.statusCode}');
                                      }
                                    },
                                    child: Container(
                                      // simplebtn1sx (1:432)
                                      width: 155.73 * fem,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Color(0xff35889b),
                                        borderRadius:
                                            BorderRadius.circular(4 * fem),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Enviar',
                                          textAlign: TextAlign.center,
                                          style: SafeGoogleFont(
                                            'Inter',
                                            fontSize: 15 * ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.2125 * ffem / fem,
                                            color: Color(0xffffffff),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
