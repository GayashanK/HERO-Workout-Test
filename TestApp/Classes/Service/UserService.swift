//
//  UserService.swift
//  TestApp
//
//  Created by Kasun Gayashan on 12/29/20.
//

import Foundation
import Alamofire
import ObjectMapper

class UserService: BaseService {

    func loginUser(user: User, success: @escaping((_ status: Bool)-> Void),faliure: (@escaping(_ error: Error?) -> Void)){
        let url = (Network.baseUrl + "api/user").addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)

        let params = ["name": user.email!, "userId": user.password!] as [String: Any]
       
        var request: AlamofireRequestModal = AlamofireRequestModal()
        request.method = .get
        request.path = url!
        request.encoding = JSONEncoding.default
        request.headers = BaseService().getBearerHeader()
        request.parameters = params

        BaseService().callWebServiceAlamofire(request, success: { response in
//            let data = Mapper<StatusResponse>().map(JSONObject: response)
            success(true)
        }, failure: { error in
            faliure(error)
        })
    }

}
