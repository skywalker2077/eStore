# WebStore

## Descrição

Com a popularização da internet, a demanda por serviços eletrônicos que possam facilitar e gerar impacto na vida das pessoas têm aumentado cada vez mais. A necessidade de se deslocar até lojas físicas, seja para comprar ou pesquisar produtos, gera um dispendimento de tempo considerável. Sendo assim, o e-commerce (ou comércio eletrônico) aparece como uma alternativa para que as pessoas possam comprar, pesquisar preços e produtos apenas possuindo um aparelho com acesso a internet.

Pensando nisso, foi desenvolvido o **_eStore_**, uma loja virtual, onde é possível pesquisar por produtos, filtrá-los por categoria, adicioná-los ao carrinho e comprá-los. Além disso, também é possível visualizar informações dos detalhes de cada produto disponível.

## Funcionalidades

- Na página inicial, o usuário pode:
  - Visualizar lista de produtos disponíveis na loja, onde cada produto contém contém descrição e preço.
  - Filtrar os produtos através de categorias.
  - Adicionar o produto ao carrinho de compras.
- Na página do carrinho de compras, o usuário pode:
  - Remover do carrinho.
  - Ver quais produtos estão adicionados no carrinho.
  - Indicar a quantidade de cada produtos para compra.
  - Ver o valor total da compra.
- Na página de produtos, o usuário pode:
  - Ver os detalhes do produto, como sua descrição, preço e imagem ampliada.
  - Adicionar o produto ao carrinho de compras.

## Tecnologias Utilizadas

### Frontend
- **React** 16.13.1 - Framework JavaScript
- **React Router DOM** 5.2.0 - Navegação entre páginas
- **Bootstrap** 4.5.3 - Framework CSS
- **Axios** 0.21.0 - Cliente HTTP para requisições API

### Backend
- **Node.js** - Runtime JavaScript
- **Express** 4.17.1 - Framework web
- **MongoDB** - Banco de dados NoSQL
- **Mongoose** 5.10.6 - ODM para MongoDB
- **CORS** - Habilitação de requisições cross-origin

### DevOps
- **Docker** & **Docker Compose** - Containerização
- **Yarn** - Gerenciador de pacotes

## Pré-requisitos

- **Node.js** (v14 ou superior)
- **Yarn** ou **npm**
- **Docker Desktop** (para rodar MongoDB)
- Sistema Operacional: Windows, Linux ou macOS

## Instalação e Execução

### 1. Clonar o Repositório

```bash
git clone https://github.com/skywalker2077/eStore.git
cd eStore
```

### 2. Iniciar MongoDB com Docker Compose

```bash
docker-compose up -d mongodb
```

Isso irá:
- Baixar a imagem do MongoDB (se necessário)
- Criar e iniciar o container `estore-mongodb`
- Expor MongoDB na porta `27017`
- Criar um volume persistente para os dados

### 3. Instalar Dependências

**Backend:**
```bash
cd backend
yarn install
```

**Frontend:**
```bash
cd ../frontend
yarn install
```

### 4. Executar a Aplicação

**Backend (Terminal 1):**
```bash
cd backend
yarn start
```
O backend estará disponível em: `http://localhost:3001`

**Frontend (Terminal 2):**
```bash
cd frontend
yarn start
```
O frontend estará disponível em: `http://localhost:3000`

## Endpoints da API

### Produtos
- `GET /produtos` - Lista todos os produtos (com paginação)
- `GET /produtos/:id` - Busca produto por ID
- `POST /produtos` - Cria novo produto
- `PUT /produtos/:id` - Atualiza produto existente
- `DELETE /produtos/:id` - Remove produto

### Pedidos
- `GET /pedidos` - Lista todos os pedidos (com paginação)
- `GET /pedidos/:id` - Busca pedido por ID
- `POST /pedidos` - Cria novo pedido
- `DELETE /pedidos/:id` - Remove pedido

## Testando a API

### Com cURL

```bash
# Listar produtos
curl http://localhost:3001/produtos

# Listar pedidos
curl http://localhost:3001/pedidos

# Criar produto (exemplo)
curl -X POST http://localhost:3001/produtos \
  -H "Content-Type: application/json" \
  -d '{
    "nome": "Produto Teste",
    "preco": 99.90,
    "descricao": "Descrição do produto",
    "categoria": "Eletrônicos"
  }'
```

### Com Postman

Importe a coleção de requests:
`https://drive.google.com/file/d/10xr6nd5AAi27_475YYU7tUg7lw6GSBpB/view?usp=sharing`

## Estrutura do Projeto

```
eStore/
├── backend/              # API Node.js + Express
│   ├── src/
│   │   ├── controllers/  # Lógica de negócio
│   │   ├── models/       # Modelos Mongoose
│   │   └── routes/       # Definição de rotas
│   ├── app.js           # Configuração Express
│   ├── server.js        # Servidor HTTP
│   ├── Dockerfile       # Container backend
│   └── package.json
├── frontend/            # Aplicação React
│   ├── src/
│   │   ├── components/  # Componentes React
│   │   ├── context/     # Context API
│   │   └── services/    # Serviços (API)
│   ├── public/
│   └── package.json
├── docker-compose.yml   # Orquestração de containers
└── README.md
```

## Comandos Docker Úteis

```bash
# Iniciar todos os serviços
docker-compose up -d

# Parar todos os serviços
docker-compose down

# Ver logs do MongoDB
docker logs estore-mongodb

# Acessar MongoDB shell
docker exec -it estore-mongodb mongosh

# Ver containers rodando
docker ps

# Remover volumes e containers
docker-compose down -v
```

## Troubleshooting

### Porta 3001 já está em uso
```bash
# Windows
netstat -ano | findstr :3001
taskkill /PID <PID> /F

# Linux/Mac
lsof -i :3001
kill -9 <PID>
```

### MongoDB não conecta
```bash
# Verificar se container está rodando
docker ps | grep mongo

# Reiniciar container
docker restart estore-mongodb

# Ver logs
docker logs estore-mongodb
```

## Licença

ISC
