-- 1. Tabela Jogadores
CREATE TABLE jogadores (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome_usuario VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha_hash VARCHAR(255) NOT NULL,
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    ultimo_login DATETIME NULL,
    status_conta VARCHAR(20) DEFAULT 'Ativo'
);

-- 2. Tabela Classes
CREATE TABLE classes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome_classe VARCHAR(30) UNIQUE NOT NULL,
    descricao TEXT,
    vida_base INT NOT NULL DEFAULT 100,
    mana_base INT NOT NULL DEFAULT 50,
    ataque_base INT NOT NULL DEFAULT 10,
    defesa_base INT NOT NULL DEFAULT 5
);

-- 3. Tabela Personagens
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

-- 4. Tabela Itens
CREATE TABLE itens (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome_item VARCHAR(50) NOT NULL,
    tipo VARCHAR(30) NOT NULL,
    raridade VARCHAR(20) DEFAULT 'Comum',
    modificador_ataque INT DEFAULT 0,
    modificador_defesa INT DEFAULT 0,
    preco_compra INT DEFAULT 0
);

-- 5. Tabela Inventario (N:M)
CREATE TABLE inventario (
    id INT PRIMARY KEY AUTO_INCREMENT,
    personagem_id INT NOT NULL,
    item_id INT NOT NULL,
    quantidade INT DEFAULT 1,
    equipado BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (personagem_id) REFERENCES personagens(id),
    FOREIGN KEY (item_id) REFERENCES itens(id)
);

-- 6. Tabela Missoes
CREATE TABLE missoes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(100) NOT NULL,
    descricao TEXT,
    nivel_minimo INT DEFAULT 1,
    recompensa_xp INT DEFAULT 0,
    recompensa_ouro INT DEFAULT 0
);

-- 7. Tabela Progresso_Missoes (N:M)
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

-- 8. Tabela Historico_Partidas
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