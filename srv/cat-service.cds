using my.entity as my from '../db/data-model';

using { ZEWRKR_WORK_ORDER_SRV as ZEWRKR_WORK_ORDER_SRV } from './external/ZEWRKR_WORK_ORDER_SRV.csn';
using { ZEWRKR_NOTIFICATION_SRV as ZEWRKR_NOTIFICATION_SRV } from './external/ZEWRKR_NOTIFICATION_SRV.csn';

service CatalogService {

    //Test    
    entity Books as projection on my.Books;

    entity Strategia as projection on my.Strategia;
    entity Sede as projection on my.Sede;
    entity Azioni as projection on my.Azioni;
    entity Index as projection on my.Index;
    entity Index_Azione as projection on my.Index_Azione;

    entity SedeTecnica as select from Sede distinct { key SEDE_TECNICA }; 
    entity LIVELLO1 as select distinct * from my.Sede ; 

    
//  entity OrderListSet as projection on ZEWRKR_WORK_ORDER_SRV.OrderListSet;

//  entity OrderHeaderSet as projection on ZEWRKR_WORK_ORDER_SRV.OrderHeaderSet{
//        *,
//        GetOrder: redirected to ZEWRKR_WORK_ORDER_SRV.GetOrderSet
//    };

}

