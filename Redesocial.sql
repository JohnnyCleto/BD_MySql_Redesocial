-- Criar o banco de dados
CREATE DATABASE IF NOT EXISTS redesocial;
USE redesocial;

-- Tabela de Usuários
CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    prime_nome VARCHAR(90) NOT NULL,
    ulim_nome VARCHAR(90) NOT NULL,
    naicimento DATE,
    Bio VARCHAR(100),
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de Postagens
CREATE TABLE postagem (
    id_postagem INT AUTO_INCREMENT PRIMARY KEY,
    conteudo TEXT NOT NULL,
    id_usuario INT NOT NULL,
    data_postagem TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

-- Tabela de Comentários
CREATE TABLE comentario (
    id_comentario INT AUTO_INCREMENT PRIMARY KEY,
    texto TEXT NOT NULL,
    id_usuario INT NOT NULL,
    id_postagem INT NOT NULL,
    data_comentario TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_postagem) REFERENCES postagem(id_postagem)
);

-- Tabela de Amizades
CREATE TABLE amizade (
    id_amizade INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario1 INT NOT NULL,
    id_usuario2 INT NOT NULL,
    data_amizade TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario1) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_usuario2) REFERENCES usuario(id_usuario)
);

-- Consultas
SELECT * FROM usuario;
SELECT * FROM postagem;
SELECT * FROM comentario;
SELECT * FROM amizade;

-- Exclusão da tabela de Usuários
DROP TABLE usuario;

-- Inserção de Usuários
INSERT INTO usuario (prime_nome, ulim_nome, naicimento, Bio) VALUES ('João', 'Vitor', '2000-03-26', 'Garoto de programa');
INSERT INTO usuario (prime_nome, ulim_nome, naicimento, Bio) VALUES ('Maria', 'Silva', '1995-07-12', 'Estudante de Engenharia');
INSERT INTO usuario (prime_nome, ulim_nome, naicimento, Bio) VALUES ('Carlos', 'Santos', '1987-02-15', 'Médico');
INSERT INTO usuario (prime_nome, ulim_nome, naicimento, Bio) VALUES ('Ana', 'Oliveira', '1998-09-30', 'Designer de Interiores');

-- Inserção de Postagens
INSERT INTO postagem (conteudo, id_usuario) VALUES ('Em aula de Banco de Dados hoje, difícil demais!', 1);
INSERT INTO postagem (conteudo, id_usuario) VALUES ('No parque aproveitando o dia ensolarado!', 2);
INSERT INTO postagem (conteudo, id_usuario) VALUES ('Plantão no hospital, muitos casos hoje.', 3);
INSERT INTO postagem (conteudo, id_usuario) VALUES ('Novo projeto de decoração em andamento.', 4);

-- Inserção de Comentários
INSERT INTO comentario (texto, id_usuario, id_postagem) VALUES ('Entendo, matemática é complicada mesmo!', 2, 1);
INSERT INTO comentario (texto, id_usuario, id_postagem) VALUES ('Que foto linda no parque!', 1, 2);
INSERT INTO comentario (texto, id_usuario, id_postagem) VALUES ('Espero que todos se recuperem logo.', 4, 3);
INSERT INTO comentario (texto, id_usuario, id_postagem) VALUES ('Adoro seu trabalho, sempre incrível!', 3, 4);

-- Inserção de Amizades
INSERT INTO amizade (id_usuario1, id_usuario2) VALUES (1, 2);
INSERT INTO amizade (id_usuario1, id_usuario2) VALUES (2, 3);
INSERT INTO amizade (id_usuario1, id_usuario2) VALUES (3, 4);

-- Atualização de dados
UPDATE usuario SET ulim_nome = 'Victor' WHERE id_usuario = 1;

-- Exclusão de Usuário
DELETE FROM usuario WHERE ulim_nome = 'Victor';

