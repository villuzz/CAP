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
    const serviceNOTIFICATION = await cds.connect.to('ZEWRKR_NOTIFICATION_SRV');

    const serviceODM = await cds.connect.to('ZPM4R_PMO_ODM_SRV');
    const serviceTEXT = await cds.connect.to('Z4R_TEXT_MANAGEMENT_SRV');

    const serviceANAG_1 = await cds.connect.to('ZPM4R_PMO_TAB_ANAG_1_SRV');
    const serviceANAG_2 = await cds.connect.to('ZPM4R_PMO_TAB_ANAG_2_SRV');
    const serviceANAG_3 = await cds.connect.to('ZPM4R_PMO_TAB_ANAG_3_SRV');
    const serviceANAG_4 = await cds.connect.to('ZPM4R_PMO_TAB_ANAG_4_SRV');

    const serviceEQUIP = await cds.connect.to('ZEWRKR_MASTERDATA_SRV');
    const serviceOBJECT = await cds.connect.to('ZPM4R_TECHNICAL_OBJECT_SRV_03');

    // *************************************************** COSTANTI **************************************************************** 
    const BATCH_SIZE = 50;
    const ERROR_CODE = 460;
    const CONSOLE_LOG = false;
    var that = this;

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

    const convertDateTimetoDate = (data, field) => {
        if (data) {
            data.forEach((element, index) => {
                if (element && typeof element == 'object' && !Array.isArray(element)) {
                    if (element.ref && typeof element.ref == 'object' && Array.isArray(element.ref)) {
                        if (element.ref.length == 1) {
                            if (element.ref[0] == field) {
                                if (data.length >= index + 3) {
                                    if (data[index + 2] && typeof data[index + 2] == 'object' && !Array.isArray(data[index + 2])) {
                                        if (data[index + 2].val) {
                                            LOG.warn(data[index + 2].val);
                                            var d = new Date(data[index + 2].val);
                                            data[index + 2].val = d.getFullYear() + "-" + (d.getMonth() + 1) + "-" + d.getDate();
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            });
        }
    };

    const convertIsoToJSEpoch = (isoDateTime) => {
        if (isoDateTime !== null){
        let last = isoDateTime.charAt(isoDateTime.length - 1);
        if (last == "Z") {
            isoDateTime = isoDateTime.slice(0, -1)
        }
        let date = new Date(isoDateTime);
        let milliseconds = date.getTime();
        // eslint-disable-next-line no-unused-vars
        let timezoneOffset = date.getTimezoneOffset();
        //let correctMillis = milliseconds - (timezoneOffset * 60000); //to convert minutes to millis
        let correctMillis = milliseconds;
        return "/Date(" + correctMillis + ")/"
        } else {
            return null
        }
    }
    const convertIsoToJSEpochTime = (isoDateTime) => {
        let h = isoDateTime.substring(0,2);
        let m = isoDateTime.substring(3,5);
        let s = isoDateTime.substring(6,8);

        return "PT" + h + "H" + m + "M" + s + "S";
    }

    // eslint-disable-next-line no-unused-vars
    const convertEpochToIsoDate = (jsEpoch) => {
        return convertEpochToIsoDateTime(jsEpoch).substring(0, 10)
    }

    const convertEpochToIsoDateTime = (jsEpoch) => {
        //return new Date(eval(jsEpoch.replace(/\//g,""))).toJSON()
        jsEpoch = jsEpoch.replace(/\//g, "");
        jsEpoch = jsEpoch.substring(5, 18);
        return new Date(parseInt(jsEpoch)).toJSON()
    }

    const removeNull = (data) => {
        Object.keys(data).forEach(key => {
            if (data[key] == null) {
                delete data[key];
            }
            if (typeof data[key] == "object") {
                removeNull(data[key])
            }
        })
    }

    const convertDatesv4Tov2 = (req) => {
        //LOG.warn(JSON.stringify(req.target.elements));
        Object.keys(req.data).forEach(key => {
            if (req.target.elements[key] && (req.target.elements[key].type === "cds.Date" || req.target.elements[key].type === "cds.DateTime" || req.target.elements[key].type === "cds.Timestamp"))
                req.data[key] = convertIsoToJSEpoch(req.data[key])
        })
    }
    const convertTimev4Tov2 = (req) => {
        //LOG.warn(JSON.stringify(req.target.elements));
        Object.keys(req.data).forEach(key => {
            if (req.target.elements[key] && (req.target.elements[key].type === "cds.Time"))
                req.data[key] = convertIsoToJSEpochTime(req.data[key])
        })
    }

    const removeOdataType = (data) => {
        Object.keys(data).forEach(key => {
            if (key && key == '@odata.type') {
                delete data[key];
            }
            if (data[key] && typeof data[key] == 'object' && Array.isArray(data[key])) {
                data[key].forEach(element => {
                    removeOdataType(element);
                });
            } else if (data[key] && typeof data[key] == 'object' && !Array.isArray(data[key])) {
                removeOdataType(data[key]);
            }
        })
    }
    // *************************************************** EQUIPMENT **************************************************************** 
    

    const { HierarchyEquip } = this.entities;
    this.before('READ', HierarchyEquip, request => {
        if (!Array.isArray(request.query.SELECT.columns)) {
            request.query.SELECT.columns = [];
        }
        request.query.SELECT.columns.push({ ref: ['HierarchySet'], expand: ['*'] });
    });

    this.on('READ', HierarchyEquip, async request => {
        try {
            convertTimev4Tov2(request);
            let response = await serviceEQUIP.tx(request).run(request.query);
            return response;
        } catch (error) {
            return save_log(request, error);
        }
    });
    // *************************************************** TESTI ESTESI ****************************************************************     
    const { TestiEstesi } = this.entities;
    this.on('READ', TestiEstesi, async request => {
        try { let response = await serviceTEXT.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('CREATE', TestiEstesi, async request => {
        try { let response = await serviceTEXT.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('DELETE', TestiEstesi, async request => {
        try { let response = await serviceTEXT.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('UPDATE', TestiEstesi, async request => {
        try { 
            let response = await serviceTEXT.tx(request).run(request.query); 
            return response; } catch (error) { return save_log(request, error); }
    });
    const { TestiEstesiDelete } = this.entities;
    this.on('DELETE', TestiEstesiDelete, async request => { 
        try { let response = await serviceTEXT.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });

    // *************************************************** APP4 **************************************************************** 
    const { GetODM } = this.entities;
    this.on('CREATE', GetODM, async request => { try { convertDatesv4Tov2(request); convertTimev4Tov2(request); let response = await serviceODM.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); } });
    this.on('UPDATE', GetODM, async request => { try { let response = await serviceODM.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); } });

    // *************************************************** ORDINE **************************************************************** 
    
    const { ShopPaper } = this.entities;
    this.on('CREATE', ShopPaper, async request => { try { convertDatesv4Tov2(request); convertTimev4Tov2(request); let response = await serviceORDER.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); } });
    
    const { CreateOrder } = this.entities;
    this.on('CREATE', CreateOrder, async request => { try { convertDatesv4Tov2(request); convertTimev4Tov2(request); let response = await serviceORDER.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); } });

    const { PrintOrderOutputBin } = this.entities;
    this.on('CREATE', PrintOrderOutputBin, async request => { try { convertDatesv4Tov2(request); convertTimev4Tov2(request); let response = await serviceORDER.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); } });

    const { ConfirmCreate } = this.entities;
    this.on('READ', ConfirmCreate, async request => { try { let response = await serviceORDER.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); } });

    const { GetOMList } = this.entities;
    this.on('READ', GetOMList, async request => { try { let response = await serviceORDER.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); } });

    const { UpdateOrder } = this.entities;
    this.on('CREATE', UpdateOrder, async request => { try { convertDatesv4Tov2(request); convertTimev4Tov2(request); let response = await serviceORDER.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); } });

    // *************************************************** AVVISI ****************************************************************
    const { CreateNotification } = this.entities;
    this.on('CREATE', CreateNotification, async request => { try { let response = await serviceNOTIFICATION.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); } });

    const { UpdateNotification } = this.entities;
    this.on('CREATE', UpdateNotification, async request => { try { let response = await serviceNOTIFICATION.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); } });

    const { GetNotification } = this.entities;
    this.on('READ', GetNotification, async request => { try { let response = await serviceNOTIFICATION.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); } });

    // *************************************************** APP1 ****************************************************************
    const { T_RAGGR } = this.entities;
    this.on('READ', T_RAGGR, async request => {
        try { let response = await serviceANAG_2.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('CREATE', T_RAGGR, async request => {
        try { let response = await serviceANAG_2.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('DELETE', T_RAGGR, async request => {
        try { let response = await serviceANAG_2.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('UPDATE', T_RAGGR, async request => {
        try { let response = await serviceANAG_2.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });

    const { T_DEST } = this.entities;
    this.on('READ', T_DEST, async request => {
        try { let response = await serviceANAG_2.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('CREATE', T_DEST, async request => {
        try { let response = await serviceANAG_2.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('DELETE', T_DEST, async request => {
        try { let response = await serviceANAG_2.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('UPDATE', T_DEST, async request => {
        try { let response = await serviceANAG_2.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });

    const { T_ACT_PROG } = this.entities;
    this.on('READ', T_ACT_PROG, async request => {
        try { let response = await serviceANAG_2.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('CREATE', T_ACT_PROG, async request => {
        try { let response = await serviceANAG_2.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('DELETE', T_ACT_PROG, async request => {
        try { let response = await serviceANAG_2.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('UPDATE', T_ACT_PROG, async request => {
        try { let response = await serviceANAG_2.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });

    const { T_TP_MAN } = this.entities;
    this.on('READ', T_TP_MAN, async request => {
        try { let response = await serviceANAG_3.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('CREATE', T_TP_MAN, async request => {
        try { let response = await serviceANAG_3.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('DELETE', T_TP_MAN, async request => {
        try { let response = await serviceANAG_3.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('UPDATE', T_TP_MAN, async request => {
        try { let response = await serviceANAG_3.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });

    const { T_TP_MAN1 } = this.entities;
    this.on('READ', T_TP_MAN1, async request => {
        try { let response = await serviceANAG_3.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('CREATE', T_TP_MAN1, async request => {
        try { let response = await serviceANAG_3.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('DELETE', T_TP_MAN1, async request => {
        try { let response = await serviceANAG_3.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('UPDATE', T_TP_MAN1, async request => {
        try { let response = await serviceANAG_3.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });

    const { T_TP_MAN2 } = this.entities;
    this.on('READ', T_TP_MAN2, async request => {
        try { let response = await serviceANAG_3.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('CREATE', T_TP_MAN2, async request => {
        try { let response = await serviceANAG_3.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('DELETE', T_TP_MAN2, async request => {
        try { let response = await serviceANAG_3.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('UPDATE', T_TP_MAN2, async request => {
        try { let response = await serviceANAG_3.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });

    const { T_ACT_SYST } = this.entities;
    this.on('READ', T_ACT_SYST, async request => {
        try { let response = await serviceANAG_4.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('CREATE', T_ACT_SYST, async request => {
        try { let response = await serviceANAG_4.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('DELETE', T_ACT_SYST, async request => {
        try { let response = await serviceANAG_4.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('UPDATE', T_ACT_SYST, async request => {
        try { let response = await serviceANAG_4.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });

    const { T_ACT_CL } = this.entities;
    this.on('READ', T_ACT_CL, async request => {
        try { let response = await serviceANAG_4.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('CREATE', T_ACT_CL, async request => {
        try { let response = await serviceANAG_4.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('DELETE', T_ACT_CL, async request => {
        try { let response = await serviceANAG_4.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('UPDATE', T_ACT_CL, async request => {
        try { let response = await serviceANAG_4.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });

    const { T_DEST_USR } = this.entities;
    this.on('READ', T_DEST_USR, async request => {
        try { let response = await serviceANAG_2.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('CREATE', T_DEST_USR, async request => {
        try { let response = await serviceANAG_2.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('DELETE', T_DEST_USR, async request => {
        try { let response = await serviceANAG_2.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('UPDATE', T_DEST_USR, async request => {
        try { let response = await serviceANAG_2.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });

    const { T_ACT_TYPE } = this.entities;
    this.on('READ', T_ACT_TYPE, async request => {
        try { let response = await serviceANAG_1.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('CREATE', T_ACT_TYPE, async request => {
        try { convertDatesv4Tov2(request); convertTimev4Tov2(request); let response = await serviceANAG_1.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('DELETE', T_ACT_TYPE, async request => {
        try { let response = await serviceANAG_1.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('UPDATE', T_ACT_TYPE, async request => {
        try { 
            convertDatesv4Tov2(request); convertTimev4Tov2(request); 
            let response = await serviceANAG_1.tx(request).run(request.query); 
            return response; 
        } catch (error) { 
            return save_log(request, error); 
        }
    });

    const { T_ATTPM } = this.entities;
    this.on('READ', T_ATTPM, async request => {
        try { let response = await serviceANAG_4.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('CREATE', T_ATTPM, async request => {
        try { let response = await serviceANAG_4.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('DELETE', T_ATTPM, async request => {
        try { let response = await serviceANAG_4.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('UPDATE', T_ATTPM, async request => {
        try { let response = await serviceANAG_4.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });


    const { T_AGGREG } = this.entities;
    this.on('READ', T_AGGREG, async request => {
        try { let response = await serviceANAG_4.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('CREATE', T_AGGREG, async request => {
        try { let response = await serviceANAG_4.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('DELETE', T_AGGREG, async request => {
        try { let response = await serviceANAG_4.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('UPDATE', T_AGGREG, async request => {
        try { let response = await serviceANAG_4.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });


    const { T_APP_WO } = this.entities;
    this.on('READ', T_APP_WO, async request => {
        try { let response = await serviceANAG_1.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('CREATE', T_APP_WO, async request => {
        try { convertDatesv4Tov2(request); convertTimev4Tov2(request); let response = await serviceANAG_1.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('DELETE', T_APP_WO, async request => {
        try { let response = await serviceANAG_1.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('UPDATE', T_APP_WO, async request => {
        try { convertDatesv4Tov2(request); convertTimev4Tov2(request); let response = await serviceANAG_1.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });

    const convertDynamicFilter = (req) => {
        let ExtractionGrouped = _.groupBy(req, ele => ele.Recordpos);
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


    // *************************************************** APP2 ****************************************************************

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
                        columns: [{ ref: [request._queryOptions.$select] }],
                        from: { ref: ['CatalogService.Sede'] },
                        where: request.query.SELECT.where,
                        limit: request.query.SELECT.limit,
                        orderBy: [{ ref: [request._queryOptions.$select], sort: 'asc' }],
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
                        columns: [{ ref: [request._queryOptions.$select] }],
                        from: { ref: ['CatalogService.Index_Azioni'] },
                        where: request.query.SELECT.where,
                        limit: request.query.SELECT.limit,
                        orderBy: [{ ref: [request._queryOptions.$select], sort: 'asc' }],
                    }
                };
            }

            ret = await db.run(CQN_Index);
            return ret;

        } catch (error) {
            return save_log(request, error);
        }

    });

    // *************************************************** APP 3 ************************************************************************

    const { T_PMO } = this.entities;
    this.before('READ', T_PMO, request => {
        try {
            if (request._queryOptions !== null && request._queryOptions.$select !== undefined) {
                request.query.SELECT.columns = [{ ref: [request._queryOptions.$select] }];
            } else {
                if (!Array.isArray(request.query.SELECT.columns)) {
                    request.query.SELECT.columns = [];
                }
                request.query.SELECT.columns = ['*', { ref: ['T_ACT_ELSet'], expand: ['*'] },
                    { ref: ['T_PMO_MSet'], expand: ['*'] },
                    { ref: ['T_PMO_SSet'], expand: ['*'] }];
            }
        } catch (error) { return save_log2(request, error); }
    });
    this.on('READ', T_PMO, async request => {
        try { let response = await serviceT_PMO.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('CREATE', T_PMO, async request => {
        try { convertDatesv4Tov2(request); convertTimev4Tov2(request); let response = await serviceT_PMO.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('DELETE', T_PMO, async request => {
        try { let response = await serviceT_PMO.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('UPDATE', T_PMO, async request => {
        try { convertDatesv4Tov2(request); convertTimev4Tov2(request); let response = await serviceT_PMO.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });

    const { JoinPMO } = this.entities;
    this.before('READ', JoinPMO, request => {
        try {
            if (request._queryOptions !== null && request._queryOptions.$select !== undefined) {
                request.query.SELECT.columns = [{ ref: [request._queryOptions.$select] }];
            } else {
                if (!Array.isArray(request.query.SELECT.columns)) {
                    request.query.SELECT.columns = [];
                }
                request.query.SELECT.columns = ['*', { ref: ['T_PMOSet'], expand: ['*'] },
                    { ref: ['T_ACT_ELSet'], expand: ['*'] },
                    { ref: ['T_PMO_MSet'], expand: ['*'] },
                    { ref: ['T_PMO_SSet'], expand: ['*'] }];
            }
        } catch (error) { return save_log2(request, error); }
    });
    this.on('READ', JoinPMO, async request => {
        try { let response = await serviceT_PMO.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('CREATE', JoinPMO, async request => {
        try { convertDatesv4Tov2(request); convertTimev4Tov2(request); let response = await serviceT_PMO.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('DELETE', JoinPMO, async request => {
        try { let response = await serviceT_PMO.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('UPDATE', JoinPMO, async request => {
        try { convertDatesv4Tov2(request); convertTimev4Tov2(request); let response = await serviceT_PMO.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });

    const { T_ACT_EL } = this.entities;
    this.on('READ', T_ACT_EL, async request => {
        try { let response = await serviceT_PMO.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('CREATE', T_ACT_EL, async request => {
        try { convertDatesv4Tov2(request); convertTimev4Tov2(request); let response = await serviceT_PMO.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('DELETE', T_ACT_EL, async request => {
        try { let response = await serviceT_PMO.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('UPDATE', T_ACT_EL, async request => {
        try { convertDatesv4Tov2(request); convertTimev4Tov2(request); let response = await serviceT_PMO.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });

    const { T_PMO_M } = this.entities;
    this.on('READ', T_PMO_M, async request => {
        try { let response = await serviceT_PMO.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('CREATE', T_PMO_M, async request => {
        try { convertDatesv4Tov2(request); convertTimev4Tov2(request); let response = await serviceT_PMO.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('DELETE', T_PMO_M, async request => {
        try { let response = await serviceT_PMO.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('UPDATE', T_PMO_M, async request => {
        try { convertDatesv4Tov2(request); convertTimev4Tov2(request); let response = await serviceT_PMO.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });

    const { T_PMO_S } = this.entities;
    this.on('READ', T_PMO_S, async request => {
        try { let response = await serviceT_PMO.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('CREATE', T_PMO_S, async request => {
        try { convertDatesv4Tov2(request); convertTimev4Tov2(request); let response = await serviceT_PMO.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('DELETE', T_PMO_S, async request => {
        try { let response = await serviceT_PMO.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });
    this.on('UPDATE', T_PMO_S, async request => {
        try { convertDatesv4Tov2(request); convertTimev4Tov2(request); let response = await serviceT_PMO.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });

    // *************************************************** DYNAMIC SEARCH ****************************************************************
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
    this.on('CREATE', dySearch, async request => {
        try { let response = await serviceSearch.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
    });

    const { shEQART } = this.entities;
    this.on('READ', shEQART, async request => {
        let CQN = {
            SELECT: {
                columns: [{ ref: ['ReturnTabValueSet'], expand: ['*'] }],
                from: { ref: ['CatalogService.dySearch'] },
                where: [{ ref: ["ShplType"] }, "=", { val: 'SH' }, 'and', { ref: ["ShplName"] }, "=", { val: 'EHFND_ELM_EQART_T370K' }],
                orderBy: [{ ref: ['ShplName'], sort: ['asc'] }],
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

    const { ListFl } = this.entities;
    this.on('CREATE', ListFl, async request => {
        try { convertDatesv4Tov2(request); convertTimev4Tov2(request); let response = await serviceOBJECT.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
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

    const { StorageList } = this.entities;
    this.on('READ', StorageList, async request => {
        try { let response = await serviceSearch.tx(request).run(request.query); return response; } catch (error) { return save_log(request, error); }
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

});