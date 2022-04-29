using my.entity as my from '../db/data-model';

using { managed, cuid } from '@sap/cds/common';

using { ZEWRKR_WORK_ORDER_SRV as ZEWRKR_WORK_ORDER_SRV } from './external/ZEWRKR_WORK_ORDER_SRV.csn';
using { ZEWRKR_NOTIFICATION_SRV as ZEWRKR_NOTIFICATION_SRV } from './external/ZEWRKR_NOTIFICATION_SRV.csn';
using { ZPM4R_PMO_MASTERDATA_SRV as ZPM4R_PMO_MASTERDATA_SRV } from './external/ZPM4R_PMO_MASTERDATA_SRV.csn';
using { Z4R_SEARCH_HELP_SRV as Z4R_SEARCH_HELP_SRV } from './external/Z4R_SEARCH_HELP_SRV.csn';
using { ZPM4R_PMO_TAB_ANAG_1_SRV as ZPM4R_PMO_TAB_ANAG_1_SRV } from './external/ZPM4R_PMO_TAB_ANAG_1_SRV.csn';
using { ZPM4R_PMO_TAB_ANAG_2_SRV as ZPM4R_PMO_TAB_ANAG_2_SRV } from './external/ZPM4R_PMO_TAB_ANAG_2_SRV.csn';
using { ZPM4R_PMO_TAB_ANAG_3_SRV as ZPM4R_PMO_TAB_ANAG_3_SRV } from './external/ZPM4R_PMO_TAB_ANAG_3_SRV.csn';
using { ZPM4R_PMO_TAB_ANAG_4_SRV as ZPM4R_PMO_TAB_ANAG_4_SRV } from './external/ZPM4R_PMO_TAB_ANAG_4_SRV.csn';


service CatalogService {

    entity ReturnError as projection on Z4R_SEARCH_HELP_SRV.ReturnErrorSet
    entity ReturnTabDesc as projection on Z4R_SEARCH_HELP_SRV.ReturnTabDescSet
    entity ReturnTabValue as projection on Z4R_SEARCH_HELP_SRV.ReturnTabValueSet
    entity ReturnFieldValue as projection on Z4R_SEARCH_HELP_SRV.ReturnFieldValueSet
    
    entity dySearch as projection on Z4R_SEARCH_HELP_SRV.DynamicSearchHelpSet{
        *,
        ReturnErrorSet: redirected to ReturnError,
        ReturnTabDescSet: redirected to ReturnTabDesc,
        ReturnTabValueSet: redirected to ReturnTabValue,
        ReturnFieldValueSet: redirected to ReturnFieldValue
    };

    entity T_DEST as projection on ZPM4R_PMO_TAB_ANAG_2_SRV.T_DESTSet
    entity T_RAGGR as projection on ZPM4R_PMO_TAB_ANAG_2_SRV.T_RAGGRSet
   

    entity T_ACT_EL as projection on ZPM4R_PMO_MASTERDATA_SRV.T_ACT_ELSet
    entity T_PMO_M as projection on ZPM4R_PMO_MASTERDATA_SRV.T_PMO_MSet
    entity T_PMO_S as projection on ZPM4R_PMO_MASTERDATA_SRV.T_PMO_SSet

    entity T_PMO as projection on ZPM4R_PMO_MASTERDATA_SRV.T_PMOSet{
        *,
        T_ACT_ELSet: redirected to T_ACT_EL,
        T_PMO_MSet: redirected to T_PMO_M,
        T_PMO_SSet: redirected to T_PMO_S
    };


    
    entity Strategia as projection on my.Strategia;
    entity Sede as projection on my.SedeTecnica;
    entity Azioni as projection on my.Azioni;
    entity Index as projection on my.Index;
    entity Index_Azioni as projection on my.Index_Azioni;
    entity SedeDistinct as projection on my.SedeTecnica;
    entity Variante as projection on my.Variante;

    @cds.persistence.skip @readonly entity shEQART {
        key EQART: String(10);
        EARTX: String(40);
        SPRAS: String(1);
    };

    @cds.persistence.skip @readonly entity shDIVISIONEC {
        key WERKS: String(4);
        NAME1: String(40);
    };

    @cds.persistence.skip @readonly entity shCENTRO_LAVORO {
        key DESTINATARIO: String(12);
        ARBPL: String(8);
        WERKS: String(4);
        TXT: String(60);
        RAGGRUPPAMENTO: String(10);
    };

    @cds.persistence.skip @readonly entity shPOINT {
        POINT: String(12);
        PSORT: String(20);
        PTTXT: String(40);
        MPTYP: String(1);
        IRFMP: String(1);
        INDCT: String(1);
    };

    @cds.persistence.skip @readonly entity shTIPO_ATTIVITA {
        key LSTAR: String(6); 
        KOKRS: String(4); 
        MCTXT: String(20); 
        SPRAS: String(1); 
        DATAB: Date; 
        DATBI: Date;                
    };

    @cds.persistence.skip @readonly entity shTIPO_ORDINE {
        key AUART: String(4); 
        AUTYP: Decimal(2); 
        TXT: String(40); 
    };
}

