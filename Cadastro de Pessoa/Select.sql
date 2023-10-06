---Demonstração dos select, where, and, or e like--

SELECT * FROM Person_F;
SELECT * FROM UF;
SELECT * FROM city;
SELECT * FROM endereco;

select * 
from city
where cd_uf_ibge in(42,52)
and (dsc_city like '%São%' 
or dsc_city like '%Santa%' );   

--Melhor forma de gerar relatório--

select 
    a.id_c "Sequencia",
    a.cd_city_ibge" Codigo da cidade",
    a.dsc_city"Cidade",
    cd_uf_ibge"Codigo UF"
from city a
where a.cd_uf_ibge in(42,52,12)
and (a.dsc_city like '%São%' 
or a.dsc_city like '%Santa%' );  

SELECT * FROM Person_F;
SELECT * FROM UF;
SELECT * FROM city;
SELECT * FROM endereco;

--Demonstração decode, case, to_char e to_numbe--

select 
    id_p,
    nm,
    dt_nascimento,
    gener,
    decode(gener,'M','Masculino','F','Feminino','Indeterminado')ds_gener
from Person_f a;
    
select 
    id_p,
    nm,
    dt_nascimento,
    gener,
    case when gener = 'M' then 'Masculino'
        when gener = 'F' then 'Feminino'
        else 'Indeterminado'
        end ds_gener
from Person_f a;
    
--r--
    
select 
    id_p,
    nm,
    dt_nascimento,
    gener,
    (to_number(to_char(sysdate,'yyyy')))-(to_number(to_char(dt_nascimento,'YYYY')))qt_Idade,
    case when(to_number(to_char(sysdate,'yyyy')))-(to_number(to_char(dt_nascimento,'YYYY')))between 1 and 60 then 'Jovem'
         when(to_number(to_char(sysdate,'yyyy')))-(to_number(to_char(dt_nascimento,'YYYY')))between 61 and 999 then 'Idoso'
    else 'Indeterminado' 
    end Faixa_etaria
from Person_f a;
    
    --comando nvl coalesce--   
    
select 
    id_p,
    nm,
    dt_nascimento,
    gener,
    nvl(gener,'Indeterminado')ds_gener
from Person_f a;

select 
    id_p,
    nm,
    dt_nascimento,
    gener,
    coalesce(gener,to_char(qt_tall), nm,'Indeterminado')ds_gener
from Person_f a;
    
    
    
--demonstrando exists, not exists e join--

select 
    pf.id_p,
    pf.nm,
    pf.dt_nascimento,
    pfe.nr_municipio,
    c.dsc_city
from Person_F pf
left join endereco pfe on(pf.id_p = pfe.id_andress)
left join city c on(c.id_c = pfe.nr_municipio);

select 
    pf.id_p,
    pf.nm,
    pf.dt_nascimento
from Person_F pf
where not exists (--caso queira mostrar as pessos com endereço usar o existis--
    select 1
    from endereco e
    where e.nr_seq = pf.id_p);
    
--inner join--    
select 
    pf.id_p,
    pf.nm,
    pf.dt_nascimento,
    c.dsc_city
from Person_F pf
join endereco pfe on(pf.id_p = pfe.id_andress)
join city c on(c.id_c = pfe.nr_municipio)
join uf on (uf.id_e = pfe.nr_uf );
    

--left join--

select 
    pf.id_p,
    pf.nm,
    pf.dt_nascimento,
    c.dsc_city,
    uf.dsc
from Person_F pf
left join endereco pfe on(pf.id_p = pfe.id_andress)
left join city c on(c.id_c = pfe.nr_municipio)
left join uf on (uf.id_e = pfe.nr_uf );


--count, max,min, avg e sun--

update person_f set person_f.qt_tall = trunc(dbms_random.value(1.2, 2.2),2);
commit;


select count(*)qt,
    decode(gener,'M','Masculino','F','Feminino','Não Informado') gener
from person_f
group by decode(gener,'M','Masculino','F','Feminino','Não Informado');
--

select max(qt_tall)qt,
    decode(gener,'M','Masculino','F','Feminino','Não Informado') gener
from person_f
group by decode(gener,'M','Masculino','F','Feminino','Não Informado');
--

select min(qt_tall)qt,
            decode(gener,'M','Masculino','F','Feminino','Não Informado')gener
from Person_F
group by decode(gener,'M','Masculino','F','Feminino','Não Informado');
--
select sum(qt_tall)qt,
            decode(gener,'M','Masculino','F','Feminino','Não Informado')gener
from Person_F
group by decode(gener,'M','Masculino','F','Feminino','Não Informado');
--

select trunc(avg(qt_tall),2)qt,
            decode(gener,'M','Masculino','F','Feminino','Não Informado') gener
from Person_F
group by decode(gener,'M','Masculino','F','Feminino','Não Informado');



--to_char, to_number e to_date--

select  dt_nascimento,
              to_char(dt_nascimento, 'dd')dia_nascimento,
              to_char(dt_nascimento, 'd')dia_semana_nascimento,
              to_char(dt_nascimento, 'day')dia_semana_extenso_nascimento,
              to_number(to_char(dt_nascimento, 'mm'))mes_nascimento,
              to_char(dt_nascimento, 'MON')mes_extenso_nascimento, 
              to_char(dt_nascimento, 'yyyy')ano_nascimento
from Person_F;
--
select  qt_tall,
             trim(to_char(qt_tall,'90D99'))qt_tall2,
             trim(to_char(0.9,'90D99')) qt_tall3
from Person_F;
--
select n_cpf,
             lpad(n_cpf,11,'0')n_cpf2,
             rpad(n_cpf,11,'0')n_cpf3          
from Person_F;











commit;
