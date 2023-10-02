create table city(
id_c INTEGER constraint id_c_pk primary key, 
dt_criacao DATE, 
dt_halter DATE, 
cd_city_ibge NUMBER(7) not null constraint cd_city_ibge_un unique,  
dsc_city VARCHAR2(255));

alter table city add cd_uf_ibge number(2);
alter table city add constraint cd_uf_ibge_fk foreign key(cd_uf_ibge) references UF(cd_uf_ibge);

delete city;

select * 
from city
where cd_uf_ibge = '42'