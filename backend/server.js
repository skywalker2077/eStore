const http = require('http');
const mongoose = require('mongoose');
const requireDir = require("require-dir");

// Iniciando o DB com tratamento de erro
const mongoUrl = process.env.MONGO_URL || 'mongodb://localhost:27017/nodeapi';
console.log(`Conectando ao MongoDB em: ${mongoUrl}`);

// Função para conectar ao MongoDB com retry
function conectarMongoDB(tentativa = 1) {
  const connectPromise = mongoose.connect(mongoUrl, { 
    useUnifiedTopology: true, 
    useNewUrlParser: true,
    serverSelectionTimeoutMS: 1500,
    socketTimeoutMS: 5000,
    retryWrites: false,
    family: 4
  });
  
  connectPromise
    .then(() => {
      console.log('✓ MongoDB conectado com sucesso!');
      iniciarServidor();
    })
    .catch(err => {
      console.warn(`✗ Tentativa ${tentativa} - Erro ao conectar MongoDB:`, err.message ? err.message.substring(0, 50) : 'Erro desconhecido');
      if (tentativa < 3) {
        console.log(`Tentando novamente em 1 segundo...`);
        setTimeout(() => conectarMongoDB(tentativa + 1), 1000);
      } else {
        console.error('✗ Falhou após 3 tentativas. Iniciando servidor sem MongoDB...');
        mongoose.connection.close(false);
        iniciarServidor();
      }
    });
}

function iniciarServidor() {
  try {
    requireDir("./src/models");
  } catch (e) {
    console.warn('Aviso ao carregar modelos:', e.message);
  }
  
  const app = require('./app');
  const port = process.env.PORT || 3001;
  const server = http.createServer(app);
  server.listen(port, () => {
    console.log(`✓ Servidor rodando na porta ${port}`);
  });
}

conectarMongoDB();