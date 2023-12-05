-- Consultas ao Meteor

-- 1
select * from peca;
select * from ordem_producao;

select
	pk_pecaID as Peça
from peca p
join ordem_producao o on p.pk_pecaID = o.pk_ordemID
where data_conclusao between '2023-11-24' and '2023-12-01'
order by Peça asc;
    
-- 2
select 
	m.nome as Máquina,
    count(o.fk_maquinaID) as Peças
from peca p
join ordem_producao o on p.pk_pecaID = o.pk_ordemID
join maquina m on m.pk_maquinaID = o.fk_maquinaID
group by Máquina
order by Peças asc;
    
-- 3
select 
	tipo as Tipo,
	data_manutencao as Data
 from hist_manutencao
 where data_manutencao between '2023-12-01' and '2023-12-31'
 order by Data asc;
 
 -- 4
select 
	op.nome as Operador,
	count(o.fk_pecaID) as Peça
from ordem_producao o
join maquina m on m.pk_maquinaID = o.fk_maquinaID
join operador op on op.pk_operadorID = m.pk_maquinaID
group by Operador;

-- PS cada operador fez apenas sua peça, essa consulta mostra o total de cada um

-- 5
select
	pk_pecaID as Peça,
    peso as Peso
from peca
order by Peso desc;

-- 6
SELECT 
	pk_rejeicaoID as Peça_Rejeitada,
    data_rejeicao as data
 FROM REJEICAO
where data_rejeicao between '2023-10-01' and '2023-11-31';

 -- 7 
select 
	nome as Fornecedor
from fornecedor
order by Fornecedor asc;

-- 8
select * from materia_prima;


select 
	p.material as Material,
	count(p.fk_materiaID) * sum(mt.quantidade) as Total 
 from peca p
 join materia_prima mt on mt.pk_materiaID = p.fk_materiaID 
 group by Material
 order by Total asc;

-- 9
select 
	p.material as Material,
	count(p.fk_materiaID) * sum(mt.quantidade) as Total 
 from peca p
 join materia_prima mt on mt.pk_materiaID = p.fk_materiaID 
 group by Material
 having Total < 500
 order by Total asc;
 
 -- 10
select * from maquina;
select 
	pk_maquinaID as Id,
	nome as Máquina
from maquina
where ult_manu between '2023-01-01' and '2023-10-01';

-- 11
SELECT 
	AVG( data_inicio between '2023-11-11' and '2023-10-13')  AS Média
FROM ordem_producao
group by Média;

select 
	h.fk_ordemID 
from hist_producao h 
join inspecao i on i.pk_inspecaoID = h.fk_inspecao
where i.data_inspecao between '2023-11-24' AND '2023-12-01' ;

-- 13
select 
	op.nome as Operador,
	count(o.fk_pecaID) as Peça
from ordem_producao o
join maquina m on m.pk_maquinaID = o.fk_maquinaID
join operador op on op.pk_operadorID = m.pk_maquinaID
group by Operador
order by Peça desc;
