# README - Banco de Dados de Rede Social

Este repositório contém o script SQL para criar e gerenciar um banco de dados de uma rede social simples. O banco de dados é projetado para armazenar informações sobre usuários, postagens, comentários e amizades. Abaixo, você encontrará uma breve descrição de cada tabela e as consultas SQL relevantes para interações com o banco de dados.

## Tabelas

### Tabela de Usuários (usuario)
- `id_usuario`: Identificador único do usuário (chave primária).
- `prime_nome` e `ulim_nome`: Primeiro e último nome do usuário.
- `naicimento`: Data de nascimento do usuário.
- `Bio`: Breve descrição ou biografia do usuário.
- `data_criacao`: Data e hora de criação do registro do usuário.

### Tabela de Postagens (postagem)
- `id_postagem`: Identificador único da postagem (chave primária).
- `conteudo`: Texto da postagem.
- `id_usuario`: Identificador do usuário que fez a postagem (chave estrangeira referenciando a tabela de usuários).
- `data_postagem`: Data e hora da postagem.

### Tabela de Comentários (comentario)
- `id_comentario`: Identificador único do comentário (chave primária).
- `texto`: Texto do comentário.
- `id_usuario`: Identificador do usuário que fez o comentário (chave estrangeira referenciando a tabela de usuários).
- `id_postagem`: Identificador da postagem à qual o comentário está associado (chave estrangeira referenciando a tabela de postagens).
- `data_comentario`: Data e hora do comentário.

### Tabela de Amizades (amizade)
- `id_amizade`: Identificador único da amizade (chave primária).
- `id_usuario1` e `id_usuario2`: Identificadores dos dois usuários envolvidos na amizade (chaves estrangeiras referenciando a tabela de usuários).
- `data_amizade`: Data e hora em que a amizade foi estabelecida.

## Consultas

O script inclui diversas consultas para interação com o banco de dados, incluindo seleção, atualização, exclusão e estatísticas. Algumas consultas notáveis são:

- Seleção de todos os usuários, postagens, comentários e amizades.
- Inserção de novos usuários, postagens, comentários e amizades.
- Atualização de dados do usuário.
- Exclusão de um usuário.
- Estatísticas de nascimento, como idade média e número total de usuários.
- Junção de usuários e postagens, ordenação e seleção específica.
- Consultas para identificar usuários com base em critérios específicos, como idade, início do nome, etc.
- Operações de alteração de esquema, como adição, remoção e modificação de colunas.
- Criação e remoção de índices para otimização de consultas.
