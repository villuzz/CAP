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
using { ZPM4R_PMO_ODM_SRV as ZPM4R_PMO_ODM_SRV } from './external/ZPM4R_PMO_ODM_SRV.csn';


@cds.query.limit: { default: 4000, max: 4000 }
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

    entity Odm as projection on ZPM4R_PMO_ODM_SRV.OdmSet
    entity SAzione as projection on ZPM4R_PMO_ODM_SRV.SAzioneSet
    entity SCentroLavoro as projection on ZPM4R_PMO_ODM_SRV.SCentroLavoroSet
    entity SClasse as projection on ZPM4R_PMO_ODM_SRV.SClasseSet
    entity SDesComponente as projection on ZPM4R_PMO_ODM_SRV.SDesComponenteSet
    entity SDestinatario as projection on ZPM4R_PMO_ODM_SRV.SDestinatarioSet
    entity SDivisioneu as projection on ZPM4R_PMO_ODM_SRV.SDivisioneuSet
    entity SEquipmentCompo as projection on ZPM4R_PMO_ODM_SRV.SEquipmentCompoSet
    entity SIndexPmo as projection on ZPM4R_PMO_ODM_SRV.SIndexPmoSet
    entity SIndisponibilita as projection on ZPM4R_PMO_ODM_SRV.SIndisponibilitaSet
    entity SPercorso as projection on ZPM4R_PMO_ODM_SRV.SPercorsoSet
    entity SPltxu as projection on ZPM4R_PMO_ODM_SRV.SPltxuSet
    entity SProgres as projection on ZPM4R_PMO_ODM_SRV.SProgresSet
    entity SSistema as projection on ZPM4R_PMO_ODM_SRV.SSistemaSet
    entity SStrno as projection on ZPM4R_PMO_ODM_SRV.SStrnoSet
    entity STipoAttivita as projection on ZPM4R_PMO_ODM_SRV.STipoAttivitaSet
    entity STipoGestione1 as projection on ZPM4R_PMO_ODM_SRV.STipoGestione1Set
    entity STipoGestione2 as projection on ZPM4R_PMO_ODM_SRV.STipoGestione2Set
    entity STipoGestione as projection on ZPM4R_PMO_ODM_SRV.STipoGestioneSet
    entity STipoOrdine as projection on ZPM4R_PMO_ODM_SRV.STipoOrdineSet
    entity STipoPmo as projection on ZPM4R_PMO_ODM_SRV.STipoPmoSet

    entity GetODM as projection on ZPM4R_PMO_ODM_SRV.GetODMSet{
        *,
        Odm: redirected to Odm,
        SAzione: redirected to SAzione,
        SCentroLavoro: redirected to SCentroLavoro,
        SClasse: redirected to SClasse,
        SDesComponente: redirected to SDesComponente,
        SDestinatario: redirected to SDestinatario,
        SDivisioneu: redirected to SDivisioneu,
        SEquipmentCompo: redirected to SEquipmentCompo,
        SIndexPmo: redirected to SIndexPmo,
        SIndisponibilita: redirected to SIndisponibilita,
        SPercorso: redirected to SPercorso,
        SPltxu: redirected to SPltxu,
        SProgres: redirected to SProgres,
        SSistema: redirected to SSistema,
        SStrno: redirected to SStrno,
        //STipoAttivita: redirected to STipoAttivita,
        STipoGestione1: redirected to STipoGestione1,
        STipoGestione2: redirected to STipoGestione2,
        STipoGestione: redirected to STipoGestione,
        STipoOrdine: redirected to STipoOrdine,
        STipoPmo: redirected to STipoPmo
    };


    entity T_DEST as projection on ZPM4R_PMO_TAB_ANAG_2_SRV.T_DESTSet
    entity T_DEST_USR as projection on ZPM4R_PMO_TAB_ANAG_2_SRV.T_DEST_USRSet
    entity T_RAGGR as projection on ZPM4R_PMO_TAB_ANAG_2_SRV.T_RAGGRSet

    entity T_ACT_PROG as projection on ZPM4R_PMO_TAB_ANAG_2_SRV.T_ACT_PROGSet
    entity T_TP_MAN as projection on ZPM4R_PMO_TAB_ANAG_3_SRV.T_TP_MANSet
    entity T_TP_MAN1 as projection on ZPM4R_PMO_TAB_ANAG_3_SRV.T_TP_MAN1Set
    entity T_TP_MAN2 as projection on ZPM4R_PMO_TAB_ANAG_3_SRV.T_TP_MAN2Set
    entity T_ACT_SYST as projection on ZPM4R_PMO_TAB_ANAG_4_SRV.T_ACT_SYSTSet
    entity T_ACT_CL as projection on ZPM4R_PMO_TAB_ANAG_4_SRV.T_ACT_CLSet
    entity T_ACT_TYPE as projection on ZPM4R_PMO_TAB_ANAG_1_SRV.T_ACT_TYPESet
    entity T_ATTPM as projection on ZPM4R_PMO_TAB_ANAG_4_SRV.T_ATTPMSet
    entity T_AGGREG as projection on ZPM4R_PMO_TAB_ANAG_4_SRV.T_AGGREGSet
    entity T_APP_WO as projection on ZPM4R_PMO_TAB_ANAG_1_SRV.T_APP_WOSet

    entity T_ACT_EL as projection on ZPM4R_PMO_MASTERDATA_SRV.T_ACT_ELSet
    entity T_PMO_M as projection on ZPM4R_PMO_MASTERDATA_SRV.T_PMO_MSet
    entity T_PMO_S as projection on ZPM4R_PMO_MASTERDATA_SRV.T_PMO_SSet
    

    entity T_PMO as projection on ZPM4R_PMO_MASTERDATA_SRV.T_PMOSet{
        *,
        T_ACT_ELSet: redirected to T_ACT_EL,
        T_PMO_MSet: redirected to T_PMO_M,
        T_PMO_SSet: redirected to T_PMO_S
    };    
    
    entity Materiali as projection on my.Materiali;
    entity Servizi as projection on my.Servizi;
    entity AzioniMateriali as projection on my.AzioniMateriali;
    entity AzioniServizi as projection on my.AzioniServizi;
    
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

