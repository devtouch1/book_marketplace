import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/page-1/cadastrar.dart';
import 'package:myapp/utils.dart';
import 'package:myapp/page-1/criar_anuncio.dart';
import 'package:myapp/page-1/product-detail.dart';
import 'package:myapp/page-1/edit-profile.dart';
import 'package:myapp/page-1/recentes.dart';
import 'package:myapp/page-1/livro.dart';
import 'package:myapp/page-1/usuario.dart';

class MyHome extends StatefulWidget {
  final Usuario? usuario;

  MyHome({this.usuario});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<MyHome> {
  List<Livro> livros = [];
  String _modoPesquisa = 'Título';
  TextEditingController _controller = TextEditingController();
  String _pesquisar = ''; // Valor inicial do texto

  @override
  void initState() {
    super.initState();
    _controller.text = _pesquisar;
    _fetchLivros();
  }

  Future<void> _fetchLivros({String? nome, String? estado}) async {
    final response =
        await http.get(Uri.parse('http://localhost:3001/api/livros'));

    if (response.statusCode == 200) {
      // Se a requisição for bem-sucedida, decodifique a resposta JSON
      var jsonResponse = json.decode(response.body);
      // Crie uma lista de livros a partir dos dados decodificados
      List<Livro> listaLivros = (jsonResponse as List).map((livro) {
        // Passa o objeto Usuario para o construtor de Livro
        return Livro.fromJson(livro);
      }).toList();
      listaLivros.forEach((livro) {
        livro.usuario = widget.usuario;
      });

      if (nome != null) {
        listaLivros = listaLivros
            .where((livro) =>
                livro.titulo.toLowerCase().contains(nome.toLowerCase()))
            .toList();
      }
      if (estado != null) {
        listaLivros = listaLivros
            .where((livro) =>
                livro.estado.toLowerCase().contains(estado.toLowerCase()))
            .toList();
      }
      // Atualize o estado com a lista de livros obtida da requisição
      setState(() {
        livros = listaLivros;
        for (Livro livro in livros) {
          print('Título: ${livro.titulo}');
          print('Preço: ${livro.preco}');
          print('Categoria: ${livro.categoria}');
          print('Cidade: ${livro.cidade}');
          print('Estado: ${livro.estado}');
          print('Foto: ${livro.foto}');
          // Adicione mais parâmetros conforme necessário
          print('-----'); // Separador entre livros para facilitar a leitura
        }
      });
    } else {
      // Se a requisição falhar, imprima o código de status
      print('Erro na requisição GET. Código de status: ${response.statusCode}');
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
              // homeKWr (1:287)
              width: double.infinity,
              height: livros.length * 300 + 1965 * fem,
              decoration: BoxDecoration(
                color: Color(0xfff4f6fc),
              ),
              child: Stack(
                children: [
                  Positioned(
                    // group1691uU (1:289)
                    left: 4 * fem,
                    top: 42 * fem,
                    child: Container(
                      width: 664 * fem,
                      height: livros.length * 200 + 1400 * fem, //831
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // autogroupynl27hc (GDmntqLsLTaQ1Cyvw5YNL2)
                            padding: EdgeInsets.fromLTRB(
                                11 * fem, 0 * fem, 11 * fem, 18 * fem),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // group16735U (1:291)
                                  margin: EdgeInsets.fromLTRB(
                                      5 * fem, 0 * fem, 0 * fem, 0 * fem),
                                  width: 328 * fem,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // group1559uC (1:295)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 0 * fem, 24 * fem),
                                        padding: EdgeInsets.fromLTRB(
                                            0 * fem, 0 * fem, 3 * fem, 0 * fem),
                                        width: double.infinity,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // logod5Giv (I1:296;1:9)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  188 * fem,
                                                  0 * fem),
                                              width: 119 * fem,
                                              height: 35 * fem,
                                              child: Image.asset(
                                                'assets/page-1/images/logo-d5.png',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Container(
                                              // alignjustifyP2r (1:297)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem,
                                                  0 * fem),
                                              width: 18 * fem,
                                              height: 16 * fem,
                                              child: Image.asset(
                                                'assets/page-1/images/align-justify.png',
                                                width: 18 * fem,
                                                height: 16 * fem,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        // descubraoseuprximograndelivroc (1:293)
                                        constraints: BoxConstraints(
                                          maxWidth: 296 * fem,
                                        ),
                                        child: Text(
                                          'Descubra o seu próximo grande livro conosco! O que você procura hoje?',
                                          style: SafeGoogleFont(
                                            'Poppins',
                                            fontSize: 16 * ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 2 * ffem / fem,
                                            letterSpacing: 0.04 * fem,
                                            color: Color(0xff2e384d),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 16 * fem,
                                ),
                                Container(
                                  // frame152WWn (1:301)
                                  margin: EdgeInsets.fromLTRB(
                                      5 * fem, 0 * fem, 309 * fem, 0 * fem),
                                  width: double.infinity,
                                  height: 48 * fem,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // inputwithiconqJA (1:302)
                                        margin: EdgeInsets.fromLTRB(
                                            0 * fem, 0 * fem, 8 * fem, 0 * fem),
                                        padding: EdgeInsets.fromLTRB(8 * fem,
                                            12 * fem, 8 * fem, 12 * fem),
                                        width: 272 * fem,
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Color(0x4c359b3f)),
                                          color: Color(0x19359b3f),
                                          borderRadius:
                                              BorderRadius.circular(4 * fem),
                                        ),
                                        child: Container(
                                          // frame150KDL (I1:302;324:1181)
                                          padding: EdgeInsets.fromLTRB(3 * fem,
                                              3 * fem, 0 * fem, 3 * fem),
                                          width: 177 * fem,
                                          height: double.infinity,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                // search12tS (I1:302;324:1178)
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    0 * fem,
                                                    11 * fem,
                                                    0 * fem),
                                                width: 18 * fem,
                                                height: 18 * fem,
                                                child: Image.asset(
                                                  'assets/page-1/images/search-1.png',
                                                  width: 18 * fem,
                                                  height: 18 * fem,
                                                ),
                                              ),
                                              Expanded(
                                                child: TextField(
                                                  controller: _controller,
                                                  onSubmitted: (String text) {
                                                    _fetchLivros(
                                                        nome: _modoPesquisa ==
                                                                'Título'
                                                            ? text
                                                            : null,
                                                        estado: _modoPesquisa ==
                                                                'Estado'
                                                            ? text
                                                            : null);
                                                  },
                                                  onChanged: (text) {
                                                    setState(() {
                                                      _pesquisar =
                                                          text; // Atualiza o valor do _nomeUsuario à medida que o usuário digita
                                                    });
                                                  },
                                                  obscureText: false,
                                                  style: TextStyle(
                                                      fontSize: 10 * fem),
                                                  decoration: InputDecoration(
                                                    labelText: null,
                                                    hintText: 'Pesquisar...',
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
                                      GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text(
                                                    'Escolha o modo de pesquisa'),
                                                content: DropdownButton<String>(
                                                  value: _modoPesquisa,
                                                  onChanged:
                                                      (String? newValue) {
                                                    setState(() {
                                                      _modoPesquisa = newValue!;
                                                    });
                                                    Navigator.of(context)
                                                        .pop(); // Fecha o AlertDialog após a escolha
                                                  },
                                                  items: <String>[
                                                    'Título',
                                                    'Estado'
                                                  ].map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                      (String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: Container(
                                          width: 48 * fem,
                                          height: 48 * fem,
                                          child: Image.asset(
                                            'assets/page-1/images/group-136.png',
                                            width: 48 * fem,
                                            height: 48 * fem,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 16 * fem,
                                ),
                                Container(
                                  // group166mUe (1:309)
                                  width: 364 * fem,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // regionheaderWh8 (1:310)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 0 * fem, 18 * fem),
                                        width: double.infinity,
                                        height: 22 * fem,
                                        child: Text(
                                          'Categorias',
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
                                        // group163zcJ (1:311)
                                        margin: EdgeInsets.fromLTRB(
                                            2 * fem, 0 * fem, 0 * fem, 0 * fem),
                                        height: 78 * fem,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // group158WqY (1:339)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  16 * fem,
                                                  0 * fem),
                                              width: 56 * fem,
                                              height: double.infinity,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    // group157dvA (1:341)
                                                    margin: EdgeInsets.fromLTRB(
                                                        3 * fem,
                                                        0 * fem,
                                                        1 * fem,
                                                        8 * fem),
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            16 * fem,
                                                            17 * fem,
                                                            16 * fem,
                                                            17 * fem),
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      color: Color(0x33eb5757),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              49 * fem),
                                                    ),
                                                    child: Center(
                                                      // briefcase2Y1Y (1:343)
                                                      child: SizedBox(
                                                        width: 20 * fem,
                                                        height: 18 * fem,
                                                        child: Image.asset(
                                                          'assets/page-1/images/briefcase-2.png',
                                                          width: 20 * fem,
                                                          height: 18 * fem,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    // biografiaFge (1:340)
                                                    'Biografia',
                                                    textAlign: TextAlign.center,
                                                    style: SafeGoogleFont(
                                                      'Poppins',
                                                      fontSize: 12 * ffem,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      height: 1.5 * ffem / fem,
                                                      letterSpacing: 0.03 * fem,
                                                      color: Color(0xff2e384d),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              // group159aiv (1:332)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  17 * fem,
                                                  0 * fem),
                                              width: 52 * fem,
                                              height: double.infinity,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    // group156Wca (1:334)
                                                    margin: EdgeInsets.fromLTRB(
                                                        0 * fem,
                                                        0 * fem,
                                                        0 * fem,
                                                        8 * fem),
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            16 * fem,
                                                            16 * fem,
                                                            16 * fem,
                                                            16 * fem),
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      color: Color(0x33f2c94c),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              49 * fem),
                                                    ),
                                                    child: Center(
                                                      // tv1258 (1:336)
                                                      child: SizedBox(
                                                        width: 20 * fem,
                                                        height: 20 * fem,
                                                        child: Image.asset(
                                                          'assets/page-1/images/tv-1.png',
                                                          width: 20 * fem,
                                                          height: 20 * fem,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    // mistriok18 (1:333)
                                                    margin: EdgeInsets.fromLTRB(
                                                        1 * fem,
                                                        0 * fem,
                                                        0 * fem,
                                                        0 * fem),
                                                    child: Text(
                                                      'Mistério',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: SafeGoogleFont(
                                                        'Poppins',
                                                        fontSize: 12 * ffem,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        height:
                                                            1.5 * ffem / fem,
                                                        letterSpacing:
                                                            0.03 * fem,
                                                        color:
                                                            Color(0xff2e384d),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              // group162qoG (1:318)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  15 * fem,
                                                  0 * fem),
                                              width: 52 * fem,
                                              height: double.infinity,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    // group161mwp (1:320)
                                                    margin: EdgeInsets.fromLTRB(
                                                        0 * fem,
                                                        0 * fem,
                                                        0 * fem,
                                                        8 * fem),
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            14.63 * fem,
                                                            18.69 * fem,
                                                            14.63 * fem,
                                                            18.69 * fem),
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      color: Color(0x33f2994a),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              49 * fem),
                                                    ),
                                                    child: Center(
                                                      // carsportoutline1tFk (1:322)
                                                      child: SizedBox(
                                                        width: 22.75 * fem,
                                                        height: 14.63 * fem,
                                                        child: Image.asset(
                                                          'assets/page-1/images/car-sport-outline-1.png',
                                                          width: 22.75 * fem,
                                                          height: 14.63 * fem,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    // histriaBEr (1:319)
                                                    margin: EdgeInsets.fromLTRB(
                                                        0 * fem,
                                                        0 * fem,
                                                        2 * fem,
                                                        0 * fem),
                                                    child: Text(
                                                      'História',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: SafeGoogleFont(
                                                        'Poppins',
                                                        fontSize: 12 * ffem,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        height:
                                                            1.5 * ffem / fem,
                                                        letterSpacing:
                                                            0.03 * fem,
                                                        color:
                                                            Color(0xff2e384d),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              // group164fvi (1:315)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  12 * fem,
                                                  0 * fem),
                                              width: 59 * fem,
                                              height: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        49 * fem),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    // rectangle33zi6 (1:317)
                                                    margin: EdgeInsets.fromLTRB(
                                                        3 * fem,
                                                        0 * fem,
                                                        4 * fem,
                                                        8 * fem),
                                                    width: double.infinity,
                                                    height: 52 * fem,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              49 * fem),
                                                      color: Color(0x332f80ed),
                                                    ),
                                                  ),
                                                  Text(
                                                    // romanceitz (1:316)
                                                    'Romance',
                                                    textAlign: TextAlign.center,
                                                    style: SafeGoogleFont(
                                                      'Poppins',
                                                      fontSize: 12 * ffem,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      height: 1.5 * ffem / fem,
                                                      letterSpacing: 0.03 * fem,
                                                      color: Color(0xff2e384d),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              // group165fJS (1:312)
                                              width: 54 * fem,
                                              height: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        49 * fem),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    // rectangle34CpA (1:314)
                                                    margin: EdgeInsets.fromLTRB(
                                                        1 * fem,
                                                        0 * fem,
                                                        1 * fem,
                                                        8 * fem),
                                                    width: double.infinity,
                                                    height: 52 * fem,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              49 * fem),
                                                      color: Color(0x33219653),
                                                    ),
                                                  ),
                                                  Text(
                                                    // fantasiajZC (1:313)
                                                    'Fantasia',
                                                    textAlign: TextAlign.center,
                                                    style: SafeGoogleFont(
                                                      'Poppins',
                                                      fontSize: 12 * ffem,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      height: 1.5 * ffem / fem,
                                                      letterSpacing: 0.03 * fem,
                                                      color: Color(0xff2e384d),
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
                          Container(
                            // group15057G (1:307)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 12 * fem),
                            width: double.infinity,
                            child: Recentes(
                              fem: fem,
                              ffem: ffem,
                              usuario: widget.usuario,
                              library: ListaDeLivros(
                                  livros: livros, fem: fem, ffem: ffem),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    //navbar menu
                    // navigationbaruKg (1:357)
                    left: 0 * fem,
                    top: 742 * fem,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 8 * fem),
                      width: 360 * fem,
                      height: 58 * fem,
                      decoration: BoxDecoration(
                        color: Color(0xffffffff),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // vector4nPU (I1:357;286:1208)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 8 * fem),
                            width: 360 * fem,
                            height: 0 * fem,
                            child: Image.asset(
                              'assets/page-1/images/vector-4.png',
                              width: 360 * fem,
                              height: 0 * fem,
                            ),
                          ),
                          Container(
                            // autogroupxgfcK8W (GDmsHD31ytTC23sLJoXGFc)
                            margin: EdgeInsets.fromLTRB(
                                14 * fem, 0 * fem, 12 * fem, 0 * fem),
                            width: double.infinity,
                            height: 42 * fem,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // frame151Siv (I1:357;345:2254)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 3 * fem, 14 * fem, 3 * fem),
                                  height: double.infinity,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // group189Aup (I1:357;345:2255)
                                        padding: EdgeInsets.fromLTRB(
                                            0 * fem, 2 * fem, 0 * fem, 0 * fem),
                                        height: double.infinity,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // home2gtA (I1:357;345:2256)
                                              margin: EdgeInsets.fromLTRB(
                                                  0.78 * fem,
                                                  0 * fem,
                                                  0 * fem,
                                                  2 * fem),
                                              width: 21.78 * fem,
                                              height: 20 * fem,
                                              child: Image.asset(
                                                'assets/page-1/images/home-2.png',
                                                width: 21.78 * fem,
                                                height: 20 * fem,
                                              ),
                                            ),
                                            Center(
                                              // homebVL (I1:357;345:2258)
                                              child: Text(
                                                'Home',
                                                textAlign: TextAlign.center,
                                                style: SafeGoogleFont(
                                                  'Poppins',
                                                  fontSize: 8 * ffem,
                                                  fontWeight: FontWeight.w500,
                                                  height: 1.5 * ffem / fem,
                                                  letterSpacing: 0.02 * fem,
                                                  color: Color(0xff2e384d),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10 * fem,
                                      ),
                                      Container(
                                        // group188uW2 (I1:357;345:2259)
                                        padding: EdgeInsets.fromLTRB(
                                            0 * fem, 1 * fem, 0 * fem, 0 * fem),
                                        height: double.infinity,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // bell3dwp (I1:357;345:2260)
                                              margin: EdgeInsets.fromLTRB(
                                                  1 * fem,
                                                  0 * fem,
                                                  0 * fem,
                                                  0.99 * fem),
                                              width: 20 * fem,
                                              height: 22.01 * fem,
                                              child: Image.asset(
                                                'assets/page-1/images/bell-3.png',
                                                width: 20 * fem,
                                                height: 22.01 * fem,
                                              ),
                                            ),
                                            Center(
                                              // notificationsYot (I1:357;345:2262)
                                              child: Text(
                                                'Notificações',
                                                textAlign: TextAlign.center,
                                                style: SafeGoogleFont(
                                                  'Poppins',
                                                  fontSize: 8 * ffem,
                                                  fontWeight: FontWeight.w500,
                                                  height: 1.5 * ffem / fem,
                                                  letterSpacing: 0.02 * fem,
                                                  color: Color(0xffacaec1),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10 * fem,
                                      ),
                                      Container(
                                        // group187GUz (I1:357;345:2263)
                                        padding: EdgeInsets.fromLTRB(0 * fem,
                                            2.25 * fem, 0 * fem, 0 * fem),
                                        height: double.infinity,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // chatbubblesoutline1QLJ (I1:357;345:2264)
                                              margin: EdgeInsets.fromLTRB(
                                                  1 * fem,
                                                  0 * fem,
                                                  0 * fem,
                                                  2.25 * fem),
                                              width: 19.5 * fem,
                                              height: 19.5 * fem,
                                              child: Image.asset(
                                                'assets/page-1/images/chatbubbles-outline-1.png',
                                                width: 19.5 * fem,
                                                height: 19.5 * fem,
                                              ),
                                            ),
                                            Center(
                                              // messagesi66 (I1:357;345:2267)
                                              child: Text(
                                                'Mensagens',
                                                textAlign: TextAlign.center,
                                                style: SafeGoogleFont(
                                                  'Poppins',
                                                  fontSize: 8 * ffem,
                                                  fontWeight: FontWeight.w500,
                                                  height: 1.5 * ffem / fem,
                                                  letterSpacing: 0.02 * fem,
                                                  color: Color(0xffacaec1),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10 * fem,
                                      ),
                                      Container(
                                        // group186QDp (I1:357;345:2268)
                                        padding: EdgeInsets.fromLTRB(0 * fem,
                                            1.99 * fem, 0 * fem, 0 * fem),
                                        height: double.infinity,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditProfile(
                                                              usuario: widget
                                                                  .usuario)),
                                                  //Cadastrar()), // Chama diretamente o widget
                                                );
                                              },
                                              child: Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    0 * fem,
                                                    0.97 * fem,
                                                    1.99 * fem),
                                                width: 19.9 * fem,
                                                height: 20.01 * fem,
                                                child: Image.asset(
                                                  'assets/page-1/images/user-2.png',
                                                  width: 19.9 * fem,
                                                  height: 20.01 * fem,
                                                ),
                                              ),
                                            ),
                                            Center(
                                              // accountFVL (I1:357;345:2271)
                                              child: Text(
                                                'Conta',
                                                textAlign: TextAlign.center,
                                                style: SafeGoogleFont(
                                                  'Poppins',
                                                  fontSize: 8 * ffem,
                                                  fontWeight: FontWeight.w500,
                                                  height: 1.5 * ffem / fem,
                                                  letterSpacing: 0.02 * fem,
                                                  color: Color(0xffacaec1),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                TextButton(
                                  // group147nEN (I1:357;286:1209)
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(
                                        18 * fem, 9 * fem, 15 * fem, 9 * fem),
                                    width: 142 * fem,
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Color(0xff35889b),
                                      borderRadius:
                                          BorderRadius.circular(48 * fem),
                                    ),
                                    child: criarAnuncio(fem, ffem, context,
                                        usuario: widget.usuario),
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
