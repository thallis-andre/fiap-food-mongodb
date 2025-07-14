# FIAP Food MongoDB - Infraestrutura NoSQL

## 📋 Descrição

Este repositório contém a infraestrutura como código (IaC) para provisionar o banco de dados MongoDB no Atlas, servindo aos **microsserviços de pedidos e pagamentos**.

### Responsabilidades
- Provisionar cluster MongoDB no Atlas
- Configurar conectividade com AWS
- Gerenciar usuários e permissões
- Configurar backup e monitoramento

## 🏗️ Arquitetura

### Tecnologias Utilizadas
- **IaC**: Terraform
- **Banco de Dados**: MongoDB 7.0
- **Cloud**: MongoDB Atlas (AWS)
- **Conectividade**: VPC Peering
- **Região**: us-east-1

### Especificações do Cluster
- **Tipo**: MongoDB Atlas M0 (Shared)
- **Região**: AWS us-east-1
- **Storage**: 512MB (expandível)
- **Backup**: Habilitado
- **Replicação**: 3 réplicas

## 🗄️ Schema dos Bancos

### Microsserviço de Pedidos (Orders)
```javascript
// Collection: orders
{
  _id: ObjectId,
  customer_id: String,
  customer_info: {
    name: String,
    email: String,
    cpf: String
  },
  items: [
    {
      item_id: String,
      name: String,
      price: Number,
      quantity: Number
    }
  ],
  total_amount: Number,
  status: String, // PENDING, PAID, PREPARING, READY, DELIVERED
  created_at: Date,
  updated_at: Date
}

// Collection: items
{
  _id: ObjectId,
  name: String,
  description: String,
  price: Number,
  category: String, // LANCHE, ACOMPANHAMENTO, BEBIDA, SOBREMESA
  image_url: String,
  active: Boolean,
  created_at: Date,
  updated_at: Date
}
```

### Microsserviço de Pagamentos (Payments)
```javascript
// Collection: payments
{
  _id: ObjectId,
  order_id: String,
  payment_method: String, // PIX
  amount: Number,
  status: String, // PENDING, APPROVED, REJECTED
  external_reference: String,
  qr_code_data: String,
  mercado_pago_id: String,
  webhook_data: Object,
  created_at: Date,
  updated_at: Date
}

// Collection: payment_webhooks
{
  _id: ObjectId,
  payment_id: String,
  webhook_type: String,
  payload: Object,
  processed: Boolean,
  created_at: Date
}
```

## 🚀 Deploy e Configuração

### Pré-requisitos
- Terraform >= 1.5.0
- Conta no MongoDB Atlas
- API Key do MongoDB Atlas

### Variáveis de Ambiente
```bash
# Configurar no arquivo .env ou terraform.tfvars
MONGODB_ATLAS_PUBLIC_KEY=<sua_public_key>
MONGODB_ATLAS_PRIVATE_KEY=<sua_private_key>
MONGODB_ATLAS_ORG_ID=<organization_id>
AWS_REGION=us-east-1
```

### Comandos de Deploy

```bash
# Inicializar Terraform
terraform init

# Planejar mudanças
terraform plan

# Aplicar infraestrutura
terraform apply
```

### Outputs Disponíveis
- `mongodb_connection_string`: String de conexão completa
- `mongodb_srv_address`: Endereço SRV do cluster
- `database_user`: Usuário do banco
- `vpc_peering_connection_id`: ID da conexão VPC peering

## 🔗 Integração com Microsserviços

### Arquitetura de Dados
```mermaid
graph TD
    A[Orders Service] --> B[MongoDB Atlas]
    C[Payments Service] --> B
    B --> D[Orders Database]
    B --> E[Payments Database]
    D --> F[orders collection]
    D --> G[items collection]
    E --> H[payments collection]
    E --> I[payment_webhooks collection]
```

### Conexão dos Microsserviços
```env
# Orders Service
MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/fiap_food_orders

# Payments Service
MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/fiap_food_payments
```

## 📊 Monitoramento

### Métricas MongoDB Atlas
- Conexões ativas
- Operações por segundo
- Latência de queries
- Utilização de storage
- Índices performance

### Alertas Configurados
- ✅ Conexões simultâneas > 80%
- ✅ Latência > 100ms
- ✅ Storage > 70%
- ✅ Falhas de conexão

## 🔒 Segurança

### Configurações Implementadas
- ✅ Autenticação SCRAM-SHA-256
- ✅ Criptografia em trânsito (TLS 1.2+)
- ✅ Criptografia em repouso
- ✅ Network Access restrito
- ✅ Database Access com usuários limitados

### Acesso à Rede
- VPC Peering com AWS
- Whitelist de IPs do cluster EKS
- Sem acesso público à internet

## 🛠️ Manutenção

### Backups
- Backup contínuo habilitado
- Point-in-time recovery
- Retenção de 7 dias
- Snapshots automáticos

### Índices Otimizados
```javascript
// Orders collection
db.orders.createIndex({ "customer_id": 1 })
db.orders.createIndex({ "status": 1 })
db.orders.createIndex({ "created_at": -1 })

// Payments collection
db.payments.createIndex({ "order_id": 1 })
db.payments.createIndex({ "status": 1 })
db.payments.createIndex({ "mercado_pago_id": 1 })

// Items collection
db.items.createIndex({ "category": 1 })
db.items.createIndex({ "active": 1 })
```

## 🔄 Replicação e Alta Disponibilidade

### Configuração do Replica Set
- 3 réplicas distribuídas
- Failover automático
- Read preference: primary preferred
- Write concern: majority

## 📚 Documentação Adicional

Para ver a documentação completa do projeto, acesse: [FIAP Food Docs](https://github.com/thallis-andre/fiap-food-docs)

## 👨‍💻 Autor

- **Thallis André Faria Moreira** - RM360145