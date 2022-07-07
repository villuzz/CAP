namespace my.entity;

using { managed, cuid } from '@sap/cds/common';

entity Books {
  key ID : Integer;
  title  : String;
  stock  : Integer;
}

entity StrategiaT : managed {
    key STRATEGIA:String(30);
    STRATEGIA_DESC:String(50);
}

entity Variante {
    key APP:String(1);
    key TABLE:String(40);
    key USER:String(7);
    key NAME:String(20);
    COLUMN:String;
    FILTER:String;
}

entity Materiali {
    key MATNR:String(18);
    MAKTX:String(40);
    MENGE:Decimal(16);
    MEINS:String(3);
}

entity Servizi {
    key ASNUM:String(18);
    ASKTX:String(40);
    MENGE:Decimal(16);
    MEINS:String(3);
}
entity AzioniMateriali {
    key INDEX : Integer;
    key CONTATORE: Integer;    
    key MATNR:String(18);
    MAKTX:String(40);
    MENGE:Decimal(16);
    MEINS:String(3);
}

entity AzioniServizi {
    key INDEX : Integer;
    key CONTATORE: Integer;
    key ASNUM:String(18);
    ASKTX:String(40);
    MENGE:Decimal(16);
    MEINS:String(3);
}

entity SedeTecnica {
    key SEDE_TECNICA:String(1);
    key LIVELLO1:String(3);
    key LIVELLO2:String(4);
    key LIVELLO3:String(2);
    key LIVELLO4:String(3);
    key LIVELLO5:String(3);
    key LIVELLO6:String(2);
    key LANGUAGE:String(2);
    DESC_SEDE:String(150);
    NOTE:String(150);
}
entity Azioni : managed, cuid {
    key ID : UUID;
    key CONTATORE: Integer;
    INDEX : Integer;
    SISTEMA:String(2);
    PROGRES:String(5);
    DESC_PROG:String(40);
    CLASSE:String(2);
    DES_COMPONENTE:String(80);
    DIVISIONE:String(4);
    SEDE_TECNICA:String(1);
    LIVELLO1:String(3);
    LIVELLO2:String(4);
    LIVELLO3:String(2);
    LIVELLO4:String(3);
    LIVELLO5:String(2);
    LIVELLO6:String(2);
    DESC_SEDE:String(150);
    EQUIPMENT:String(18);

    CLASSE_SEDE:String(30);
    CARATT_SEDE:String(30);
    OGGETTO_TECNICO:String(10);
    PROFILO:String(9);
    ZBAU:String(10);
    VALORE:String(30);

    //MATNR:String(18);
    //ASNUM:String(18);

    TESTO_ESTESO_P:String;
    ATTIVO:Boolean default true;
}


entity Index : managed, cuid {
    key ID : UUID;
    INDEX : Integer;
    ID_STRATEGIA : Integer;
    STRATEGIA:String(30);
    STRATEGIA_DESC:String(50);
    DIVISIONEC:String(4);
    CENTRO_LAVORO:String(8);
    LSTAR:String(6);
    STEUS:String(4);
    NUM:String(3);
    PERSONE:String(3);
    HPER:String(5);
    LSTAR_1:String(6);
    STEUS_1:String(4);
    NUM_1:String(3);
    PERSONE_1:String(3);
    HPER_1:String(5);
    LSTAR_2:String(6);
    STEUS_2:String(4);
    NUM_2:String(3);
    PERSONE_2:String(3);
    HPER_2:String(5);
    LSTAR_3:String(6);
    STEUS_3:String(4);
    NUM_3:String(3);
    PERSONE_3:String(3);
    HPER_3:String(5);
    LSTAR_4:String(6);
    STEUS_4:String(4);
    NUM_4:String(3);
    PERSONE_4:String(3);
    HPER_4:String(5);
    LSTAR_5:String(6);
    STEUS_5:String(4);
    NUM_5:String(3);
    PERSONE_5:String(3);
    HPER_5:String(5);
    PRIORITA:Decimal(1);
    DESTINATARIO:String(12);
    TESTO_ESTESO:String;
    SISTEMA_PMO:String(2);
    PROGRES_PMO:String(5);
    CLASSE_PMO:String(2);
    TIPO_GESTIONE:String(3);
    TIPO_GESTIONE_1:String(3);
    TIPO_GESTIONE_2:String(3);
    TIPOFREQUENZA:String(1);
    RISK:String(1);
    POINT:String(12);
    MPTYP:String(1);
    LIMITE:String(22);
    FREQ_TEMPO:Decimal(4);
    UNITA_TEMPO:String(3);
    FREQ_CICLO:Decimal(4);
    UNITA_CICLO:String(3);
    FREQ_RISK:Decimal(4);
    UNITA_RISK:String(3);
    LIMITE2:String(22);
    TIPO_ATTIVITA:String(3);
    DESC_BREVE:String;
    INDISPONIBILITA:String(1);
    TIPO_ORDINE:String(4);
    AZIONE:Integer;
    RIFERIMENTO:Integer;

}

