-- 1. ESTRUTURA DO BANCO (Conteúdo do arquivo rpgquest.sql)
CREATE TABLE jogadores (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome_usuario VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha_hash VARCHAR(255) NOT NULL,
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    ultimo_login DATETIME NULL,
    status_conta VARCHAR(20) DEFAULT 'Ativo'
);

CREATE TABLE classes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome_classe VARCHAR(30) UNIQUE NOT NULL,
    descricao TEXT,
    vida_base INT NOT NULL DEFAULT 100,
    mana_base INT NOT NULL DEFAULT 50,
    ataque_base INT NOT NULL DEFAULT 10,
    defesa_base INT NOT NULL DEFAULT 5
);

CREATE TABLE personagens (
    id INT PRIMARY KEY AUTO_INCREMENT,
    jogador_id INT NOT NULL,
    classe_id INT NOT NULL,
    nome_personagem VARCHAR(50) NOT NULL,
    nivel INT DEFAULT 1,
    experiencia INT DEFAULT 0,
    ouro INT DEFAULT 0,
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (jogador_id) REFERENCES jogadores(id),
    FOREIGN KEY (classe_id) REFERENCES classes(id)
);

CREATE TABLE itens (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome_item VARCHAR(50) NOT NULL,
    tipo VARCHAR(30) NOT NULL,
    raridade VARCHAR(20) DEFAULT 'Comum',
    modificador_ataque INT DEFAULT 0,
    modificador_defesa INT DEFAULT 0,
    preco_compra INT DEFAULT 0
);

CREATE TABLE inventario (
    id INT PRIMARY KEY AUTO_INCREMENT,
    personagem_id INT NOT NULL,
    item_id INT NOT NULL,
    quantidade INT DEFAULT 1,
    equipado BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (personagem_id) REFERENCES personagens(id),
    FOREIGN KEY (item_id) REFERENCES itens(id)
);

CREATE TABLE missoes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(100) NOT NULL,
    descricao TEXT,
    nivel_minimo INT DEFAULT 1,
    recompensa_xp INT DEFAULT 0,
    recompensa_ouro INT DEFAULT 0
);

CREATE TABLE progresso_missoes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    personagem_id INT NOT NULL,
    missao_id INT NOT NULL,
    status VARCHAR(20) DEFAULT 'Em Andamento',
    data_inicio DATETIME DEFAULT CURRENT_TIMESTAMP,
    data_conclusao DATETIME NULL,
    FOREIGN KEY (personagem_id) REFERENCES personagens(id),
    FOREIGN KEY (missao_id) REFERENCES missoes(id)
);

CREATE TABLE historico_partidas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    jogador_id INT NOT NULL,
    modo_jogo VARCHAR(30) NOT NULL,
    pontos_obtidos INT NOT NULL DEFAULT 0,
    duracao_segundos INT NOT NULL,
    resultado VARCHAR(20) NOT NULL,
    data_partida DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (jogador_id) REFERENCES jogadores(id)
);

-- 2. POVOANDO DADOS INICIAIS PARA TESTE
INSERT INTO jogadores (nome_usuario, email, senha_hash) VALUES
('GamerPro99', 'pro99@email.com', 'hash_senha1'),
('ShadowNinja', 'ninja@email.com', 'hash_senha2'),
('MageLord', 'mage@email.com', 'hash_senha3');

INSERT INTO classes (nome_classe, descricao, vida_base, mana_base, ataque_base, defesa_base) VALUES
('Guerreiro', 'Forte combate corpo a corpo', 150, 20, 15, 10),
('Mago', 'Especialista em magias e dano em área', 80, 150, 20, 3),
('Arqueiro', 'Ataques rápidos à distância', 100, 60, 12, 6);

INSERT INTO personagens (jogador_id, classe_id, nome_personagem, nivel, experiencia, ouro) VALUES
(1, 1, 'Aragorn', 5, 1200, 350),
(1, 2, 'Gandalf', 12, 8500, 1200),
(2, 3, 'Legolas', 3, 400, 80);

INSERT INTO itens (nome_item, tipo, raridade, modificador_ataque, modificador_defesa, preco_compra) VALUES
('Espada de Aço', 'Arma', 'Comum', 15, 0, 100),
('Cajado Mágico', 'Arma', 'Raro', 25, 0, 300),
('Escudo de Ferro', 'Armadura', 'Comum', 0, 10, 80),
('Poção de Vida', 'Consumível', 'Comum', 0, 0, 20);

INSERT INTO inventario (personagem_id, item_id, quantidade, equipado) VALUES
(1, 1, 1, TRUE),
(1, 3, 1, TRUE),
(1, 4, 5, FALSE),
(2, 2, 1, TRUE);

INSERT INTO missoes (titulo, descricao, nivel_minimo, recompensa_xp, recompensa_ouro) VALUES
('Matar os Goblins', 'Derrote 5 goblins na floresta', 1, 100, 50),
('Resgatar o Mercador', 'Encontre o mercador perdido na caverna', 3, 300, 150);

INSERT INTO progresso_missoes (personagem_id, missao_id, status) VALUES
(1, 1, 'Concluída'),
(1, 2, 'Em Andamento'),
(3, 1, 'Em Andamento');

INSERT INTO historico_partidas (jogador_id, modo_jogo, pontos_obtidos, duracao_segundos, resultado) VALUES
(1, 'PvP', 1200, 300, 'Vitória'),
(1, 'Dungeon', 2500, 900, 'Vitória'),
(2, 'PvP', 450, 180, 'Derrota');