-- Estatísticas de Nascimento
SELECT MIN(naicimento) FROM usuario;
SELECT MAX(naicimento) FROM usuario;
SELECT COUNT(naicimento) FROM usuario;
SELECT AVG(naicimento) FROM usuario;
SELECT SUM(naicimento) FROM usuario;

-- Junção de Usuários e Postagens
SELECT usuario.prime_nome, postagem.conteudo
FROM usuario
INNER JOIN postagem ON usuario.id_usuario = postagem.id_usuario;

-- Junção de Usuários e Postagens (Left Join)
SELECT usuario.prime_nome, postagem.conteudo
FROM usuario
LEFT JOIN postagem ON usuario.id_usuario = postagem.id_usuario;

-- Junção de Usuários e Postagens (Right Join)
SELECT usuario.prime_nome, postagem.conteudo
FROM usuario
RIGHT JOIN postagem ON usuario.id_usuario = postagem.id_usuario;

-- Ordenação por Data de Nascimento Descendente
SELECT * FROM usuario
ORDER BY naicimento DESC;

-- Seleção de Usuário Específico
SELECT * FROM usuario
WHERE id_usuario = 12;

-- Contagem dos usuários com mais de 25 anos
SELECT COUNT(*) AS total_usuarios_mais_25
FROM usuario
WHERE TIMESTAMPDIFF(YEAR, naicimento, CURDATE()) > 25;

-- Seleção dos usuários que começam com 'am'
SELECT *
FROM usuario
WHERE prime_nome LIKE 'am%';

-- Seleção dos usuários com idade entre 25 e 30 anos
SELECT *
FROM usuario
WHERE TIMESTAMPDIFF(YEAR, naicimento, CURDATE()) BETWEEN 25 AND 30;

-- Seleção dos usuários com 22, 27 e 34 anos
SELECT *
FROM usuario
WHERE TIMESTAMPDIFF(YEAR, naicimento, CURDATE()) IN (22, 27, 34);

-- Adição, remoção e modificação de colunas
ALTER TABLE usuario
ADD COLUMN nova_coluna INT;

ALTER TABLE usuario
DROP COLUMN Bio;

ALTER TABLE usuario
MODIFY COLUMN prime_nome VARCHAR(100);

-- Criação e remoção de índice
CREATE INDEX idx_usuario_nascimento ON usuario (naicimento);

-- Remoção de índice
DROP INDEX idx_usuario_nascimento ON usuario;

-- Seleção das idades distintas
SELECT DISTINCT TIMESTAMPDIFF(YEAR, naicimento, CURDATE()) AS idade
FROM usuario;

-- Recuperação de Postagens feitas por um usuário chamado 'João'
SELECT post.*
FROM post
JOIN usuario ON postagem.id_usuario = usuario.id_usuario
WHERE usuario.prime_nome = 'João';

-- Comentários em uma Postagem com o texto 'Bom dia, mundo!'
SELECT comentario.*
FROM comentario
JOIN postagem ON comentario.id_post = post.id_postagem
WHERE post.conteudo LIKE 'Bom dia, mundo!';

-- Estatísticas de Atividades por usuário
SELECT usuario.prime_nome,
       COUNT(DISTINCT post.id_post) AS total_postagens,
       COUNT(DISTINCT comentario.id_comentario) AS total_comentarios
FROM usuario
LEFT JOIN post ON usuario.id_usuario = post.id_usuario
LEFT JOIN comentario ON usuario.id_usuario = comentario.id_usuario
GROUP BY usuario.prime_nome;

-- Amizades Recentes formadas nos últimos 30 dias
SELECT *
FROM amizade
WHERE data_amizade >= CURDATE() - INTERVAL 30 DAY;

-- Detalhes de um Usuário chamado 'Maria' incluindo postagens e amizades
SELECT usuario.*,
       post.*,
       amizade.*
FROM usuario
LEFT JOIN post ON usuario.id_usuario = post.id_usuario
LEFT JOIN amizade ON usuario.id_usuario = amizade.id_usuario
WHERE usuario.prime_nome = 'Maria';

