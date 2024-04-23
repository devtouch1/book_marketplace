import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:file_picker/file_picker.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:ui';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/utils.dart';
import 'package:myapp/page-1/home.dart';
import 'package:myapp/page-1/usuario.dart';

class EditProfile extends StatefulWidget {
  final Usuario? usuario;
  EditProfile({required this.usuario});
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _celularController = TextEditingController();
  TextEditingController _estadoController = TextEditingController();
  TextEditingController _cidadeController = TextEditingController();
  TextEditingController _descricaoController = TextEditingController();
  TextEditingController _senhaAntigaController = TextEditingController();
  TextEditingController _senhaNovaController = TextEditingController();
  TextEditingController _confirmarSenhaController = TextEditingController();

  String _nome = '';
  String _email = '';
  String _celular = '';
  String _estado = '';
  String _cidade = '';
  String _descricao = '';
  String _senhaAntiga = '';
  String _senhaNova = '';
  String _confirmarSenha = '';
  File? _imagemSelecionada;
  Uint8List? _imagemBytes;
  String _imagem = '';

  @override
  void initState() {
    super.initState();
    _nomeController.text = widget.usuario?.nome ?? '';
    _emailController.text = widget.usuario?.email ?? '';
    _celularController.text = widget.usuario?.celular ?? '';
    _estadoController.text = widget.usuario?.estado ?? '';
    _cidadeController.text = widget.usuario?.cidade ?? '';
    _descricaoController.text = widget.usuario?.descricao ?? '';
    _senhaAntigaController.text = _senhaAntiga;
    _senhaNovaController.text = _senhaNova;
    _confirmarSenhaController.text = _senhaAntiga;
  }

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
            _imagem = base64Encode(imageBytes);
          });
        } else {
          print('Erro: Não foi possível ler os bytes da imagem.');
        }
      }
    } catch (e) {
      print('Erro ao selecionar a imagem: $e');
    }
  }

  Future<void> _atualizarUsuario() async {
    String url = 'http://localhost:3001/api/usuarios/atualizar';
    String celularAntigo = widget.usuario?.celular ?? '';
    String nome = _nomeController.text;
    String email = _emailController.text;
    String celular = _celularController.text;
    String estado = _estadoController.text;
    String cidade = _cidadeController.text;
    String descricao = _descricaoController.text;
    String fotoPerfil = _imagemBytes != null
        ? base64Encode(_imagemBytes!)
        : widget.usuario?.fotoPerfil ?? '';

    try {
      // Converte os dados para uma string JSON
      String jsonBody = json.encode({
        'celularAntigo': celularAntigo,
        'celular': celular,
        'nome': nome,
        'email': email,
        'estado': estado,
        'cidade': cidade,
        'descricao': descricao,
        'fotoPerfil': fotoPerfil, // Inclua o campo fotoPerfil no JSON
      });

      // Faz a requisição POST para a API com o corpo JSON
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type':
              'application/json', // Especifica o tipo de conteúdo como JSON
        },
        body: jsonBody,
      );

      // Verifica se a requisição foi bem-sucedida
      if (response.statusCode == 200) {
        // Usuário atualizado com sucesso
        print('Usuário atualizado com sucesso!');
        Usuario usuarioAtualizado = Usuario(
          nome: nome,
          email: email,
          senha: widget.usuario?.senha ?? "",
          celular: celular,
          estado: estado,
          cidade: cidade,
          descricao: descricao,
          fotoPerfil:
              fotoPerfil, // Mantenha a foto de perfil antiga ou atualize conforme necessário
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyHome(
              usuario: usuarioAtualizado,
            ),
          ),
        );
      } else {
        // Falha ao atualizar o usuário
        print(
            'Falha ao atualizar o usuário. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Erro ao fazer a requisição
      print('Erro ao atualizar o usuário: $error');
    }
  }

  Future<void> _atualizarSenha() async {
    String senhaAntiga = _senhaAntigaController.text;
    String novaSenha = _senhaNovaController.text;
    String confirmarSenha = _confirmarSenhaController.text;

    if (senhaAntiga == widget.usuario?.senha && novaSenha == confirmarSenha) {
      String url = 'http://localhost:3001/api/usuarios/atualizarsenha';
      String celularAntigo = widget.usuario?.celular ?? '';
      String nome = widget.usuario?.nome ?? '';
      String email = widget.usuario?.email ?? '';
      String celular = widget.usuario?.celular ?? '';
      String estado = widget.usuario?.estado ?? '';
      String cidade = widget.usuario?.cidade ?? '';
      String descricao = widget.usuario?.descricao ?? '';
      String senha = _senhaNovaController.text;
      // Você precisa incluir os outros campos conforme necessário

      try {
        // Converte os dados para uma string JSON
        String jsonBody = json.encode({
          'celularAntigo': celularAntigo,
          'celular': celular,
          'nome': nome,
          'email': email,
          'estado': estado,
          'cidade': cidade,
          'descricao': descricao,
          'senha': senha
        });

        // Faz a requisição POST para a API com o corpo JSON
        var response = await http.post(
          Uri.parse(url),
          headers: {
            'Content-Type':
                'application/json', // Especifica o tipo de conteúdo como JSON
          },
          body: jsonBody,
        );

        // Verifica se a requisição foi bem-sucedida
        if (response.statusCode == 200) {
          // Usuário atualizado com sucesso
          print('Usuário atualizado com sucesso!');
          Usuario usuarioAtualizado = Usuario(
            nome: nome,
            email: email,
            senha: senha,
            celular: celular,
            estado: estado,
            cidade: cidade,
            descricao: descricao,
            fotoPerfil: widget.usuario?.fotoPerfil ??
                "", // Mantenha a foto de perfil antiga ou atualize conforme necessário
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyHome(
                usuario: usuarioAtualizado,
              ),
            ),
          );
        } else {
          // Falha ao atualizar o usuário
          print(
              'Falha ao atualizar a senha. Status code: ${response.statusCode}');
        }
      } catch (error) {
        // Erro ao fazer a requisição
        print('Erro ao atualizar o senha: $error');
      }
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
            // editprofile1xv (11:445)
            width: double.infinity,
            height: 1090 * fem,
            decoration: BoxDecoration(
              color: Color(0xfff4f6fc),
            ),
            child: Stack(
              children: [
                Positioned(
                  // rectangle689ZL (11:446)
                  left: 0 * fem,
                  top: 0 * fem,
                  child: Align(
                    child: SizedBox(
                      width: 360 * fem,
                      height: 144 * fem,
                      child: Opacity(
                        opacity: 0.5,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0x7fffffff),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  // editarperfilTK8 (11:447)
                  left: 42 * fem,
                  top: 44 * fem,
                  child: Align(
                    child: SizedBox(
                      width: 136 * fem,
                      height: 36 * fem,
                      child: Text(
                        'Editar perfil',
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
                  ),
                ),
                Positioned(
                  // chevronleftLNv (11:448)
                  left: 19 * fem,
                  top: 56 * fem,
                  child: Align(
                    child: SizedBox(
                      width: 6 * fem,
                      height: 12 * fem,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyHome(
                                    usuario: widget
                                        .usuario)), // Chama diretamente o widget Product
                          );
                        },
                        child: Image.asset(
                          'assets/page-1/images/chevron-left.png',
                          width: 6 * fem,
                          height: 12 * fem,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  // frame232FEz (11:451)
                  left: 16 * fem,
                  top: 88 * fem,
                  child: Container(
                    width: 351 * fem,
                    height: 938 * fem,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // autogrouphrrqa2N (GDmwWkeYYg7d98Z9prHrRQ)
                          padding: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 70 * fem),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: _selecionarImagem,
                                child: Container(
                                  // group250WRp (11:452)
                                  margin: EdgeInsets.fromLTRB(
                                      108 * fem, 0 * fem, 131 * fem, 24 * fem),
                                  width: double.infinity,
                                  height: 112 * fem,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(56 * fem),
                                    image: _imagemBytes != null
                                        ? DecorationImage(
                                            fit: BoxFit.cover,
                                            image: MemoryImage(_imagemBytes!),
                                          )
                                        : widget.usuario?.fotoPerfil != null
                                            ? DecorationImage(
                                                fit: BoxFit.cover,
                                                image: MemoryImage(
                                                    base64.decode(widget
                                                        .usuario!.fotoPerfil)),
                                              )
                                            : null,
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        // intersect1Na (11:454)
                                        left: 4 * fem,
                                        top: 77 * fem,
                                        child: Align(
                                          child: SizedBox(
                                            width: 103.86 * fem,
                                            height: 35 * fem,
                                            child: Image.asset(
                                              'assets/page-1/images/intersect.png',
                                              width: 103.86 * fem,
                                              height: 35 * fem,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        // editprofilepicturei26 (11:457)
                                        left: 34 * fem,
                                        top: 86 * fem,
                                        child: Align(
                                          child: SizedBox(
                                            width: 44 * fem,
                                            height: 18 * fem,
                                            child: Text(
                                              'Edit profile\npicture',
                                              textAlign: TextAlign.center,
                                              style: SafeGoogleFont(
                                                'Poppins',
                                                fontSize: 8 * ffem,
                                                fontWeight: FontWeight.w700,
                                                height: 1.125 * ffem / fem,
                                                letterSpacing: 0.02 * fem,
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
                              Container(
                                // frame261NsL (11:458)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 22 * fem, 0 * fem),
                                width: 329 * fem,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      // regionheader6YS (11:459)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 0 * fem, 18 * fem),
                                      width: 328 * fem,
                                      height: 22 * fem,
                                      child: Text(
                                        'Detalhes da Conta',
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
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 0 * fem, 12 * fem),
                                      padding: EdgeInsets.fromLTRB(
                                          12 * fem, 5 * fem, 12 * fem, 4 * fem),
                                      width: 328 * fem,
                                      height: 42 * fem,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0x4c359b3f)),
                                        color: Color(0x19359b3f),
                                        borderRadius:
                                            BorderRadius.circular(4 * fem),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 2.0 *
                                                    fem), // Adicione um espaço abaixo do rótulo
                                            child: Text(
                                              'NOME COMPLETO',
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
                                              maxLength: 200,
                                              controller: _nomeController,
                                              onChanged: (text) {
                                                setState(() {
                                                  _nome = text;
                                                });
                                              },
                                              obscureText: false,
                                              style: TextStyle(
                                                  fontSize: 6.5 * fem),
                                              decoration: InputDecoration(
                                                hintText: 'Digite seu nome...',
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
                                    Container(
                                      // textinput2yp (11:464)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 0 * fem, 12 * fem),
                                      padding: EdgeInsets.fromLTRB(
                                          12 * fem, 5 * fem, 12 * fem, 4 * fem),
                                      width: 328 * fem,
                                      height: 42 * fem,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0x4c359b3f)),
                                        color: Color(0x19359b3f),
                                        borderRadius:
                                            BorderRadius.circular(4 * fem),
                                      ),
                                      child: Container(
                                        // frame1jdL (I11:464;221:218)
                                        width: 144 * fem,
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
                                                'E-MAIL',
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
                                                maxLength: 200,
                                                controller: _emailController,
                                                onChanged: (text) {
                                                  setState(() {
                                                    _email = text;
                                                  });
                                                },
                                                obscureText: false,
                                                style: TextStyle(
                                                    fontSize: 6.5 * fem),
                                                decoration: InputDecoration(
                                                  hintText: '...',
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
                                    ),
                                    Container(
                                      // textinput8vN (11:465)
                                      margin: EdgeInsets.fromLTRB(
                                          1 * fem, 0 * fem, 0 * fem, 12 * fem),
                                      padding: EdgeInsets.fromLTRB(
                                          12 * fem, 5 * fem, 12 * fem, 4 * fem),
                                      width: 328 * fem,
                                      height: 42 * fem,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0x4c359b3f)),
                                        color: Color(0x19359b3f),
                                        borderRadius:
                                            BorderRadius.circular(4 * fem),
                                      ),
                                      child: Container(
                                        // frame131k (I11:465;221:218)
                                        width: 147 * fem,
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
                                                'CELULAR',
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
                                                maxLength: 16,
                                                controller: _celularController,
                                                onChanged: (text) {
                                                  setState(() {
                                                    _celular = text;
                                                  });
                                                },
                                                obscureText: false,
                                                style: TextStyle(
                                                    fontSize: 6.5 * fem),
                                                decoration: InputDecoration(
                                                  hintText: '...',
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
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 0 * fem, 12 * fem),
                                      padding: EdgeInsets.fromLTRB(
                                          12 * fem, 5 * fem, 12 * fem, 4 * fem),
                                      width: 328 * fem,
                                      height: 42 * fem,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0x4c359b3f)),
                                        color: Color(0x19359b3f),
                                        borderRadius:
                                            BorderRadius.circular(4 * fem),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 2.0 *
                                                    fem), // Adicione um espaço abaixo do rótulo
                                            child: Text(
                                              'ESTADO',
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
                                              maxLength: 2,
                                              controller: _estadoController,
                                              onChanged: (text) {
                                                setState(() {
                                                  _estado = text;
                                                });
                                              },
                                              obscureText: false,
                                              style: TextStyle(
                                                  fontSize: 6.5 * fem),
                                              decoration: InputDecoration(
                                                hintText: '...',
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
                                    Container(
                                      // textinput858 (11:474)
                                      margin: EdgeInsets.fromLTRB(
                                          1 * fem, 0 * fem, 1 * fem, 12 * fem),
                                      padding: EdgeInsets.fromLTRB(
                                          12 * fem, 5 * fem, 12 * fem, 4 * fem),
                                      width: double.infinity,
                                      height: 42 * fem,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0x4c359b3f)),
                                        color: Color(0x19359b3f),
                                        borderRadius:
                                            BorderRadius.circular(4 * fem),
                                      ),
                                      child: Container(
                                        // frame1pyY (I11:474;221:218)
                                        width: 38 * fem,
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
                                                'CIDADE',
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
                                                maxLength: 100,
                                                controller: _cidadeController,
                                                onChanged: (text) {
                                                  setState(() {
                                                    _cidade = text;
                                                  });
                                                },
                                                obscureText: false,
                                                style: TextStyle(
                                                    fontSize: 6.5 * fem),
                                                decoration: InputDecoration(
                                                  hintText: '...',
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
                                    ),
                                    Container(
                                      // textinputrQS (11:466)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 0 * fem, 22 * fem),
                                      padding: EdgeInsets.fromLTRB(
                                          12 * fem, 5 * fem, 12 * fem, 8 * fem),
                                      width: 328 * fem,
                                      height: 100 * fem,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0x4c359b3f)),
                                        color: Color(0x19359b3f),
                                        borderRadius:
                                            BorderRadius.circular(4 * fem),
                                      ),
                                      child: Container(
                                        // frame1wwg (I11:466;221:218)
                                        width: 250 * fem,
                                        height: double.infinity,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              // labelgnn (I11:466;221:219)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem),
                                              child: Text(
                                                'DESCRIÇÃO',
                                                style: SafeGoogleFont(
                                                  'Inter',
                                                  fontSize: 10 * fem,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.2125 * ffem / fem,
                                                  color: Color(0xffa6b3ac),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              // textoMc (I11:466;221:220)
                                              constraints: BoxConstraints(
                                                maxWidth: 250 * fem,
                                              ),
                                              child: Expanded(
                                                child: TextField(
                                                  controller:
                                                      _descricaoController,
                                                  onChanged: (text) {
                                                    setState(() {
                                                      _descricao =
                                                          text; // Atualiza o valor do _nomeUsuario à medida que o usuário digita
                                                    });
                                                  },
                                                  maxLines: 4,
                                                  obscureText: false,
                                                  style: TextStyle(
                                                      fontSize: 6.5 * fem),
                                                  decoration: InputDecoration(
                                                    labelText: null,
                                                    labelStyle: TextStyle(
                                                      fontSize: 10 * fem,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 0.1 * fem,
                                                      color: Color(0xffa6b3ac),
                                                    ),
                                                    hintText: 'Descrição...',
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
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: _atualizarUsuario,
                                      child: Container(
                                        // simplebtnvBL (11:476)
                                        width: 328 * fem,
                                        height: 40 * fem,
                                        decoration: BoxDecoration(
                                          color: Color(0xff35889b),
                                          borderRadius:
                                              BorderRadius.circular(4 * fem),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Atualizar dados',
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
                            ],
                          ),
                        ),
                        Container(
                          // frame252BNA (11:477)
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                // regionheaderjPg (11:478)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 0 * fem, 18 * fem),
                                width: 328 * fem,
                                height: 22 * fem,
                                child: Text(
                                  'Alterar Senha',
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
                                // frame251ouL (11:479)
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      // textinputMvr (11:480)
                                      padding: EdgeInsets.fromLTRB(
                                          12 * fem, 8 * fem, 12 * fem, 3 * fem),
                                      width: double.infinity,
                                      height: 44 * fem,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0x4c359b3f)),
                                        color: Color(0x19359b3f),
                                        borderRadius:
                                            BorderRadius.circular(4 * fem),
                                      ),
                                      child: Container(
                                        // frame1GY2 (I11:480;226:306)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 226 * fem, 0 * fem),
                                        width: 101 * fem,
                                        height: double.infinity,
                                        child: Align(
                                          // labelQPL (I11:480;226:307)
                                          alignment: Alignment.topLeft,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: 2.0 *
                                                        fem), // Adicione um espaço abaixo do rótulo
                                                child: Text(
                                                  'SENHA ANTIGA',
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
                                                  maxLength: 8,
                                                  controller:
                                                      _senhaAntigaController,
                                                  onChanged: (text) {
                                                    setState(() {
                                                      _senhaAntiga = text;
                                                    });
                                                  },
                                                  obscureText: true,
                                                  style: TextStyle(
                                                      fontSize: 6.5 * fem),
                                                  decoration: InputDecoration(
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
                                      // textinputfCn (11:481)
                                      padding: EdgeInsets.fromLTRB(
                                          12 * fem, 8 * fem, 12 * fem, 3 * fem),
                                      width: double.infinity,
                                      height: 44 * fem,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0x4c359b3f)),
                                        color: Color(0x19359b3f),
                                        borderRadius:
                                            BorderRadius.circular(4 * fem),
                                      ),
                                      child: Container(
                                        // frame1n2W (I11:481;226:306)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 226 * fem, 0 * fem),
                                        width: 101 * fem,
                                        height: double.infinity,
                                        child: Align(
                                          // label7qU (I11:481;226:307)
                                          alignment: Alignment.topLeft,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: 2.0 *
                                                        fem), // Adicione um espaço abaixo do rótulo
                                                child: Text(
                                                  'NOVA SENHA',
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
                                                  maxLength: 8,
                                                  controller:
                                                      _senhaNovaController,
                                                  onChanged: (text) {
                                                    setState(() {
                                                      _senhaNova = text;
                                                    });
                                                  },
                                                  obscureText: true,
                                                  style: TextStyle(
                                                      fontSize: 6.5 * fem),
                                                  decoration: InputDecoration(
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
                                      // textinputFKQ (11:482)
                                      padding: EdgeInsets.fromLTRB(
                                          12 * fem, 8 * fem, 2 * fem, 3 * fem),
                                      width: double.infinity,
                                      height: 44 * fem,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0x4c359b3f)),
                                        color: Color(0x19359b3f),
                                        borderRadius:
                                            BorderRadius.circular(4 * fem),
                                      ),
                                      child: Container(
                                        // frame1N98 (I11:482;226:306)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 226 * fem, 0 * fem),
                                        width: 101 * fem,
                                        height: double.infinity,
                                        child: Align(
                                          // labelVjY (I11:482;226:307)
                                          alignment: Alignment.topLeft,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: 2.0 *
                                                        fem), // Adicione um espaço abaixo do rótulo
                                                child: Text(
                                                  'CONFIRMAR SENHA',
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
                                                  maxLength: 8,
                                                  controller:
                                                      _confirmarSenhaController,
                                                  onChanged: (text) {
                                                    setState(() {
                                                      _confirmarSenha = text;
                                                    });
                                                  },
                                                  obscureText: true,
                                                  style: TextStyle(
                                                      fontSize: 6.5 * fem),
                                                  decoration: InputDecoration(
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
                                    GestureDetector(
                                      onTap: _atualizarSenha,
                                      child: Container(
                                        // simplebtnT46 (11:483)
                                        width: 328 * fem,
                                        height: 40 * fem,
                                        decoration: BoxDecoration(
                                          color: Color(0xff35889b),
                                          borderRadius:
                                              BorderRadius.circular(4 * fem),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Alterar senha',
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
    ));
  }
}