entity Index_Azioni as SELECT from Index LEFT OUTER JOIN Azioni on Index.ID=Azioni.ID {
    key Index.ID,
    key Azioni.CONTATORE, //posizione
    Index.INDEX,

    Index.ID_STRATEGIA,
    Index.STRATEGIA,
    Index.STRATEGIA_DESC,
    Index.DIVISIONEC,
    Index.CENTRO_LAVORO,
    Index.TIPO_GESTIONE,
    Index.TIPO_GESTIONE_1,
    Index.TIPO_GESTIONE_2,

    Index.PRIORITA,
    Index.TIPO_ATTIVITA,
    Index.DESC_BREVE,
    Index.TESTO_ESTESO,
    Index.INDISPONIBILITA,
    Index.TIPO_ORDINE,
    
    Index.LSTAR,
    Index.STEUS,
    Index.NUM,
    Index.PERSONE,
    Index.HPER,

    Index.LSTAR_1,
    Index.STEUS_1,
    Index.NUM_1,
    Index.PERSONE_1,
    Index.HPER_1,

    Index.LSTAR_2,
    Index.STEUS_2,
    Index.NUM_2,
    Index.PERSONE_2,
    Index.HPER_2,

    Index.LSTAR_3,
    Index.STEUS_3,
    Index.NUM_3,
    Index.PERSONE_3,
    Index.HPER_3,

    Index.LSTAR_4,
    Index.STEUS_4,
    Index.NUM_4,
    Index.PERSONE_4,
    Index.HPER_4,

    Index.LSTAR_5,
    Index.STEUS_5,
    Index.NUM_5,
    Index.PERSONE_5,
    Index.HPER_5,

    Index.RISK,
    Index.LIMITE,
    Index.FREQ_TEMPO,
    Index.UNITA_TEMPO,
    Index.FREQ_CICLO,
    Index.UNITA_CICLO,

    Index.POINT,
    Index.MPTYP, 
    Index.TIPOFREQUENZA,

    Index.AZIONE,
    Index.RIFERIMENTO,
    Index.DESTINATARIO,
    
    //posizione
    Azioni.ATTIVO,
    Azioni.SISTEMA,
    Azioni.PROGRES,
    Azioni.DESC_PROG,
    Azioni.CLASSE,
    Azioni.DES_COMPONENTE,
    Azioni.DIVISIONE,
    Azioni.SEDE_TECNICA,
    Azioni.LIVELLO1,
    Azioni.LIVELLO2,
    Azioni.LIVELLO3,
    Azioni.LIVELLO4,
    Azioni.LIVELLO5,
    Azioni.LIVELLO6,
    Azioni.DESC_SEDE,
    Azioni.EQUIPMENT,
    Azioni.TESTO_ESTESO_P,

    Azioni.CLASSE_SEDE,
    Azioni.CARATT_SEDE,
    Azioni.OGGETTO_TECNICO,
    Azioni.PROFILO,
    Azioni.ZBAU,
    Azioni.VALORE,

    //Azioni.MATNR,
    //Azioni.ASNUM
    
} order by Index.INDEX desc, Azioni.CONTATORE desc ;