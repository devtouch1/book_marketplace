const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
require('dotenv').config();
const cors = require('cors');
const app = express();
const port = 3001;

app.use(bodyParser.json());
const corsOptions = {
  origin: '*', // Permite qualquer origem acessar a API
  methods: 'GET,HEAD,PUT,PATCH,POST,DELETE',
  credentials: true, // Habilita o envio de cookies
  optionsSuccessStatus: 204, // Alguns navegadores enviam um pre-flight OPTIONS request. Responder com 204 No Content se a rota OPTIONS for encontrada.
};

app.use(cors(corsOptions));

mongoose.connect(process.env.MONGODB, {
  useNewUrlParser: true,
  useUnifiedTopology: true
});

// Evento para lidar com erros de conexão ao banco de dados
mongoose.connection.on('error', err => {
  console.error('Erro de conexão ao banco de dados:', err);
});

// Evento para lidar com uma conexão bem-sucedida ao banco de dados
mongoose.connection.once('open', () => {
  console.log('Conectado ao banco de dados com sucesso!');
});

const comentSchema = new mongoose.Schema({
  nome: String,
  data: String,
  conteudo: String,
  foto: String
});

const usuarioSchema = new mongoose.Schema({
  nome: String,
  email: String,
  celular: String,
  estado: String,
  cidade: String,
  descricao: String,
  senha: String,
  fotoPerfil: String
});

const livroSchema = new mongoose.Schema({
  categoria: String,
  titulo: String,
  autor: String,
  preco: String,
  descricao: String,
  estado: String,
  cidade: String,
  foto: String
});

const Usuario = mongoose.model('Usuario', usuarioSchema);
const Coment = mongoose.model('Coment', comentSchema);
const Livro = mongoose.model('Livro', livroSchema);

app.get('/coments', async (req, res) => {
  try {
    // Consulta todos os comentários do banco de dados
    const coments = await Coment.find();
    res.status(200).json(coments); // Retorna os comentários como resposta
  } catch (error) {
    console.error('Erro ao obter comentários:', error);
    res.status(500).json({ message: 'Erro interno do servidor' });
  }
});

app.post('/coments', async (req, res) => {
  try {
    const { nome, data, conteudo, foto } = req.body;

    // Cria um novo objeto Coment com os dados recebidos
    const novoComent = new Coment({
      nome,
      data,
      conteudo,
      foto
    });

    // Salva o novo comentário no banco de dados
    await novoComent.save();

    res.status(201).json(novoComent); // Retorna o novo comentário como resposta com o código de status 201 (Created)
  } catch (error) {
    console.error('Erro ao criar comentário:', error);
    res.status(500).json({ message: 'Erro interno do servidor' });
  }
});

app.post('/api/usuarios/atualizarsenha', async (req, res) => {
  const { celularAntigo, celular, nome, email, estado, cidade, descricao, fotoPerfil, senha } = req.body;

  try {
    // Pesquisa e atualiza os livros com 'cidade' igual ao 'celularAntigo'
    await Livro.updateMany({ cidade: celularAntigo }, { $set: { cidade: celular } });

    // Pesquisa o usuário pelo número de celular antigo
    const usuario = await Usuario.findOne({ celular: celularAntigo });

    if (!usuario) {
      return res.status(404).json({ mensagem: 'Usuário não encontrado' });
    }

    // Atualiza os dados do usuário com os novos valores
    usuario.nome = nome || usuario.nome;
    usuario.email = email || usuario.email;
    usuario.celular = celular || usuario.celular;
    usuario.estado = estado || usuario.estado;
    usuario.cidade = cidade || usuario.cidade;
    usuario.descricao = descricao || usuario.descricao;
    usuario.fotoPerfil = fotoPerfil || usuario.fotoPerfil;
    usuario.senha = senha || usuario.senha;

    // Salva as alterações no banco de dados
    await usuario.save();

    // Retorna os dados do usuário atualizados
    return res.json(usuario);
  } catch (error) {
    console.error('Erro ao atualizar usuário:', error);
    return res.status(500).json({ mensagem: 'Erro interno do servidor' });
  }
});

