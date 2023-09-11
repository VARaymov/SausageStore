alter table product add constraint product_pkey primary key (id);
 alter table orders add conttraint order_pkey primary key (id);
 create index order_product_order_id_idx on order_product (order_id);
 create index order_product_product_id_idx on order_product (product_id);
