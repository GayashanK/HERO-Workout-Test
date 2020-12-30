//
//  BaseService.swift
//  TestApp
//
//  Created by Kasun Gayashan on 12/29/20.
//

import Foundation
import Alamofire

struct AlamofireRequestModal {
    var method: Alamofire.HTTPMethod
    var path: String
    var parameters: [String: Any]?
    var encoding: ParameterEncoding
    var headers: [String: String]?
    
    init() {
        method = .get
        path = ""
        parameters = nil
        encoding = JSONEncoding() as ParameterEncoding
        headers = ["Content-Type": "application/json",
                   "X-Requested-With": "XMLHttpRequest",
                   "Cache-Control": "no-cache"]
    }
}

class BaseService: NSObject {
    
    #if DEBUG
    let defaultManager: Alamofire.SessionManager = {
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
             // Here host with port (trustPolicy is my var where I pin my certificates)
            "localhost:5001": .disableEvaluation,
             //Here without port
             "localhost": .disableEvaluation
        ]

        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders

        return Alamofire.SessionManager(
            configuration: configuration,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
    }()
    #endif
    
    func getBearerHeader() -> [String:String] {
        return ["Authorization": BaseService().getAccessToken()]
    }
    
    func getAccessToken() -> String {
        if let accessToken =  UserDefaults.standard.value(forKey: UserDefaultKey.accessToken.rawValue) as? String {
            return "bearer " + accessToken
        } else {
            return ""
        }
    }
    
    func callWebServiceAlamofire(_ alamoReq: AlamofireRequestModal, success: @escaping ((_ responseObject: AnyObject?) -> Void), failure: @escaping ((_ error: NSError?) -> Void)) {
        
        // Create alamofire request
        // "alamoReq" is overridden in services, which will create a request here
        #if DEBUG
        let req = defaultManager.request(alamoReq.path, method: alamoReq.method, parameters: alamoReq.parameters, encoding: alamoReq.encoding, headers: alamoReq.headers)
        #else
        let req = Alamofire.request(alamoReq.path, method: alamoReq.method, parameters: alamoReq.parameters, encoding: alamoReq.encoding, headers: alamoReq.headers)
        #endif
        
        // Call response handler method of alamofire
        req.validate(statusCode: 200..<600).responseJSON(completionHandler: { response in
            let statusCode = response.response?.statusCode
            
            switch response.result {
            case .success(let data):
                
                if statusCode == 200 || statusCode == 201 || statusCode == 204 || statusCode == 409 {
                    success(data as AnyObject?)
                } else {
                    let errorTemp = NSError(domain:"", code: response.response!.statusCode, userInfo:[ NSLocalizedDescriptionKey: "Sever Operation Failed."])
                    failure(errorTemp)
                }
                
            case .failure(let error):
                
                if statusCode == 409 {
                    success(nil)
                } else if statusCode == 401 {
                    var request: AlamofireRequestModal = alamoReq
                    request.headers = BaseService().getBearerHeader()
                    
                    self.callWebServiceAlamofire(request, success: success, failure: failure)
                } else {
                    failure(error as NSError?)
                }
            }
        })
        
    }
    
}
