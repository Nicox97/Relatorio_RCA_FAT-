select
    p.codusur as CodUsuario,
    iten.codprod,
    sum(iten.numitens) as Total_Itens
from 
    pcpedc p,
    (select codprod,
            numped,
            sum(qt) numitens
     from 
           pcpedi
     where  to_date(data,'dd-MM-yyyy')>=to_date(:DTINICIO,'dd-MM-yyyy') and to_date(data,'dd-MM-yyyy')<=to_date(:DTFIM,'dd-MM-yyyy') 
     group by codprod,numped) iten
where
    iten.numped=p.numped and 
    to_date(data,'dd-MM-yyyy')>=to_date(:DTINICIO,'dd-MM-yyyy') and to_date(data,'dd-MM-yyyy')<=to_date(:DTFIM,'dd-MM-yyyy') 
    and p.dtcancel is null
    and p.codsupervisor = :CODSUPERVISOR 
    and codusur = :CODRCA
group by 
    p.codusur,iten.codprod
order by p.codusur,iten.codprod
