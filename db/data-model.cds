namespace my.entity;

entity Books {
  key ID : Integer;
  title  : String;
  stock  : Integer;
}

entity Strategia {
    key STARTEGIA:String(30);
    STRATEGIA_DESC:String(50);
}

entity Sede {
    key SEDE_TECNICA:String(1);
    key LIVELLO1:String(3);
    key LIVELLO2:String(4);
    key LIVELLO3:String(2);
    key LIVELLO4:String(2);
    key LIVELLO5:String(2);
    key LIVELLO6:String(2);
    DESC_SEDE:String(30);
}

entity Azioni {
    key INDEX:Decimal(12);
    key CONTATORE:Decimal(10);
    DATA_MODIFICA:Date;
    SISTEMA:String(2);
    PROGRES:Decimal(5);
    CLASSE:String(2);
    DES_COMPONENTE:String(80);
}

entity Index {
    key INDEX:Decimal(12);
    STARTEGIA:String(30);
    STRATEGIA_DESC:String(50);
    SEDE_TECNICA:String(1);
    DIVISIONE:String(4);
    LIVELLO1:String(3);
    LIVELLO2:String(4);
    LIVELLO3:String(2);
    LIVELLO4:String(3);
    LIVELLO5:String(2);
    LIVELLO6:String(2);
    DESC_SEDE:String(30);
    CLASSE_SEDE:Decimal(10);
    CARATT_SEDE:Decimal(10);
    OGGETTO_TECNICO:String(10);
    PROFILO:String(9);
    ZBAU:String(10);
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
    PROGRES_PMO:Decimal(5);
    CLASSE_PMO:String(2);
    TIPO_GESTIONE:String(3);
    TIPO_GESTIONE_1:String(3);
    TIPO_GESTIONE_2:String(3);
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
}

entity Index_Azione as SELECT from Index inner JOIN Azioni on Index.INDEX=Azioni.INDEX {
    Index.INDEX,
    Index.STARTEGIA,
    Index.STRATEGIA_DESC,
    Index.SEDE_TECNICA,
    Index.DIVISIONE,
    Index.LIVELLO1,
    Index.LIVELLO2,
    Index.LIVELLO3,
    Index.LIVELLO4,
    Index.LIVELLO5,
    Index.LIVELLO6,
    Index.DESC_SEDE,
    Index.CLASSE_SEDE,
    Index.CARATT_SEDE,
    Index.OGGETTO_TECNICO,
    Index.PROFILO,
    Index.ZBAU,
    Index.DIVISIONEC,
    Index.CENTRO_LAVORO,
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
    Index.PRIORITA,
    Index.DESTINATARIO,
    Index.TESTO_ESTESO,
    Index.SISTEMA_PMO,
    Index.PROGRES_PMO,
    Index.CLASSE_PMO,
    Index.TIPO_GESTIONE,
    Index.TIPO_GESTIONE_1,
    Index.TIPO_GESTIONE_2,
    Index.RISK,
    Index.POINT,
    Index.MPTYP,
    Index.LIMITE,
    Index.FREQ_TEMPO,
    Index.UNITA_TEMPO,
    Index.FREQ_CICLO,
    Index.UNITA_CICLO,
    Index.FREQ_RISK,
    Index.UNITA_RISK,
    Index.LIMITE2,
    Azioni.CONTATORE,
    Azioni.DATA_MODIFICA,
    Azioni.SISTEMA,
    Azioni.PROGRES,
    Azioni.CLASSE,
    Azioni.DES_COMPONENTE
} order by Index.INDEX desc;