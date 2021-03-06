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
using { Z4R_TEXT_MANAGEMENT_SRV as Z4R_TEXT_MANAGEMENT_SRV } from './external/Z4R_TEXT_MANAGEMENT_SRV.csn';
using { ZPM4R_TECHNICAL_OBJECT_SRV_03 as ZPM4R_TECHNICAL_OBJECT_SRV_03 } from './external/ZPM4R_TECHNICAL_OBJECT_SRV_03.csn';
using { ZEWRKR_MASTERDATA_SRV as ZEWRKR_MASTERDATA_SRV } from './external/ZEWRKR_MASTERDATA_SRV.csn';

@cds.query.limit: { default: 5000, max: 5000 }
service CatalogService {

    entity AddressCityRa as projection on ZPM4R_TECHNICAL_OBJECT_SRV_03.AddressCityRaSet
    entity AddressNameRa as projection on ZPM4R_TECHNICAL_OBJECT_SRV_03.AddressNameRaSet
    entity AddressPostCodeRa as projection on ZPM4R_TECHNICAL_OBJECT_SRV_03.AddressPostCodeRaSet
    entity AddressSearchTerm1Ra as projection on ZPM4R_TECHNICAL_OBJECT_SRV_03.AddressSearchTerm1RaSet
    entity AddressSearchTerm2Ra as projection on ZPM4R_TECHNICAL_OBJECT_SRV_03.AddressSearchTerm2RaSet
    entity AddressStreetRa as projection on ZPM4R_TECHNICAL_OBJECT_SRV_03.AddressStreetRaSet
    entity Alkey as projection on ZPM4R_TECHNICAL_OBJECT_SRV_03.AlkeySet
    entity CategoryRa as projection on ZPM4R_TECHNICAL_OBJECT_SRV_03.CategoryRaSet
    entity CountryRa as projection on ZPM4R_TECHNICAL_OBJECT_SRV_03.CountryRaSet
    entity DescriptRa as projection on ZPM4R_TECHNICAL_OBJECT_SRV_03.DescriptRaSet
    entity FunclocList as projection on ZPM4R_TECHNICAL_OBJECT_SRV_03.FunclocListSet
    entity FunclocRa as projection on ZPM4R_TECHNICAL_OBJECT_SRV_03.FunclocRaSet
    entity Gewrk as projection on ZPM4R_TECHNICAL_OBJECT_SRV_03.GewrkSet
    entity MaintplantRa as projection on ZPM4R_TECHNICAL_OBJECT_SRV_03.MaintplantRaSet
    entity ObjecttypeRa as projection on ZPM4R_TECHNICAL_OBJECT_SRV_03.ObjecttypeRaSet
    entity PartnerRa as projection on ZPM4R_TECHNICAL_OBJECT_SRV_03.PartnerRaSet
    entity PlangroupRa as projection on ZPM4R_TECHNICAL_OBJECT_SRV_03.PlangroupRaSet
    entity PlanplantRa as projection on ZPM4R_TECHNICAL_OBJECT_SRV_03.PlanplantRaSet
    entity SortfieldRa as projection on ZPM4R_TECHNICAL_OBJECT_SRV_03.SortfieldRaSet
    entity StatusRa as projection on ZPM4R_TECHNICAL_OBJECT_SRV_03.StatusRaSet
    entity SupflocRa as projection on ZPM4R_TECHNICAL_OBJECT_SRV_03.SupflocRaSet
    entity T_CONS_AE as projection on ZPM4R_PMO_TAB_ANAG_1_SRV.T_CONS_AESet
    
    entity ListFl as projection on ZPM4R_TECHNICAL_OBJECT_SRV_03.ListFlSet{ 
        *,
        N_AddressCityRa: redirected to AddressCityRa,
        N_AddressNameRa: redirected to AddressNameRa,
        N_AddressPostCodeRa: redirected to AddressPostCodeRa,
        N_AddressSearchTerm1Ra: redirected to AddressSearchTerm1Ra,
        N_AddressSearchTerm2Ra: redirected to AddressSearchTerm2Ra,
        N_AddressStreetRa: redirected to AddressStreetRa,
        N_Alkey: redirected to Alkey,
        N_DescriptRa: redirected to DescriptRa,
        N_FunclocRa: redirected to FunclocRa,
        N_Gewrk: redirected to Gewrk,
        N_MaintplantRa: redirected to MaintplantRa,
        N_ObjecttypeRa: redirected to ObjecttypeRa,
        N_PartnerRa: redirected to PartnerRa,
        N_PlangroupRa: redirected to PlangroupRa,
        N_PlanplantRa: redirected to PlanplantRa,
        N_SortfieldRa: redirected to SortfieldRa,
        N_StatusRa: redirected to StatusRa,
        N_SupflocRa: redirected to SupflocRa,
        N_CategoryRa: redirected to CategoryRa,
        CountryRaSet: redirected to CountryRa,
        N_FunclocList: redirected to FunclocList

    };
    

    entity TOrder as projection on ZEWRKR_WORK_ORDER_SRV.TOrderSet
    entity PrintOrderOutputBin as projection on ZEWRKR_WORK_ORDER_SRV.PrintOrderOutputBinSet

    entity ShopPaper as projection on ZEWRKR_WORK_ORDER_SRV.ShopPaperSet{
        *,
        TOrderSet: redirected to TOrder,
        PrintOrderOutputBinSet: redirected to PrintOrderOutputBin,
    }




    entity Hierarchy as projection on ZEWRKR_MASTERDATA_SRV.HierarchySet
    entity Materials as projection on ZEWRKR_MASTERDATA_SRV.MaterialsSet
    entity Equipments as projection on ZEWRKR_MASTERDATA_SRV.EquipmentsSet

    entity HierarchyEquip as projection on ZEWRKR_MASTERDATA_SRV.HierarchyEquipSet{ 
        *,
        HierarchySet: redirected to Hierarchy,
        MaterialsSet: redirected to Materials,
        EquipmentsSet: redirected to Equipments
    }

    entity ErrorMessages as projection on ZEWRKR_WORK_ORDER_SRV.ErrorMessagesSet
    entity ObjectList as projection on ZEWRKR_WORK_ORDER_SRV.ObjectListSet 
    entity OperationList as projection on ZEWRKR_WORK_ORDER_SRV.OperationListSet 
    entity OrderDetails as projection on ZEWRKR_WORK_ORDER_SRV.OrderDetailsSet
    entity TextCreateOrder as projection on ZEWRKR_WORK_ORDER_SRV.TextCreateOrderSet 
    entity TUserStatus as projection on ZEWRKR_WORK_ORDER_SRV.TUserStatusSet
    entity ComponentUpdate as projection on ZEWRKR_WORK_ORDER_SRV.ComponentUpdateSet
    entity TecoUpdateOrder as projection on ZEWRKR_WORK_ORDER_SRV.TecoUpdateOrderSet
    entity NotifToOdm as projection on ZEWRKR_WORK_ORDER_SRV.NotifToOdmSet

    entity CreateOrder as projection on ZEWRKR_WORK_ORDER_SRV.CreateOrderSet{ //POST
        *,
        ErrorMessagesSet: redirected to ErrorMessages,
        ObjectListSet: redirected to ObjectList,
        OperationListSet: redirected to OperationList,
        OrderDetailsSet: redirected to OrderDetails,
        TextCreateOrderSet: redirected to TextCreateOrder,
        TUserStatusSet: redirected to TUserStatus
    };
    entity UpdateOrder as projection on ZEWRKR_WORK_ORDER_SRV.UpdateOrderSet{ //POST
        *,
        OperationListSet: redirected to OperationList,
        OrderDetailsSet: redirected to OrderDetails,
        TextCreateOrderSet: redirected to TextCreateOrder,
        ComponentUpdateSet: redirected to ComponentUpdate,
        TecoUpdateOrderSet: redirected to TecoUpdateOrder,
        ErrorMessagesSet: redirected to ErrorMessages,
        ObjectListSet: redirected to ObjectList,
        NotifToOdmSet: redirected to NotifToOdm
    };

    
    entity ConfirmCreate as projection on ZEWRKR_WORK_ORDER_SRV.ConfirmCreateSet //GET
    entity GetOMList as projection on ZEWRKR_WORK_ORDER_SRV.GetOMListSet 
    
    
    entity GetOperationList  as projection on ZEWRKR_WORK_ORDER_SRV.GetOperationListSet
    entity GetOrderText  as projection on ZEWRKR_WORK_ORDER_SRV.GetOrderTextSet
    entity IRev  as projection on ZEWRKR_WORK_ORDER_SRV.IRevSet
    entity IVaplz  as projection on ZEWRKR_WORK_ORDER_SRV.IVaplzSet
    entity OrderHeader  as projection on ZEWRKR_WORK_ORDER_SRV.OrderHeaderSet
    entity SedTechRG  as projection on ZEWRKR_WORK_ORDER_SRV.SedTechRGSet
    entity StsistemRG  as projection on ZEWRKR_WORK_ORDER_SRV.StsistemRGSet
    entity SystemStatus  as projection on ZEWRKR_WORK_ORDER_SRV.SystemStatusSet
    entity WorkCntr  as projection on ZEWRKR_WORK_ORDER_SRV.WorkCntrSet

    entity GetOrder as projection on ZEWRKR_WORK_ORDER_SRV.GetOrderSet { //POST
        *,
        GetOperationListSet: redirected to GetOperationList,
        GetOrderTextSet: redirected to GetOrderText,
        IRevSet: redirected to IRev,
        IVaplzSet: redirected to IVaplz,
        OrderHeaderSet: redirected to OrderHeader,
        SedTechRGSet: redirected to SedTechRG,
        StsistemRGSet: redirected to StsistemRG,
        SystemStatusSet: redirected to SystemStatus,
        WorkCntrSet: redirected to WorkCntr
    }

    entity ErrorMessagesN as projection on ZEWRKR_NOTIFICATION_SRV.ErrorMessagesSet
    entity KeyRelationships as projection on ZEWRKR_NOTIFICATION_SRV.KeyRelationshipsSet
    entity LongTexts as projection on ZEWRKR_NOTIFICATION_SRV.LongTextsSet
    entity NotifActv as projection on ZEWRKR_NOTIFICATION_SRV.NotifActvSet
    entity NotifItemCreate as projection on ZEWRKR_NOTIFICATION_SRV.NotifItemCreateSet
    entity NotifPartners as projection on ZEWRKR_NOTIFICATION_SRV.NotifPartnersSet
    entity NotifPartnrCheckDuplication as projection on ZEWRKR_NOTIFICATION_SRV.NotifPartnrCheckDuplicationSet
    entity NotifTask as projection on ZEWRKR_NOTIFICATION_SRV.NotifTaskSet
    entity UserStatus as projection on ZEWRKR_NOTIFICATION_SRV.UserStatusSet
    entity INoco as projection on ZEWRKR_NOTIFICATION_SRV.INocoSet
    entity NotifActDelete as projection on ZEWRKR_NOTIFICATION_SRV.NotifActDeleteSet
    entity NotifItemDelete as projection on ZEWRKR_NOTIFICATION_SRV.NotifItemDeleteSet
    entity NotifItemUpd as projection on ZEWRKR_NOTIFICATION_SRV.NotifItemUpdSet
    entity TUserStatusN as projection on ZEWRKR_NOTIFICATION_SRV.TUserStatusSet

    entity GetNotification as projection on ZEWRKR_NOTIFICATION_SRV.GetNotificationSet 
    entity CreateNotification as projection on ZEWRKR_NOTIFICATION_SRV.CreateNotificationSet { //POST
        *,
        ErrorMessagesSet: redirected to ErrorMessagesN,
        KeyRelationshipsSet: redirected to KeyRelationships,
        LongTextsSet: redirected to LongTexts,
        NotifActvSet: redirected to NotifActv,
        NotifItemCreateSet: redirected to NotifItemCreate,
        NotifPartnersSet: redirected to NotifPartners,
        NotifPartnrCheckDuplicationSet: redirected to NotifPartnrCheckDuplication,
        NotifTaskSet: redirected to NotifTask,
        UserStatusSet: redirected to UserStatus
    };
    entity UpdateNotification as projection on ZEWRKR_NOTIFICATION_SRV.UpdateNotificationSet { //POST
        *,
        ErrorMessagesSet: redirected to ErrorMessagesN,
        INocoSet: redirected to INoco,
        LongTextsSet: redirected to LongTexts,
        NotifActvSet: redirected to NotifActv,
        NotifActDeleteSet: redirected to NotifActDelete,
        NotifItemDeleteSet: redirected to NotifItemDelete,
        NotifItemUpdSet: redirected to NotifItemUpd,
        TUserStatusSet: redirected to TUserStatusN
    };

    entity StorageList as projection on Z4R_SEARCH_HELP_SRV.StorageListSet
    entity ReturnError as projection on Z4R_SEARCH_HELP_SRV.ReturnErrorSet
    entity ReturnTabDesc as projection on Z4R_SEARCH_HELP_SRV.ReturnTabDescSet
    entity ReturnTabValue as projection on Z4R_SEARCH_HELP_SRV.ReturnTabValueSet
    entity ReturnFieldValue as projection on Z4R_SEARCH_HELP_SRV.ReturnFieldValueSet
    entity IFilterData as projection on Z4R_SEARCH_HELP_SRV.IFilterDataSet
    
    entity dySearch as projection on Z4R_SEARCH_HELP_SRV.DynamicSearchHelpSet{
        *,
        ReturnErrorSet: redirected to ReturnError,
        ReturnTabDescSet: redirected to ReturnTabDesc,
        ReturnTabValueSet: redirected to ReturnTabValue,
        ReturnFieldValueSet: redirected to ReturnFieldValue,
        IFilterDataSet: redirected to IFilterData

    };

    entity Odm as projection on ZPM4R_PMO_ODM_SRV.OdmSet
    entity SAzione as projection on ZPM4R_PMO_ODM_SRV.SAzioneSet
    entity SCentroLavoro as projection on ZPM4R_PMO_ODM_SRV.SCentroLavoroSet
    entity SClasse as projection on ZPM4R_PMO_ODM_SRV.SClasseSet
    entity SDesComponente as projection on ZPM4R_PMO_ODM_SRV.SDesComponenteSet
    entity SDestinatario as projection on ZPM4R_PMO_ODM_SRV.SDestinatarioSet
    entity SDivisioneu as projection on ZPM4R_PMO_ODM_SRV.SDivisioneuSet
    entity SEquipmentCompo as projection on ZPM4R_PMO_ODM_SRV.SEquipmentCompoSet
    entity SIndexPmo as projection on ZPM4R_PMO_ODM_SRV.SIndexPmoSet
    entity SIndisponibilita as projection on ZPM4R_PMO_ODM_SRV.SIndisponibilitaSet
    entity SPercorso as projection on ZPM4R_PMO_ODM_SRV.SPercorsoSet
    entity SPltxu as projection on ZPM4R_PMO_ODM_SRV.SPltxuSet
    entity SProgres as projection on ZPM4R_PMO_ODM_SRV.SProgresSet
    entity SSistema as projection on ZPM4R_PMO_ODM_SRV.SSistemaSet
    entity SStrno as projection on ZPM4R_PMO_ODM_SRV.SStrnoSet
    entity STipoAttivita as projection on ZPM4R_PMO_ODM_SRV.STipoAttivitaSet
    entity STipoGestione1 as projection on ZPM4R_PMO_ODM_SRV.STipoGestione1Set
    entity STipoGestione2 as projection on ZPM4R_PMO_ODM_SRV.STipoGestione2Set
    entity STipoGestione as projection on ZPM4R_PMO_ODM_SRV.STipoGestioneSet
    entity STipoOrdine as projection on ZPM4R_PMO_ODM_SRV.STipoOrdineSet
    entity STipoPmo as projection on ZPM4R_PMO_ODM_SRV.STipoPmoSet

    entity TestiEstesi as projection on Z4R_TEXT_MANAGEMENT_SRV.TestiEstesiSet
    entity TestiEstesiDelete as projection on Z4R_TEXT_MANAGEMENT_SRV.TestiEstesiDeleteSet

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
    entity JoinPMO as projection on ZPM4R_PMO_MASTERDATA_SRV.JoinPMOSet{
        *,
        T_PMOSet: redirected to T_PMO,
        T_ACT_ELSet: redirected to T_ACT_EL,
        T_PMO_MSet: redirected to T_PMO_M,
        T_PMO_SSet: redirected to T_PMO_S
    };    

    entity T_PMO as projection on ZPM4R_PMO_MASTERDATA_SRV.T_PMOSet{
        *,
        JoinPMO: redirected to JoinPMO,
        T_ACT_ELSet: redirected to T_ACT_EL,
        T_PMO_MSet: redirected to T_PMO_M,
        T_PMO_SSet: redirected to T_PMO_S
    };    
    
    entity Materiali as projection on my.Materiali;
    entity Servizi as projection on my.Servizi;
    entity AzioniMateriali as projection on my.AzioniMateriali;
    entity AzioniServizi as projection on my.AzioniServizi;
    
    entity Strategia as projection on my.StrategiaT;
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

