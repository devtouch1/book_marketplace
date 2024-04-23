import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:image/image.dart' as img;
import 'dart:ui';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/utils.dart';
import 'package:myapp/page-1/home.dart';
import 'package:myapp/page-1/livro.dart';
import 'package:myapp/page-1/usuario.dart';
import 'package:myapp/page-1/comentarios.dart';

class Product extends StatefulWidget {
  final Livro livro; // Adicione um campo para armazenar o objeto Livro
  final Usuario? usuario;

  Product(
      {required this.livro,
      this.usuario}); // Modifique o construtor para receber um objeto Livro

  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  TextEditingController _comentarioController = TextEditingController();
  String _comentario = '';
  String? _nomeUsuario;
  String? _celularUsuario;
  String? _fotoPerfilUsuario;
  final List<ComentarioWidget> coments = [];
  @override
  void initState() {
    super.initState();
    _comentarioController.text = _comentario;
    _carregarDadosUsuario();
    _carregarComentarios();
  }

  Future<void> _postComentario(ComentarioWidget comentario) async {
    final url =
        'http://seu-servidor.com/api/comentarios'; // Substitua pelo URL correto da sua API

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type':
              'application/json', // Especifica o tipo de conteúdo como JSON
        },
        body: json.encode(
            comentario.toJson()), // Converte o objeto para uma string JSON
      );

      if (response.statusCode == 200) {
        print('Comentário postado com sucesso!');
        // Atualize a lista de comentários ou faça outras ações necessárias após postar o comentário
      } else {
        print(
            'Falha ao postar o comentário. Status code: ${response.statusCode}');
        // Trate a falha de acordo com sua lógica de aplicativo
      }
    } catch (error) {
      print('Erro ao postar o comentário: $error');
      // Trate o erro de acordo com sua lógica de aplicativo
    }
  }

  Future<void> _carregarComentarios() async {
    try {
      // Faça a requisição GET para a API para obter os comentários
      var response = await http.get(Uri.parse('sua_url_da_api/comentarios'));

      if (response.statusCode == 200) {
        // Se a requisição for bem-sucedida, decodifique a resposta JSON
        var jsonResponse = json.decode(response.body);
        // Crie uma lista de comentários a partir dos dados decodificados
        List<ComentarioWidget> comentarios =
            (jsonResponse as List).map((comentario) {
          return ComentarioWidget.fromJson(comentario);
        }).toList();

        // Adicione os ComentarioWidget à lista coments
        setState(() {
          coments.addAll(comentarios.map((comentario) => comentario));
        });
      } else {
        // Se a requisição falhar, imprima o código de status
        print(
            'Erro na requisição GET. Código de status: ${response.statusCode}');
      }
    } catch (error) {
      // Erro ao fazer a requisição
      print('Erro ao carregar os comentários: $error');
    }
  }

  Future<void> _carregarDadosUsuario() async {
    try {
      print('WIDGET CIDADE${widget.livro.cidade}');
      final String celular = widget.livro.cidade;
      final Map<String, String> dados = {
        'celular': celular,
      };

      final response = await http.post(
        Uri.parse('http://localhost:3001/api/usuarios/pesquisar'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(dados),
      );
      // Faça uma requisição à rota /api/usuarios/pesquisar passando o número de celular

      // Verifique se a requisição foi bem-sucedida (código de status 200)
      if (response.statusCode == 200) {
        // Parseie os dados da resposta JSON
        final Map<String, dynamic> data = json.decode(response.body);
        print(data);
        print('NOME ${data['nome']}');
        // Extraia os dados do usuário da resposta
        setState(() {
          _nomeUsuario = data['nome'];
          _celularUsuario = data['celular'];
          _fotoPerfilUsuario = data['fotoPerfil'];
          print('NOMEUSUARIO_${_nomeUsuario}');
          print(_celularUsuario);
          print(_fotoPerfilUsuario);
        });
      } else {
        // Caso contrário, trate o erro, por exemplo, exibindo uma mensagem de erro
        print(
            'Erro ao carregar dados do usuário. Código de status: ${response.statusCode}');
      }
    } catch (error) {
      // Caso ocorra um erro durante a requisição, trate o erro adequadamente
      print('Erro ao carregar dados do usuário: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Container(
              // productdetailvTC (1:223)
              width: double.infinity,
              height: 1416 * fem,
              decoration: BoxDecoration(
                color: Color(0xffffffff),
              ),
              child: Stack(
                children: [
                  Positioned(
                    // rectangle37vEE (1:224)
                    left: 0 * fem,
                    top: 0 * fem,
                    child: Align(
                      child: SizedBox(
                        width: 360 * fem,
                        height: 376 * fem,
                        child: Image.memory(
                          base64.decode(widget.livro.foto),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    // rectangle48Bfx (1:225)
                    left: 0 * fem,
                    top: 365 * fem,
                    child: Align(
                      child: SizedBox(
                        width: 360 * fem,
                        height: 1051 * fem,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xfff4f6fc),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8 * fem),
                              topRight: Radius.circular(8 * fem),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    // group148pyp (1:227)
                    left: 16 * fem,
                    top: 36 * fem,
                    child: Align(
                      child: SizedBox(
                        width: 32 * fem,
                        height: 32 * fem,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyHome(
                                        usuario: widget.livro.usuario,
                                      )),
                            );
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                          child: Image.asset(
                            'assets/page-1/images/group-148.png',
                            width: 32 * fem,
                            height: 32 * fem,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    // frame180gWE (1:231)
                    left: 0 * fem,
                    top: 376 * fem,
                    child: Container(
                      width: 366 * fem,
                      height: 1073 * fem,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // autogroupxt4rykE (GDmiViAy8uATeeb6FTXt4r)
                            padding: EdgeInsets.fromLTRB(
                                16 * fem, 0 * fem, 22 * fem, 16 * fem),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // group1776K4 (1:237)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 15 * fem),
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // group175HXx (1:238)
                                        width: double.infinity,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // mistrio1D4 (1:239)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  227 * fem,
                                                  0 * fem),
                                              child: Text(
                                                widget.livro.categoria,
                                                style: SafeGoogleFont(
                                                  'Inter',
                                                  fontSize: 14 * ffem,
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.2125 * ffem / fem,
                                                  color: Color(0xffeb5757),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              // spsppwC (1:240)
                                              widget.livro.estado,
                                              textAlign: TextAlign.right,
                                              style: SafeGoogleFont(
                                                'Inter',
                                                fontSize: 14 * ffem,
                                                fontWeight: FontWeight.w700,
                                                height: 1.2125 * ffem / fem,
                                                color: Color(0xff3eb78c),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8 * fem,
                                      ),
                                      Container(
                                        // group176Lee (1:241)
                                        width: double.infinity,
                                        height: 52 * fem,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              // group173gTc (1:243)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  118 * fem,
                                                  0 * fem),
                                              width: 156 * fem,
                                              height: double.infinity,
                                              child: Stack(
                                                children: [
                                                  Positioned(
                                                    // arsnelupinp42 (1:244)
                                                    left: 0 * fem,
                                                    top: 0 * fem,
                                                    child: Align(
                                                      child: SizedBox(
                                                        width: 156 * fem,
                                                        height: 36 * fem,
                                                        child: Text(
                                                          widget.livro.titulo,
                                                          style: SafeGoogleFont(
                                                            'Poppins',
                                                            fontSize: 24 * ffem,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.5 *
                                                                ffem /
                                                                fem,
                                                            letterSpacing:
                                                                0.06 * fem,
                                                            color: Color(
                                                                0xff2e384d),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    // r6500piE (1:245)
                                                    left: 0 * fem,
                                                    top: 28 * fem,
                                                    child: Align(
                                                      child: SizedBox(
                                                        width: 71 * fem,
                                                        height: 24 * fem,
                                                        child: Text(
                                                          'R\$ ${widget.livro.preco}',
                                                          style: SafeGoogleFont(
                                                            'Poppins',
                                                            fontSize: 16 * ffem,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            height: 1.5 *
                                                                ffem /
                                                                fem,
                                                            letterSpacing:
                                                                0.04 * fem,
                                                            color: Color(
                                                                0xff8798ad),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              // group1745eA (1:246)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  0 * fem,
                                                  16 * fem),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    // group1071Gv (1:251)
                                                    margin: EdgeInsets.fromLTRB(
                                                        0 * fem,
                                                        0 * fem,
                                                        6 * fem,
                                                        0 * fem),
                                                    width: 24 * fem,
                                                    height: 24 * fem,
                                                    child: Image.asset(
                                                      'assets/page-1/images/group-107-aJN.png',
                                                      width: 24 * fem,
                                                      height: 24 * fem,
                                                    ),
                                                  ),
                                                  Container(
                                                    // group106WzN (1:247)
                                                    width: 24 * fem,
                                                    height: 24 * fem,
                                                    child: Image.asset(
                                                      'assets/page-1/images/group-106-RAi.png',
                                                      width: 24 * fem,
                                                      height: 24 * fem,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8 * fem,
                                      ),
                                      Container(
                                        // livrooladrodecasacaarsnelupinv (1:261)
                                        margin: EdgeInsets.fromLTRB(
                                            2 * fem, 0 * fem, 0 * fem, 0 * fem),
                                        constraints: BoxConstraints(
                                          maxWidth: 317 * fem,
                                        ),
                                        child: Text(
                                          widget.livro.descricao,
                                          style: SafeGoogleFont(
                                            'Inter',
                                            fontSize: 15 * ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.2125 * ffem / fem,
                                            color: Color(0xff2e384d),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  // contactadownerUJv (1:262)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 16 * fem),
                                  padding: EdgeInsets.fromLTRB(
                                      10 * fem, 10 * fem, 10 * fem, 10 * fem),
                                  width: double.infinity,
                                  height: 137 * fem,
                                  decoration: BoxDecoration(
                                    color: Color(0xffffffff),
                                    borderRadius:
                                        BorderRadius.circular(4 * fem),
                                  ),
                                  child: Container(
                                    // group151MNi (I1:262;313:4313)
                                    width: double.infinity,
                                    height: double.infinity,
                                    child: Container(
                                      // group139K4e (I1:262;313:900)
                                      width: double.infinity,
                                      height: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            // group190rKU (I1:262;371:1734)
                                            margin: EdgeInsets.fromLTRB(0 * fem,
                                                0 * fem, 97 * fem, 15 * fem),
                                            width: double.infinity,
                                            height: 62 * fem,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  // ellipse9mxE (I1:262;313:901)
                                                  margin: EdgeInsets.fromLTRB(
                                                      0 * fem,
                                                      0 * fem,
                                                      16 * fem,
                                                      1 * fem),
                                                  width: 57 * fem,
                                                  height: 57 * fem,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            28.5 * fem),
                                                    image: _fotoPerfilUsuario !=
                                                            null
                                                        ? DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: MemoryImage(
                                                                base64.decode(
                                                                    _fotoPerfilUsuario!)),
                                                          )
                                                        : null,
                                                  ),
                                                ),
                                                Container(
                                                  // group138SYa (I1:262;313:902)
                                                  height: double.infinity,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      if (_nomeUsuario != null)
                                                        Text(
                                                          // peterthorntonaPt (I1:262;313:903)
                                                          _nomeUsuario!,
                                                          style: SafeGoogleFont(
                                                            'Inter',
                                                            fontSize: 15 * ffem,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            height: 1.2125 *
                                                                ffem /
                                                                fem,
                                                            color: Color(
                                                                0xff000000),
                                                          ),
                                                        ),
                                                      Container(
                                                        // group137stn (I1:262;313:905)
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                0 * fem,
                                                                0 * fem,
                                                                0 * fem,
                                                                4.4 * fem),
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                1.63 * fem,
                                                                1.63 * fem,
                                                                1.63 * fem,
                                                                2.43 * fem),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              // star1jvz (I1:262;313:906)
                                                              margin: EdgeInsets
                                                                  .fromLTRB(
                                                                      0 * fem,
                                                                      0 * fem,
                                                                      3.27 *
                                                                          fem,
                                                                      0 * fem),
                                                              width:
                                                                  16.33 * fem,
                                                              height:
                                                                  15.53 * fem,
                                                              child:
                                                                  Image.asset(
                                                                'assets/page-1/images/star-1.png',
                                                                width:
                                                                    16.33 * fem,
                                                                height:
                                                                    15.53 * fem,
                                                              ),
                                                            ),
                                                            Container(
                                                              // star2dHc (I1:262;313:910)
                                                              margin: EdgeInsets
                                                                  .fromLTRB(
                                                                      0 * fem,
                                                                      0 * fem,
                                                                      3.27 *
                                                                          fem,
                                                                      0 * fem),
                                                              width:
                                                                  16.33 * fem,
                                                              height:
                                                                  15.53 * fem,
                                                              child:
                                                                  Image.asset(
                                                                'assets/page-1/images/star-2.png',
                                                                width:
                                                                    16.33 * fem,
                                                                height:
                                                                    15.53 * fem,
                                                              ),
                                                            ),
                                                            Container(
                                                              // star3WcJ (I1:262;313:908)
                                                              margin: EdgeInsets
                                                                  .fromLTRB(
                                                                      0 * fem,
                                                                      0 * fem,
                                                                      3.27 *
                                                                          fem,
                                                                      0 * fem),
                                                              width:
                                                                  16.33 * fem,
                                                              height:
                                                                  15.53 * fem,
                                                              child:
                                                                  Image.asset(
                                                                'assets/page-1/images/star-3.png',
                                                                width:
                                                                    16.33 * fem,
                                                                height:
                                                                    15.53 * fem,
                                                              ),
                                                            ),
                                                            Container(
                                                              // star4cvE (I1:262;313:912)
                                                              margin: EdgeInsets
                                                                  .fromLTRB(
                                                                      0 * fem,
                                                                      0 * fem,
                                                                      3.27 *
                                                                          fem,
                                                                      0 * fem),
                                                              width:
                                                                  16.33 * fem,
                                                              height:
                                                                  15.53 * fem,
                                                              child:
                                                                  Image.asset(
                                                                'assets/page-1/images/star-4.png',
                                                                width:
                                                                    16.33 * fem,
                                                                height:
                                                                    15.53 * fem,
                                                              ),
                                                            ),
                                                            Container(
                                                              // star58dg (I1:262;313:914)
                                                              width:
                                                                  16.33 * fem,
                                                              height:
                                                                  15.53 * fem,
                                                              child:
                                                                  Image.asset(
                                                                'assets/page-1/images/star-5.png',
                                                                width:
                                                                    16.33 * fem,
                                                                height:
                                                                    15.53 * fem,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Text(
                                                        // fNi (I1:262;313:904)
                                                        _celularUsuario ?? "",
                                                        style: SafeGoogleFont(
                                                          'Inter',
                                                          fontSize: 15 * ffem,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          height: 1.2125 *
                                                              ffem /
                                                              fem,
                                                          color:
                                                              Color(0xff8798ad),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            // simplebtnBrr (I1:262;371:1688)
                                            margin: EdgeInsets.fromLTRB(
                                                75 * fem,
                                                0 * fem,
                                                0 * fem,
                                                0 * fem),
                                            width: 233 * fem,
                                            height: 40 * fem,
                                            decoration: BoxDecoration(
                                              color: Color(0xffbdd1d2),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      4 * fem),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Ver Perfil',
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
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                ListaComentarios(comentarios: [
                                  ComentarioWidget(
                                    fem: fem,
                                    ffem: ffem,
                                    nomeUsuario: 'Nome do Usuário',
                                    fotoPerfil:
                                        'assets/page-1/images/ellipse-16-bg.png',
                                    data: 'Today 04:00 PM',
                                    conteudo:
                                        'First thing you need to do is to create your own account which will allow you.',
                                  )
                                ]),
                                Container(
                                  // group171xpz (1:274)
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // deixeseucomentrioK9k (1:275)
                                        margin: EdgeInsets.fromLTRB(
                                            0 * fem, 0 * fem, 0 * fem, 6 * fem),
                                        child: Text(
                                          'Deixe seu comentário',
                                          style: SafeGoogleFont(
                                            'Poppins',
                                            fontSize: 16 * ffem,
                                            fontWeight: FontWeight.w600,
                                            height: 1.5 * ffem / fem,
                                            color: Color(0xff2e384d),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // frame1521oG (1:276)
                                        width: double.infinity,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              // textinputmXY (18:780)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  0 * fem,
                                                  6 * fem),
                                              width: 316 * fem,
                                              height: 44 * fem,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Color(0x4c359b3f)),
                                                color: Color(0x19359b3f),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        4 * fem),
                                              ),
                                              child: Expanded(
                                                child: TextField(
                                                  controller:
                                                      _comentarioController,
                                                  onChanged: (text) {
                                                    setState(() {
                                                      _comentario =
                                                          text; // Atualiza o valor do _nomeUsuario à medida que o usuário digita
                                                    });
                                                  },
                                                  obscureText: false,
                                                  style:
                                                      TextStyle(fontSize: 40),
                                                  decoration: InputDecoration(
                                                    labelText: null,
                                                    labelStyle: TextStyle(
                                                      fontSize: 40,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 0.7,
                                                      color: Color(0xffa6b3ac),
                                                    ),
                                                    hintText: 'Digite aqui...',
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
                                            ),
                                            GestureDetector(
                                              onTap: () {},
                                              child: Container(
                                                // simplebtnt6N (1:278)
                                                width: double.infinity,
                                                height: 40 * fem,
                                                decoration: BoxDecoration(
                                                  color: Color(0xff35889b),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4 * fem),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'Enviar',
                                                    textAlign: TextAlign.center,
                                                    style: SafeGoogleFont(
                                                      'Inter',
                                                      fontSize: 15 * ffem,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height:
                                                          1.2125 * ffem / fem,
                                                      color: Color(0xffffffff),
                                                    ),
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
                          Container(
                            // group179kPU (1:279)
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  // regionheaderJQz (1:285)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 18 * fem),
                                  width: 350 * fem,
                                  height: 22 * fem,
                                  child: Text(
                                    'Mais anúncios             ',
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
                                  // group145nb4 (1:280)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 6 * fem, 0 * fem),
                                  width: 360 * fem,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // autogrouphjsa7tE (GDmkgZhGKn98HRFVF9HjSA)
                                        margin: EdgeInsets.fromLTRB(
                                            0 * fem, 0 * fem, 0 * fem, 4 * fem),
                                        width: double.infinity,
                                        height: 194 * fem,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // productedgedcarde7U (1:281)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  4 * fem,
                                                  0 * fem),
                                              width: 178 * fem,
                                              height: double.infinity,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    // autogroupyenvXh4 (GDmkr4RSg6GwvV1gVAyENv)
                                                    width: double.infinity,
                                                    height: 138 * fem,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xff2f303b),
                                                      image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: AssetImage(
                                                          'assets/page-1/images/rectangle-35-bg-mMc.png',
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    // autogroupbybqSZ8 (GDmkwDwWGYRGi5cuiubybQ)
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            8 * fem,
                                                            8 * fem,
                                                            8 * fem,
                                                            7 * fem),
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xffffffff),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          // producttitle9yL (I1:281;239:615)
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  3 * fem),
                                                          child: Text(
                                                            'Product title....',
                                                            style:
                                                                SafeGoogleFont(
                                                              'Inter',
                                                              fontSize:
                                                                  15 * ffem,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              height: 1.2125 *
                                                                  ffem /
                                                                  fem,
                                                              color: Color(
                                                                  0xff2e384d),
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          // xaf3J2 (I1:281;239:616)
                                                          'R\$ 65,00',
                                                          style: SafeGoogleFont(
                                                            'Inter',
                                                            fontSize: 15 * ffem,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            height: 1.2125 *
                                                                ffem /
                                                                fem,
                                                            color: Color(
                                                                0xff8798ad),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              // productedgedcardySa (1:282)
                                              width: 178 * fem,
                                              height: double.infinity,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    // autogroup6dfxv6v (GDmmAiZ2Et5rpxkmH46dfx)
                                                    width: double.infinity,
                                                    height: 138 * fem,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xff2f303b),
                                                      image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: AssetImage(
                                                          'assets/page-1/images/rectangle-35-bg-d8N.png',
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    // autogroupnyziS5G (GDmmFP5v8aY645h2yXNyzi)
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            8 * fem,
                                                            8 * fem,
                                                            8 * fem,
                                                            7 * fem),
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xffffffff),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          // producttitleDVL (I1:282;239:615)
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  3 * fem),
                                                          child: Text(
                                                            'Product title....',
                                                            style:
                                                                SafeGoogleFont(
                                                              'Inter',
                                                              fontSize:
                                                                  15 * ffem,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              height: 1.2125 *
                                                                  ffem /
                                                                  fem,
                                                              color: Color(
                                                                  0xff2e384d),
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          // xafiwt (I1:282;239:616)
                                                          'R\$ 65,00',
                                                          style: SafeGoogleFont(
                                                            'Inter',
                                                            fontSize: 15 * ffem,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            height: 1.2125 *
                                                                ffem /
                                                                fem,
                                                            color: Color(
                                                                0xff8798ad),
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
                                      Container(
                                        // autogroupkfsyGTc (GDmmRxcdArfnQWjyDdKfsY)
                                        width: double.infinity,
                                        height: 194 * fem,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // productedgedcardpV8 (1:283)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  4 * fem,
                                                  0 * fem),
                                              width: 178 * fem,
                                              height: double.infinity,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    // autogroupbbfq8ki (GDmmZTQ8iA3DofpLJbbbFQ)
                                                    width: double.infinity,
                                                    height: 138 * fem,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xff2f303b),
                                                      image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: AssetImage(
                                                          'assets/page-1/images/rectangle-35-bg.png',
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    // autogroupck8jsCW (GDmmdsSSkUeQFYv8ESCk8J)
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            8 * fem,
                                                            8 * fem,
                                                            8 * fem,
                                                            7 * fem),
                                                    width: double.infinity,
                                                    height: 56 * fem,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xffffffff),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          // producttitleBiz (I1:283;239:615)
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  3 * fem),
                                                          child: Text(
                                                            'Product title....',
                                                            style:
                                                                SafeGoogleFont(
                                                              'Inter',
                                                              fontSize:
                                                                  15 * ffem,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              height: 1.2125 *
                                                                  ffem /
                                                                  fem,
                                                              color: Color(
                                                                  0xff2e384d),
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          // xaf6qx (I1:283;239:616)
                                                          '00.000 XAF',
                                                          style: SafeGoogleFont(
                                                            'Inter',
                                                            fontSize: 15 * ffem,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            height: 1.2125 *
                                                                ffem /
                                                                fem,
                                                            color: Color(
                                                                0xff8798ad),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              // productedgedcard3WJ (1:284)
                                              width: 178 * fem,
                                              height: double.infinity,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    // autogroupabucBsQ (GDmmsCPa9u5dBcAKwVabuc)
                                                    width: double.infinity,
                                                    height: 138 * fem,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xff2f303b),
                                                      image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: AssetImage(
                                                          'assets/page-1/images/rectangle-35-bg-Jkr.png',
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    // autogroupdmdtvKC (GDmmwXbgum5835KHwndMdt)
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            8 * fem,
                                                            8 * fem,
                                                            8 * fem,
                                                            7 * fem),
                                                    width: double.infinity,
                                                    height: 56 * fem,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xffffffff),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          // producttitleEan (I1:284;239:615)
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  3 * fem),
                                                          child: Text(
                                                            'Product title....',
                                                            style:
                                                                SafeGoogleFont(
                                                              'Inter',
                                                              fontSize:
                                                                  15 * ffem,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              height: 1.2125 *
                                                                  ffem /
                                                                  fem,
                                                              color: Color(
                                                                  0xff2e384d),
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          // xafkZ8 (I1:284;239:616)
                                                          '00.000 XAF',
                                                          style: SafeGoogleFont(
                                                            'Inter',
                                                            fontSize: 15 * ffem,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            height: 1.2125 *
                                                                ffem /
                                                                fem,
                                                            color: Color(
                                                                0xff8798ad),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
