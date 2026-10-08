DROP TABLE IF EXISTS venda, produto, categoria, cliente
CASCADE;


CREATE TABLE IF NOT EXISTS cliente(
    id_cliente SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    telefone BIGINT NOT NULL UNIQUE,
    endereco VARCHAR(150) NOT NULL
);
CREATE TABLE IF NOT EXISTS categoria(
    id_categoria SERIAL PRIMARY KEY,
    descricao TEXT NOT NULL
    );
CREATE TABLE IF NOT EXISTS produto(
    id_produto SERIAL PRIMARY KEY,
    id_categoria INT REFERENCES categoria(id_categoria),
    nome VARCHAR(100) NOT NULL,
    descricao TEXT NOT NULL,
    preco DECIMAL(19, 2) NOT NULL,
    validade DATE --opcional
    );
CREATE TABLE IF NOT EXISTS venda(
    id_venda SERIAL PRIMARY KEY,
    data_venda DATE, --automatico--
    id_cliente INT REFERENCES  cliente(id_cliente),
    id_produto INT REFERENCES produto(id_produto),
    preco DECIMAL(10, 2) NOT NULL,
    enviar_nota BOOL DEFAULT false
    );

ALTER TABLE venda
DROP CONSTRAINT IF EXISTS id_cliente;

ALTER TABLE venda
ADD CONSTRAINT venda_cliente_fk
FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente)
ON DELETE RESTRICT;

ALTER TABLE produto
DROP CONSTRAINT IF EXISTS id_categoria;

ALTER TABLE produto
ADD CONSTRAINT id_categoria_fk
FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
ON DELETE CASCADE;
