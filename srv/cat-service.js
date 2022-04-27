const cds = require('@sap/cds');
const _ = require('underscore');
const LOG = cds.log('catalog-service');
//const Promise = require('bluebird');

module.exports = cds.service.impl(async function () {
    cds.env.features.fetch_csrf = true;
    const db = await cds.connect.to('db');
    const serviceT_PMO = await cds.connect.to('ZPM4R_PMO_MASTERDATA_SRV');
    const serviceSearch = await cds.connect.to('Z4R_SEARCH_HELP_SRV');
    const serviceORDER = await cds.connect.to('ZEWRKR_WORK_ORDER_SRV');

    const serviceANAG_1 = await cds.connect.to('ZPM4R_PMO_TAB_ANAG_1_SRV');
    const serviceANAG_2 = await cds.connect.to('ZPM4R_PMO_TAB_ANAG_2_SRV');
    const serviceANAG_3 = await cds.connect.to('ZPM4R_PMO_TAB_ANAG_3_SRV');
    const serviceANAG_4 = await cds.connect.to('ZPM4R_PMO_TAB_ANAG_4_SRV');
    
    const BATCH_SIZE = 50;
    const ERROR_CODE = 460;
    const CONSOLE_LOG = false;
    var that = this;
    
    
    const { T_PMO } = this.entities;
    this.before('READ', T_PMO , request =>{
        try {

            if (!Array.isArray(request.query.SELECT.columns)) {
                request.query.SELECT.columns = [];
            }
            
            request.query.SELECT.columns = ['*', {ref:['T_ACT_ELSet'], expand:['*']}, 
                                                 {ref:['T_PMO_MSet'], expand:['*']}, 
                                                 {ref:['T_PMO_SSet'], expand:['*']}];

          } catch (error) {
            return save_log2(request, error);
          }
    });

    this.on('READ', T_PMO, async request => {
        try {
            let response = await serviceT_PMO.tx(request).run(request.query);
            return response;
        } catch (error) {
            return save_log(request, error);
        }
	});

    this.on('CREATE', T_PMO, async request => {
        try {
            let response = await serviceT_PMO.tx(request).run(request.query);
            return response;
        } catch (error) {
            return save_log(request, error);
        }
	});

    this.on('DELETE', T_PMO, async request => {
        try {
            let response = await serviceT_PMO.tx(request).run(request.query);
            return response;
        } catch (error) {
            return save_log(request, error);
        }
	});

    this.on('UPDATE', T_PMO, async request => {
        try {
            let response = await serviceT_PMO.tx(request).run(request.query);
            return response;
        } catch (error) {
            return save_log(request, error);
        }
	});

    const { T_DEST } = this.entities;
    this.on('READ', T_DEST, async request => {
        try {
            let response = await serviceANAG_2.tx(request).run(request.query);
            return response;
        } catch (error) {
            return save_log(request, error);
        }
	});

    this.on('CREATE', T_DEST, async request => {
        try {
            let response = await serviceANAG_2.tx(request).run(request.query);
            return response;
        } catch (error) {
            return save_log(request, error);
        }
	});

    this.on('DELETE', T_DEST, async request => {
        try {
            let response = await serviceANAG_2.tx(request).run(request.query);
            return response;
        } catch (error) {
            return save_log(request, error);
        }
	});

    this.on('UPDATE', T_DEST, async request => {
        try {
            let response = await serviceANAG_2.tx(request).run(request.query);
            return response;
        } catch (error) {
            return save_log(request, error);
        }
	});

    const convertDynamicFilter = (req) => {
        let ExtractionGrouped = _.groupBy( req, ele => ele.Recordpos );
        let Extraction = [];
        let oData = {};
        Object.keys(ExtractionGrouped).forEach(ele => {
            let element = ExtractionGrouped[ele];
            element.forEach(row => {
                oData[row.Fieldname] = row.Fieldval;
            });
            Extraction.push(oData);
            oData = {};
        });        
        return Extraction;
    }

    const { dySearch } = this.entities;
    this.before('READ', dySearch, request => {
        if (!Array.isArray(request.query.SELECT.columns)) {
            request.query.SELECT.columns = [];
        }
        request.query.SELECT.columns.push({ ref: ['ReturnFieldValueSet'], expand: ['*'] });
    });

    this.on('READ', dySearch, async request => {
        try {
            let response = await serviceSearch.tx(request).run(request.query);
            return response;
        } catch (error) {
            return save_log(request, error);
        }
	});

    const { shEQART } = this.entities;
    this.on('READ', shEQART, async request => {
        let CQN = {
            SELECT:{
                columns: [{ ref: ['ReturnTabValueSet'], expand: ['*'] }],
                from: {ref: ['CatalogService.dySearch']},
                where: [{ref:["ShplType"]}, "=", {val:'SH'} , 'and', {ref:["ShplName"]}, "=", {val:'EHFND_ELM_EQART_T370K'}],
                orderBy: [{ref: ['ShplName'], sort: ['asc']}],
            }
        };

        try {
            /* //Metodo Alternativo per la Lettura - piu veloce da scrivere meno dettagliato
            let data = {
                ShplType: "SH",
                ShplName: "EHFND_ELM_EQART_T370K"
            };
    
            let response = await that.get(dySearch).where(data);*/
            let response = await serviceSearch.run(CQN);
            response = await convertDynamicFilter(response[0].ReturnTabValueSet);
            return response;
            
        } catch (error) {
            return save_log(request, error);
        }
    });

    const { shPOINT } = this.entities;
    this.on('READ', shPOINT, async request => {
        try {
            let data = {
                ShplType: "SH",
                ShplName: "IMPMP"
            };
            let response = await that.get(dySearch).where(data);
            response = await convertDynamicFilter(response[0].ReturnTabValueSet);
            return response;
        } catch (error) {
            return save_log(request, error);
        }
    });

    const { shTIPO_ATTIVITA } = this.entities;
    this.on('READ', shTIPO_ATTIVITA, async request => {
        try {
            let data = {
                ShplType: "SH",
                ShplName: "LART"
            };
            let response = await that.get(dySearch).where(data);
            response = await convertDynamicFilter(response[0].ReturnTabValueSet);
            return response;
        } catch (error) {
            return save_log(request, error);
        }
    });

    const { shTIPO_ORDINE } = this.entities;
    this.on('READ', shTIPO_ORDINE, async request => {
        try {
            let data = {
                ShplType: "SH",
                ShplName: "H_T003O"
            };
            let response = await that.get(dySearch).where(data);
            response = await convertDynamicFilter(response[0].ReturnTabValueSet);
            return response;
        } catch (error) {
            return save_log(request, error);
        }
    });

    const { shDIVISIONEC } = this.entities;
    this.on('READ', shDIVISIONEC, async request => {
        try {
            let data = {
                ShplType: "SH",
                ShplName: "H_T001W"
            };
            let response = await that.get(dySearch).where(data);
            response = await convertDynamicFilter(response[0].ReturnTabValueSet);
            return response;
        } catch (error) {
            return save_log(request, error);
        }
    });

    const { shCENTRO_LAVORO } = this.entities;
    this.on('READ', shCENTRO_LAVORO, async request => {
        try {
            let data = {
                ShplType: "SH",
                ShplName: "ZPM4R_H_DESTINATARIO"
            };
            let response = await that.get(dySearch).where(data);
            response = await convertDynamicFilter(response[0].ReturnTabValueSet);
            return response;
        } catch (error) {
            return save_log(request, error);
        }
    });
    
    const convertDatesv4Tov2 = (req) => {
        //LOG.warn(JSON.stringify(req.target.elements));
        Object.keys(req.data).forEach( key => {
            if ( req.target.elements[key] && (req.target.elements[key].type === "cds.Date" || req.target.elements[key].type === "cds.DateTime" || req.target.elements[key].type === "cds.Timestamp" ) )
                req.data[key] = convertIsoToJSEpoch(req.data[key])
        })
    }

    const save_log = (req, error, error_code = ERROR_CODE) => {
        var msg = "";
        if (_.isString(error)) {
            msg = error;
        } else {
            msg = error.toString();
            if (_.has(error, "innererror")) {
                msg = error.innererror.toString();
                if (_.has(error.innererror, "response")) {
                    msg = error.innererror.response.toString();
                    if (_.has(error.innererror.response, "body")) {
                        msg = error.innererror.response.body.toString();
                        if (_.has(error.innererror.response.body, "error")) {
                            msg = error.innererror.response.body.error.toString();
                            if (_.has(error.innererror.response.body.error, "message")) {
                                msg = error.innererror.response.body.error.message.toString();
                                if (_.has(error.innererror.response.body.error.message, "value")) {
                                    msg = error.innererror.response.body.error.message.value.toString();
                                }
                            }
                        }
                    }
                } else if (_.has(error.innererror, "error")) {
                    msg = error.innererror.error.toString();
                    if (_.has(error.innererror.error, "message")) {
                        msg = error.innererror.error.message.toString();
                        if (_.has(error.innererror.error.message, "value")) {
                            msg = error.innererror.error.message.value.toString();
                        }
                    }
                }
            } else if (_.has(error, "message")) {
                msg = error.message.toString();
            }
        }

        LOG.warn(error);
        LOG.warn(msg);
        if (CONSOLE_LOG) {
            console.log(msg);
        }
        return req.reject(error_code, msg);
    };

    const { Index } = this.entities;
    const { Azioni } = this.entities;
    
    /*const { Index_Azione } = this.entities;
    this.before('READ', Index_Azione, request => {
        if (!Array.isArray(request.query.SELECT.columns)) {
            request.query.SELECT.columns = [];
        }
        request.query.SELECT.columns.push({ ref: ['AZIONI'], expand: ['*'] });
    });

    this.on('READ', Index_Azione, async request => {
        let paramID = request.data.ID;
        try {
            if (paramID) {
                
                let Indice = await db.read(Index, paramID);
                let AzioniItem = await db.read(Azioni, paramID);

                if (!Array.isArray(AzioniItem)) {
                    AzioniItem = [AzioniItem];
                }
                AzioniItem.forEach(element => {
                    delete element.ID;
                });
        
                let ret = Indice;
                
                ret.AZIONI = AzioniItem;        
                return [ret];

            } else { 
            let ret = [], Indice = [];

            let CQN_Indice = {
                SELECT: {
                    columns: ['*'],
                    from: { ref: ['CatalogService.Index'] },
                    where: request.query.SELECT.where,
                    limit: request.query.SELECT.limit
                }
            };

            Indice = await db.read(CQN_Indice);
            //await Indice.forEach(header => {
            await Promise.all(await Indice.map(async function (header) {
                let res = header;
                let whereItem = { ID: res.ID };
                let AzioniItem = await db.read(Azioni).where(whereItem);

                if (!Array.isArray(AzioniItem)) {
                    AzioniItem = [AzioniItem];
                }

                AzioniItem.forEach(element => {
                    res.AZIONI = element.CONTATORE;
                    ret.push(res);
                });
                
            }));
        

            return ret;
        }

        } catch (error) {
            return save_log(request, error);
        }

    });
*/
    const { SedeDistinct } = this.entities;
    this.on('READ', SedeDistinct, async request => {
        try {
            let ret = [], res = {}, prova = [], CQN_Sede = "";
            if (request._queryOptions === null || request._queryOptions.$select === undefined) {
                CQN_Sede = {
                    SELECT: {
                        distinct: true,
                        from: { ref: ['CatalogService.Sede'] },
                        where: request.query.SELECT.where,
                        limit: request.query.SELECT.limit,
                        orderBy: request.query.SELECT.orderBy
                    }
                };
            } else {
                CQN_Sede = {
                    SELECT: {
                        distinct: true,
                        columns: [ {ref:[request._queryOptions.$select]} ],
                        from: { ref: ['CatalogService.Sede'] },
                        where: request.query.SELECT.where,
                        limit: request.query.SELECT.limit,
                        orderBy: [{ref:[request._queryOptions.$select], sort:'asc' }],
                    }
                };
            }
            
            ret = await db.run(CQN_Sede);
            return ret;

        } catch (error) {
            return save_log(request, error);
        }

    });

    const { Index_Azioni } = this.entities;
    this.on('READ', Index_Azioni, async request => {
        try {
            let ret = [], res = {}, prova = [], CQN_Index = "";
            if (request._queryOptions === null || request._queryOptions.$select === undefined) {
                CQN_Index = {
                    SELECT: {
                        distinct: true,
                        from: { ref: ['CatalogService.Index_Azioni'] },
                        where: request.query.SELECT.where,
                        limit: request.query.SELECT.limit,
                        orderBy: request.query.SELECT.orderBy
                    }
                };
            } else {
                CQN_Index = {
                    SELECT: {
                        distinct: true,
                        columns: [ {ref:[request._queryOptions.$select]} ],
                        from: { ref: ['CatalogService.Index_Azioni'] },
                        where: request.query.SELECT.where,
                        limit: request.query.SELECT.limit,
                        orderBy: [{ref:[request._queryOptions.$select], sort:'asc' }],
                    }
                };
            }
            
            ret = await db.run(CQN_Index);
            return ret;

        } catch (error) {
            return save_log(request, error);
        }

    });

});