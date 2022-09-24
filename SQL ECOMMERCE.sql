-- criação de banco de dados para e-commerce
create database ecommerce;
use ecommerce;

-- criar tabela cliente

create table clients(
	idClient int auto_increment primary key,
    Fname varchar(10) not null,
    Minit char(3),
    Lastname varchar(20),
    CPF char(11) not null,
    Address varchar(30),
    constraint unique_cpf_client unique (CPF),
);

-- criar tabela produto

create table product(
	idProduct int auto_increment primary key,
    Pname varchar(10) not null,
    classification_kids bool default false,
    category enum('eletrônico','vestimenta','brinquedos','alimentos','Mobiliário', 'livros') default 'eletrônico',
    CPF char(11) not null,
    evaluation float default 0,
    size varchar(10),
);

-- tabela com modo de pagamento

create table payments(
	idpayment int,
    idpayClient int,
    typepay enum('Cartão de crédito', 'cartão de débito', 'pix', 'DOC', 'TED', 'Boleto') not null,
    payvalue float,
    primary key(idClient, idpayment),
    constraint fk_payments_clients foreign key (idpayClient) references clients(idClient)
);

-- criar tabela pedido

create table orders(
	idOrder int auto_increment primary key,
    idOrderClient int, 
    orderstatus enum('Processando', 'Confirmado' 'Cancelado', 'enviado') default 'Processando',
    orderdescription varchar(255),
    sendTax float default 0,
    payment cash bool default false,
    idpayment int,
    constraint fk_orders_clients foreign key (idOrderClient) references clients(idClient),
    constraint fk_payment_clients foreign key (idpayment) references payments(idpayment),
);

-- criar tabela estoque

create table productstorage(
idProdStorage int auto_increment primary key,
location varchar(39) not null,
quantity int not null default 0,
);

-- criar tabela fornecedor

create table supplier(
	idSupplier int auto_increment primary key,
    socialname varchar(39) not null,
    CNPJ char(15) not null,
    contact varchar(11) not null,
    constraint unique_supplier unique (CNPJ),
);

create table seller(
	idSeller int auto_increment primary key,
    socialname varchar(39) not null,
    comercialname varchar(40),
    CNPJ char(15),
    CPF char(9),
    location varchar(60),
    contact char(11) not null,
    constraint unique_cnpj_seller unique (CNPJ),
    constraint unique_cpf_seller unique (CPF),
);

create table productSeller(
	idPSeller int,
    idPproduct int,
    quantity int not null default 1,
    primary key (idPSeller, idPproduct),
    constraint fk_product_seller foreign key (idPSeller) references seller(idSeller),
    constraint fk_product_product foreign key (idPproduct) references product(idProduct),
);

create table productOrder(
	idPOproduct int,
    idPOorder int,
    poQuantity int default 1,
    poStatus enum('Disponível','Indisponível') default 'Disponível',
    primary key (idPOproduct, idPOorder),
    constraint fk_product_seller foreign key (idPOproduct) references product(idProduct)
    constraint fk_product_product foreign key (idPOorder) references orders(idOrder)
);

create table storagelocation(
	idLproduct int,
    idLstorage int,
    location varchar(255) not null,
    primary key (idLproduct,idLstorage),
    constraint fk_product_product foreign key (idLproduct) references product(idProduct),
    constraint fk_product_storage foreign key (idLstorage) references productstorage(idProdStorage),
);


create table productSupplier(
	idPsSupplier int,
    idPsProduct int,
    quantity int not null,
    primary key (idPsSupplier, idPsProduct),
    constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
    constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct),
);
