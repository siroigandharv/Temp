const path = require("path")
const { Verifier } = require("@pact-foundation/pact");
const { Pact } = require('@pact-foundation/pact');
const Publisher = require('@pact-foundation/pact-node');
//const environmentData = require('../../../config/test-module/environment').environment;
//const ENV_DATA = environmentData[process.env.ENV];
const { faker } = require('@faker-js/faker')

//const SERVER_URL = `http://localhost:4000`;
//const BRAND = process.env.BRAND
//const URL = ENV_DATA[BRAND].PROSPECT_MS_URL
const EXECUTION_ENVIRONMENT = process.env.ENV;
//const {setValueToStubToSetValues} = require('./helper/callToDomusSTUB')


const http = require('http');
const httpProxy = require('http-proxy')



  


describe("Consumer contracts verification", () => {
    
    let identifier;
    let state;
    let header;

    const opts_appdev = {
        logLevel: "DEBUG",
        providerBaseUrl: URL,
        provider: "mvs-spine-ms",
        providerVersion: "1.0.0",
        pactBrokerUrl: "http://localhost:9292",
        providerVersionTags: ['develop'],
        providerVersionBranch: 'develop',
        consumerVersionSelectors: [
            {
                tag: "develop",
                latest: true,
            },
        ],
        publishVerificationResult: true,
        
        beforeEach : async () =>{
            identifier = faker.random.alphaNumeric(49)
            header = `{"userType": "${user_type}", "sub":  "${identifier}", "exp": 1666343413, "userAgent": "Mozilla/5.0 (Linux; U; Android 2.3.6; en-us; Nexus S Build/GRK39F) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1" }`
        },
        beforeEach : async () =>{
            identifier = faker.random.alphaNumeric(49)
            header = `{"userType": "${user_type}", "sub":  "${identifier}", "exp": 1666343413, "userAgent": "Mozilla/5.0 (Linux; U; Android 2.3.6; en-us; Nexus S Build/GRK39F) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1" }`
        },
        stateHandlers : {
            "create new prospect with new value of x-authorization-id" : ()=>{
                console.log("setting the state to use the new x-auth");
                state = "create new prospect with new value of x-authorization-id"
            },
            "prospect record must exist for the given prospect id x-authorization-id" : () => {
                state = "prospect record must exist for the given prospect id x-authorization-id"
                console.log("setting the state to use the existing x-auth")
                //we can implement to create a new prspect here
            }
        },
        requestFilter : async (req, res, next) => {
            
            /*if(req.body.state === 'prospect record must exist for the given prospect id'){
                console.log("running state - prospect record must exist for the given prospect id")
                req.headers['x-authorization-id'] = x_auth
                req.query.ProspectId = prospect_id_created
            }
            console.log(req.query)
            if(req.query.ProspectId === '10000'){
                req.query.ProspectId = prospect_id_created;
            }
            console.log(req.headers['x-authorization-id'])
            console.log(`The queries are -`)
            console.log(req.query.ProspectId)*/
            if (state === 'create new prospect with new value of x-authorization-id'){
                //new identifier will be used
                console.log(`state = ${state}`)
                console.log("using new identifier")
                req.headers['x-authorization-id'] = header
            }
            else{
                //new identifier will be used
                console.log("default case condition")
                console.log("existing identifier")
            }
            /*console.log(`The queries are -`)
            console.log(req.query['ProspectID'])

            console.log(`The params are -`)
            console.log(req.params['ProspectID'])

            //req.path = `${req.path}?ProspectID=${req.query['ProspectID']}`
            //req.path = req.path + "?ProspectID=" + req.params['ProspectID']
            console.log(`The path is -`)
            console.log(req.path)

            console.log(`The headers are -`)
            console.log(req.headers['x-authorization-id'])*/
            next()
        }
    };

    
    const opts_local = {
        logLevel: "DEBUG",
        providerBaseUrl: "http://localhost:8085",
        provider: "Prospect Management APIs",
        providerVersion: "1.0.0",
        pactUrls : [
            //path.resolve(__dirname, "../../contract-tests/pacts/findprospect-findprospectapi.json"),
            //path.resolve(__dirname, "../../contract-tests/pacts/crateprospect-createprospectapi.json"),
            //path.resolve(__dirname, "../../contract-tests/pacts/addprospectcontact-addprospectcontactapi.json"),
            //path.resolve(__dirname, "../../contract-tests/pacts/addintent-addintentapi.json"),
            path.resolve(__dirname, "../../contract-tests/pacts/findintentcontact-findintentcontactapi.json")
            
        ],
        beforeEach : async () =>{
            identifier = faker.random.alphaNumeric(49)
            header = `{"userType": "UNAUTH Customer", "sub":  "${identifier}", "exp": 1666343413, "userAgent": "Mozilla/5.0 (Linux; U; Android 2.3.6; en-us; Nexus S Build/GRK39F) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1" }`
        },
        stateHandlers : {
            "create new prospect with new value of x-authorization-id" : ()=>{
                console.log("setting the state to use the new x-auth");
                state = "create new prospect with new value of x-authorization-id"
            },
            "prospect record must exist for the given prospect id x-authorization-id" : () => {
                state = "prospect record must exist for the given prospect id x-authorization-id"
                console.log("setting the state to use the existing x-auth")
                //we can implement to create a new prspect here
            }
        },
        requestFilter : async (req, res, next) => {
            
            /*if(req.body.state === 'prospect record must exist for the given prospect id'){
                console.log("running state - prospect record must exist for the given prospect id")
                req.headers['x-authorization-id'] = x_auth
                req.query.ProspectId = prospect_id_created
            }
            console.log(req.query)
            if(req.query.ProspectId === '10000'){
                req.query.ProspectId = prospect_id_created;
            }
            console.log(req.headers['x-authorization-id'])
            console.log(`The queries are -`)
            console.log(req.query.ProspectId)*/
            //console.log(req.path)
            if (state === 'create new prospect with new value of x-authorization-id'){
                //new identifier will be used
                console.log(`state = ${state}`)
                console.log("using new identifier")
                req.headers['x-authorization-id'] = header
            }
            else{
                //new identifier will be used
                console.log("default case condition")
                console.log("existing identifier")
            }
            /*console.log(`The queries are -`)
            console.log(req.query['ProspectID'])

            console.log(`The params are -`)
            console.log(req.params['ProspectID'])

            //req.path = `${req.path}?ProspectID=${req.query['ProspectID']}`
            //req.path = req.path + "?ProspectID=" + req.params['ProspectID']
            console.log(`The path is -`)
            console.log(req.path)

            console.log(`The headers are -`)
            console.log(req.headers['x-authorization-id'])*/
            next()
        }
    };

    const proxy = httpProxy.createProxyServer()
    const server = http.createServer((req, res) => {
        console.log(`The original value of the API endpoint path is: ${req.url}`);
        //req.url = '/new/endpoint/path';
        //console.log(`The modified value of the API endpoint path is: ${req.url}`);
        proxy.web(req, res, { target: opts_local.providerBaseUrl });
      });
    
    it("should validate all consumer contracts", () => {
        if(EXECUTION_ENVIRONMENT === 'LOCAL'){
            return new Verifier(opts_local).verifyProvider().then(output => {
                server.listen(8085)
                console.log(output);
            }).catch((e) => {
                console.log(e.message);
                throw e;
            });
        }else{
            return new Verifier(opts_local).verifyProvider().then(output => {
                server.listen(8085)
                console.log(output);
            }).catch((e) => {
                console.log(e.message);
                throw e;
            });
        }
        
        /*return new Verifier(opts).verifyProvider().then(output => {
            console.log(output);
        }).catch((e) => {
            console.log(e.message);
            throw e;
        });*/
    })
});