app.post('/api/usuarios/atualizar', async (req, res) => {
  const { celularAntigo, celular, nome, email, estado, cidade, descricao, fotoPerfil } = req.body;

  try {
    // Pesquisa e atualiza os livros com 'cidade' igual ao 'celularAntigo'
    await Livro.updateMany({ cidade: celularAntigo }, { $set: { cidade: celular } });

    // Pesquisa o usuário pelo número de celular antigo
    const usuario = await Usuario.findOne({ celular: celularAntigo });

    if (!usuario) {
      return res.status(404).json({ mensagem: 'Usuário não encontrado' });
    }

    // Atualiza os dados do usuário com os novos valores
    usuario.nome = nome || usuario.nome;
    usuario.email = email || usuario.email;
    usuario.celular = celular || usuario.celular;
    usuario.estado = estado || usuario.estado;
    usuario.cidade = cidade || usuario.cidade;
    usuario.descricao = descricao || usuario.descricao;
    usuario.fotoPerfil = fotoPerfil || usuario.fotoPerfil;

    // Salva as alterações no banco de dados
    await usuario.save();

    // Retorna os dados do usuário atualizados
    return res.json(usuario);
  } catch (error) {
    console.error('Erro ao atualizar usuário:', error);
    return res.status(500).json({ mensagem: 'Erro interno do servidor' });
  }
});


// Rota para pesquisar um usuário por número de celular
app.post('/api/usuarios/pesquisar', async (req, res) => {
  console.log(req.body);
  const { celular } = req.body;
  console.log(req.body);
  console.log(`celular ${celular}`);
  try {
    // Pesquisa o usuário pelo número de celular
    const usuario = await Usuario.findOne({ celular: celular });

    if (!usuario) {
      return res.status(404).json({ mensagem: 'Usuário não encontrado' });
    }

    // Retorna os dados do usuário encontrado
    return res.json(usuario);
  } catch (error) {
    console.error('Erro ao pesquisar usuário por celular:', error);
    return res.status(500).json({ mensagem: 'Erro interno do servidor' });
  }
});


app.post('/api/usuarios/login', async (req, res) => {
  const { emailOuCelular, senha } = req.body;
  console.log(req.body)
  console.log(senha)
  // Verificar se o usuário existe com o email ou número de celular fornecido
  const usuario = await Usuario.findOne({
    $or: [{ email: emailOuCelular }, { celular: emailOuCelular }]
  });

  if (!usuario) {
    console.log(req.body)
    return res.status(401).json({ mensagem: 'Credenciais inválidas' });
  }

  // Verificar se a senha está correta
  if (usuario.senha !== senha) {
    console.log(req.body)
    return res.status(401).json({ mensagem: 'Credenciais inválidas' });
  }

  // Autenticação bem-sucedida, retornar os dados do usuário
  return res.json(usuario);
});

// Rotas para manipulação de usuários e livros
// Exemplo: CRUD para usuários
app.post('/api/usuarios', async (req, res) => {
    const novoUsuario = new Usuario(req.body);
    console.log(req.body);
    await novoUsuario.save();
    res.json(novoUsuario);
  });
  
app.get('/api/usuarios', async (req, res) => {
    const usuarios = await Usuario.find();
    res.json(usuarios);
  });

  app.post('/api/livros', async (req, res) => {
    const novoLivro = new Livro(req.body);
    await novoLivro.save();
    res.json(novoLivro);
  });
  
app.get('/api/livros', async (req, res) => {
    const livros = await Livro.find();
    res.json(livros);
  });

  
  
  // Rotas para livros
  // Implemente rotas semelhantes para livros, incluindo operações CRUD

app.listen(port, () => {
  console.log(`Servidor está rodando na porta ${port}`);
});
