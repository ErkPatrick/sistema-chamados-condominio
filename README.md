# Sistema de Gerenciamento de Chamados para Condomínio

Desafio Técnico — Processo Seletivo Dunnas (Desafio N° 0004/2026)

Sistema desenvolvido em Ruby on Rails para gerenciamento de chamados em condomínios, com suporte a múltiplos perfis de usuário, controle de acesso, SLA e histórico de interações.

---

## Sumário

- [Tecnologias utilizadas](#tecnologias-utilizadas)
- [Estrutura do sistema](#estrutura-do-sistema)
- [Funcionalidades](#funcionalidades)
- [Decisões técnicas](#decisões-técnicas)
- [Diagrama relacional](#diagrama-relacional)
- [Instruções de execução](#instruções-de-execução)
- [Credenciais iniciais](#credenciais-iniciais)
- [Contato](#contato)

---

## Tecnologias utilizadas

| Tecnologia | Versão | Finalidade |
|---|---|---|
| Ruby | 3.2.4 | Linguagem principal |
| Ruby on Rails | 8.1.3 | Framework MVC |
| PostgreSQL | 14 | Banco de dados |
| Devise | latest | Autenticação |
| Pundit | latest | Autorização por perfil |
| Tailwind CSS | v4 | Estilização das views |
| Active Storage | nativo Rails | Upload de anexos |

---

## Estrutura do sistema

O sistema é organizado em torno da estrutura física do condomínio:

```
Bloco (prédio)
└── Unidades (apartamentos, geradas automaticamente)
    └── Moradores (vinculados pelo administrador)
        └── Chamados
            ├── Comentários
            └── Anexos
```

### Perfis de usuário

**Administrador**
- Gerencia blocos, unidades e usuários
- Vincula moradores às unidades
- Cadastra tipos de chamado (com SLA) e status possíveis
- Acessa todos os chamados do sistema
- Pode comentar e adicionar anexos em qualquer chamado

**Colaborador**
- Acessa todos os chamados do sistema (escopo global)
- Aplica filtros e atualiza status dos chamados
- Pode comentar nos chamados

**Morador**
- Abre chamados nas suas unidades vinculadas
- Visualiza apenas os chamados das suas unidades
- Pode comentar e adicionar anexos nos seus chamados

---

## Funcionalidades

- Cadastro de blocos com geração automática de unidades seguindo o padrão `BLOCO-ANDARNUMERO` (ex: `A-101`)
- Vínculo de moradores a múltiplas unidades
- Abertura de chamados com tipo, descrição e anexos
- Status de chamados configuráveis pelo administrador
- SLA por tipo de chamado com indicação visual de prazo e atraso
- Preenchimento automático da data de finalização ao concluir um chamado
- Histórico de comentários por chamado
- Upload de anexos via Active Storage
- Controle de acesso por perfil com Pundit
- Dashboard com visão geral do sistema

---

## Decisões técnicas

### Devise para autenticação
O Devise foi escolhido por gerar as views de login automaticamente, gerenciar sessão e cookies de forma segura, ser um padrão consolidado no mercado Rails e economizar tempo de desenvolvimento para focar nas regras de negócio.

### Pundit para autorização
O Pundit centraliza as regras de permissão em Policy classes separando claramente o "o que fazer" (controller) do "quem pode fazer" (policy). Isso torna o controle de acesso mais fácil de implementar e escalar.

### Blocos não podem ser editados
Editar um bloco (quantidade de andares ou aptos por andar) geraria uma complexidade muito alta no gerenciamento das unidades já existentes, dos moradores vinculados e dos chamados abertos. A decisão foi não permitir edição, se necessário o administrador deleta e recria o bloco.

### Status padrão de chamado
O administrador cadastra os status possíveis do sistema. Um deles é marcado como `is_default: true` e outro como `is_final: true`. Todo chamado novo recebe o status padrão automaticamente via callback `before_create`. Quando o status é alterado para o status final, o campo `closed_at` é preenchido automaticamente via callback `before_save`.

### Escopo de acesso do colaborador
O desafio menciona que colaboradores veem chamados "dentro do seu escopo" sem detalhar como esse escopo de fato seria. A decisão foi adotar o **escopo global**, colaboradores veem todos os chamados do sistema, sem vínculo com blocos ou unidades específicas.

### Active Storage para anexos
O Active Storage é um módulo nativo do Rails que gerencia upload e armazenamento de arquivos. Em desenvolvimento os arquivos são armazenados localmente. Em produção pode ser configurado para Amazon S3, Google Cloud Storage ou Azure sem mudanças no código da aplicação.

### Tailwind CSS para estilização
O Tailwind CSS foi escolhido por sua abordagem utilitária que permite construir interfaces responsivas rapidamente sem sair do HTML. O sistema é responsivo e adapta o layout para mobile, tablet e desktop.

---

## Diagrama Relacional

```
users
├── id, name, email, encrypted_password, role (admin/collaborator/resident)
└── timestamps

blocks
├── id, identifier, floors, units_per_floor
└── timestamps

units
├── id, block_id (FK), floor, number, identifier
└── timestamps

unit_users (vínculo morador <==> unidade)
├── id, unit_id (FK), user_id (FK)
└── timestamps

ticket_types
├── id, title, sla_hours
└── timestamps

ticket_statuses
├── id, name, is_default, is_final
└── timestamps

tickets
├── id, unit_id (FK), user_id (FK), ticket_type_id (FK), ticket_status_id (FK)
├── description, opened_at, closed_at
└── timestamps

attachments
├── id, ticket_id (FK)
└── timestamps

comments
├── id, ticket_id (FK), user_id (FK), body
└── timestamps
```


<img width="1577" height="1544" alt="sistemas_chamados_condominio drawio" src="https://github.com/user-attachments/assets/62a2cbb0-bdf4-4098-97f5-05adc4b64423" />

---

## Instruções de execução

### Pré-requisitos

- Ruby 3.2.4
- Rails 8.1.3
- PostgreSQL 14+
- Node.js (para o Tailwind)

---

### 1. Clonar o repositório

```bash
git clone https://github.com/ErkPatrick/sistema-chamados-condominio.git
cd sistema-chamados-condominio
```

### 2. Instalar dependências

```bash
bundle install
```

### 3. Configurar Variáveis de Ambiente
Crie o arquivo `.env` na raiz do projeto a partir do exemplo fornecido:

```Bash
cp .env.example .env
```
Nota: Certifique-se de que o arquivo .env contém as credenciais corretas para o seu ambiente local. O arquivo config/database.yml já está configurado para ler estas variáveis automaticamente.


### 4. Configurar o Banco de Dados
Crie um usuário no PostgreSQL:

```bash
sudo -u postgres psql -c "CREATE USER condominium WITH PASSWORD 'password123' CREATEDB;"
```
### 5. Criar o banco, rodar migrations e seeds

```bash
rails db:create
rails db:migrate
rails db:seed
```

### 6. Iniciar o servidor

```bash
bin/dev
```

Acesse `http://localhost:3000`.

---

## Credenciais iniciais

Após rodar os seeds, o sistema já estará configurado com:

**Administrador padrão:**
| Campo | Valor |
|---|---|
| E-mail | admin@condominio.com |
| Senha | password123 |

**Status de chamados criados:**
| Nome | Padrão | Final |
|---|---|---|
| Aberto | Sim | Não |
| Em andamento | Não | Não |
| Aguardando resposta | Não | Não |
| Concluído | Não | Sim |

**Tipos de chamado criados:**
| Tipo | SLA |
|---|---|
| Manutenção | 48h |
| Limpeza | 24h |
| Segurança | 12h |
| Barulho | 6h |
| Outros | 72h |

---

## Contato

Desenvolvido por Erick Patrick de Paula Morais Freitas para o processo seletivo da Dunnas Tecnologia.

Entre em contato por e-mail: erick.patrickfreitas@gmail.com
