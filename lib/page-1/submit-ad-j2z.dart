import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/page-1/cadastrar.dart';
import 'package:myapp/page-1/home.dart';
import 'package:myapp/page-1/livro.dart';
import 'package:myapp/page-1/usuario.dart';
import 'package:myapp/utils.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _controller = TextEditingController();
  String _nomeUsuario = 'johndoe'; // Valor inicial do texto
  TextEditingController _senhaController = TextEditingController();
  String _senha = 'johndoe'; // Valor inicial do texto

  Future<void> _realizarLogin() async {
    //String url = 'http://localhost:3001/api/usuarios/login';
    String emailOuCelular = _controller.text;
    String senha = _senhaController.text;

    try {
      final Map<String, String> dados = {
        'emailOuCelular': emailOuCelular,
        'senha': senha,
      };

      final response = await http.post(
        Uri.parse('http://localhost:3001/api/usuarios/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(dados),
      );

      if (response.statusCode == 200) {
        // Parse do JSON para criar um objeto Usuario
        Usuario usuario = Usuario.fromJson(json.decode(response.body));

        // Login bem-sucedido, você pode lidar com a resposta aqui
        // Por exemplo, redirecionar para a próxima tela passando o objeto Usuario
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyHome(usuario: usuario)),
        );
      } else {
        // Login falhou, você pode exibir uma mensagem de erro
        print(emailOuCelular);
        print(senha);
        print('Erro durante o login. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Erro de conexão ou outra exceção
      print('Erro durante o login: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    _controller.text = _nomeUsuario;
    _senhaController.text = _senha;
  }

  @override
  Widget build(BuildContext context) {
    GestureRecognizer recognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  Login()), // Substitua PaginaLogin pelo nome da sua classe de login
        );
      };

    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    TextSpan criarContaTextSpan = TextSpan(
      text: 'Criar Conta',
      style: SafeGoogleFont(
        'Inter',
        fontSize: 15 * ffem,
        fontWeight: FontWeight.w400,
        height: 1.2125 * ffem / fem,
        color: Color(0xff35889b),
      ),
      recognizer: recognizer,
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Container(
            // submitadAYS (14:580)
            padding:
                EdgeInsets.fromLTRB(15 * fem, 80 * fem, 17 * fem, 432 * fem),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xfff4f6fc),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // bemvindoaothebookisonthetablee (14:670)
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 0 * fem, 40 * fem, 8 * fem),
                  constraints: BoxConstraints(
                    maxWidth: 288 * fem,
                  ),
                  child: Text(
                    'Bem Vindo ao The Book is on the Table',
                    style: SafeGoogleFont(
                      'Poppins',
                      fontSize: 24 * ffem,
                      fontWeight: FontWeight.w700,
                      height: 1.3333333333 * ffem / fem,
                      letterSpacing: 0.06 * fem,
                      color: Color(0xff2e384d),
                    ),
                  ),
                ),
                Container(
                  // porgentilezaefetueseuloginabai (14:671)
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 0 * fem, 27 * fem, 35 * fem),
                  constraints: BoxConstraints(
                    maxWidth: 301 * fem,
                  ),
                  child: Text(
                    'Por gentileza, efetue seu login abaixo para utilizar o aplicativo',
                    style: SafeGoogleFont(
                      'Inter',
                      fontSize: 15 * ffem,
                      fontWeight: FontWeight.w400,
                      height: 1.2125 * ffem / fem,
                      color: Color(0xff2e384d),
                    ),
                  ),
                ),
                Container(
                  // textinputNnv (14:673)
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 0 * fem, 10 * fem, 13 * fem),
                  padding:
                      EdgeInsets.fromLTRB(12 * fem, 6 * fem, 12 * fem, 5 * fem),
                  width: 316 * fem,
                  height: 44 * fem,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0x4c359b3f)),
                    color: Color(0x19359b3f),
                    borderRadius: BorderRadius.circular(4 * fem),
                  ),
                  child: Container(
                    // frame1rxz (I14:673;221:218)
                    width: 78 * fem,
                    height: double.infinity,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            onChanged: (text) {
                              setState(() {
                                _nomeUsuario =
                                    text; // Atualiza o valor do _nomeUsuario à medida que o usuário digita
                              });
                            },
                            style: TextStyle(fontSize: 6.5 * fem),
                            decoration: InputDecoration(
                              labelText: 'USUÁRIO/EMAIL',
                              labelStyle: TextStyle(
                                fontSize: 10 * fem,
                                fontWeight: FontWeight.w400,
                                height: 0.1 * fem,
                                color: Color(0xffa6b3ac),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  // textinputFkE (14:716)
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 0 * fem, 10 * fem, 27 * fem),
                  padding:
                      EdgeInsets.fromLTRB(12 * fem, 6 * fem, 12 * fem, 5 * fem),
                  width: 316 * fem,
                  height: 44 * fem,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0x4c359b3f)),
                    color: Color(0x19359b3f),
                    borderRadius: BorderRadius.circular(4 * fem),
                  ),
                  child: Container(
                    // frame1kBC (I14:716;221:218)
                    width: 75 * fem,
                    height: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _senhaController,
                            onChanged: (text) {
                              setState(() {
                                _senha =
                                    text; // Atualiza o valor do _nomeUsuario à medida que o usuário digita
                              });
                            },
                            obscureText: true,
                            style: TextStyle(fontSize: 6.5 * fem),
                            decoration: InputDecoration(
                              labelText: 'SENHA',
                              labelStyle: TextStyle(
                                fontSize: 10 * fem,
                                fontWeight: FontWeight.w400,
                                height: 0.1 * fem,
                                color: Color(0xffa6b3ac),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  // vectorZ8e (14:710)
                  margin: EdgeInsets.fromLTRB(
                      0 * fem, 0 * fem, 191.7 * fem, 17.87 * fem),
                  width: 134.3 * fem,
                  height: 14.13 * fem,
                  child: Image.asset(
                    'assets/page-1/images/vector.png',
                    width: 134.3 * fem,
                    height: 14.13 * fem,
                  ),
                ),
                Container(
                  // simplebtnTUv (14:680)
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 10 * fem),
                  child: TextButton(
                    onPressed: _realizarLogin,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 40 * fem,
                      decoration: BoxDecoration(
                        color: Color(0xff35889b),
                        borderRadius: BorderRadius.circular(4 * fem),
                      ),
                      child: Center(
                        child: Text(
                          'Entrar',
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
                ),
                Container(
                  // nopossuicontacriarcontahPG (14:681)
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 0 * fem, 10 * fem, 14 * fem),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: SafeGoogleFont(
                        'Inter',
                        fontSize: 15 * ffem,
                        fontWeight: FontWeight.w400,
                        height: 1.2125 * ffem / fem,
                        color: Color(0xff2e384d),
                      ),
                      children: [
                        TextSpan(
                          text: 'Não possui conta',
                        ),
                        TextSpan(
                          text: '? ',
                          style: SafeGoogleFont(
                            'Inter',
                            fontSize: 15 * ffem,
                            fontWeight: FontWeight.w400,
                            height: 1.2125 * ffem / fem,
                            color: Color(0xff2e384d),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            //EditProfile(
                            //usuario: widget
                            //.usuario)),
                            Cadastrar(),
                      ), // Chama diretamente o widget Product
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 11 * fem, 2 * fem),
                    child: Text(
                      'Cadastre-se',
                      textAlign: TextAlign.center,
                      style: SafeGoogleFont(
                        'Inter',
                        fontSize: 15 * ffem,
                        fontWeight: FontWeight.w400,
                        height: 1.2125 * ffem / fem,
                        color: Color(0xff8798ad),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            //EditProfile(
                            //usuario: widget
                            //.usuario)),
                            Cadastrar(),
                      ), // Chama diretamente o widget Product
                    );
                  },
                  child: Container(
                    // simplebtnZbp (14:684)
                    width: double.infinity,
                    height: 40 * fem,
                    decoration: BoxDecoration(
                      color: Color(0xffbdd1d2),
                      borderRadius: BorderRadius.circular(4 * fem),
                    ),
                    child: Center(
                      child: Text(
                        'Efetuar Cadastro',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
