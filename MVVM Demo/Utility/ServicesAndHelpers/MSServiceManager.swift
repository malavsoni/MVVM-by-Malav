//
//  MSServiceManager.swift
//  MVVM Demo
//
//  Created by Malav Soni on 03/12/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import Alamofire


class MSServiceManager: NSObject {
    
    static let shared:MSServiceManager = MSServiceManager()
    
    typealias APIResponseHandler = ((Bool,Any?,String)->())
    typealias APIResponseStandardDictionaryHandler = ((Bool,[String:Any],String)->())
    typealias APILoginResponseHandler = ((Bool,String)->())
    
    private var localizeAlertStrings = ValidationMessages()
    
    enum APIEndPoint:String {
    
           static var APIBaseURL = "https://restcountries.eu/rest/v2/"
           
           case getAllCountries = "all?fields=name;capital"
           
           var apiURL:String {
               return "\(APIEndPoint.APIBaseURL)\(self.rawValue)"
           }
           
           var httpMethod:HTTPMethod{
               switch self {
               default:
                   return .post
               }
           }
           
           var parameterEncoding:ParameterEncoding{
               switch self.httpMethod {
               case .post:
                   return JSONEncoding.default
               default:
                   return URLEncoding.default
               }
           }
       }
    
    func isInternetAvailable() -> Bool{
        return NetworkReachabilityManager()?.isReachable ?? false
    }
    
    private func callAPI(WithEndPoint endPoint:APIEndPoint,
                             AndParameters params:[String:Any],
                             shouldShowInternetAlertOnFailure shouldShowInternetAlert:Bool,
                             shouldShowLoader showLoader:Bool,
                             shouldHideLoader hideLoader:Bool,
                             WithCompletion completion:@escaping APIResponseHandler) -> Void{
            
            guard self.isInternetAvailable() else {
                if shouldShowInternetAlert{
                    UIAlertController.alert(message: localizeAlertStrings.internetConnectionError)
                }
                completion(false,[:],localizeAlertStrings.internetConnectionError)
                return
            }
            
            if showLoader{
                MSLoader.shared.showLoader()
            }
            
            let mutableParameters = params
    //        mutableParameters[Parameters.Key.ModelNo.rawValue] = UIDevice.modelName
    //        mutableParameters[Parameters.Key.DeviceID.rawValue] = UIDevice.current.identifierForVendor?.uuidString ?? ""
            
            var headers:HTTPHeaders = [:]
            headers["Content-Type"] = "application/json"
            headers["Content-Type"] = "application/x-www-form-urlencoded"
            guard let apiURL = URL.init(string: endPoint.apiURL) else { return }
            
            #if DEBUG
            print("\(String(describing: endPoint.httpMethod)) API URL : \(apiURL)\nHeaders : \(headers)\nParams : \(mutableParameters)")
            #endif
            
            Alamofire.request(apiURL, method: endPoint.httpMethod, parameters: mutableParameters, encoding: endPoint.parameterEncoding, headers: headers).responseJSON { (serverResponse) in
                
                switch serverResponse.result{
                case .success(let jsonObject):
                    #if DEBUG
                        print("URL : \(String(describing: serverResponse.request?.url))\n\(jsonObject)")
                    #endif
                    
                    if let statusCode = serverResponse.response?.statusCode{
                        switch statusCode{
                        case 200:
                            if let dicResponse = jsonObject as? [String:Any], let serverData = dicResponse["data"] as? [String:Any], let serverMessage = dicResponse["message"] as? String {
                                completion(true,serverData,serverMessage)
                            }else{
                                completion(false,[:],GlobalMessages().somethingWentWrongWithServer)
                            }
                        default:
                            if let dicResponse = jsonObject as? [String:Any], let serverData = dicResponse["data"] as? [String:Any], let serverMessage = dicResponse["message"] as? String {
                                completion(false,serverData,serverMessage)
                            }else{
                                completion(false,[:],GlobalMessages().somethingWentWrongWithServer)
                            }
                            break
                        }
                    }
                    
                    if hideLoader{
                        MSLoader.shared.hideLoader()
                    }
                    break
                case .failure(let error):
                    if let dataForServer = serverResponse.data{
                        if let stringValue = String.init(data: dataForServer, encoding: String.Encoding.utf8){
                            #if DEBUG
                                print("Invalid Json : \(stringValue) \(error)")
                            #endif
                            //
                            completion(false,[:],stringValue)
                        }else{
                            completion(false,[:],error.localizedDescription)
                        }
                    }else{
                        completion(false,[:],error.localizedDescription)
                    }
                    
                    if hideLoader{
                        MSLoader.shared.hideLoader()
                    }
                    break
                }
            }
        }
}

extension MSServiceManager{
    
    // Country Module API
    func getCountryList(withCompletion completion:(([Country],Error?)->())?) -> Void{
        let url: String = APIEndPoint.getAllCountries.apiURL
        Alamofire.request(URL.init(string: url)!).responseJSON { (response) in
            switch response.result{
            case .success( _):
                guard let jsonData = response.data else {
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let aryCountries = try decoder.decode([Country].self, from: jsonData)

                    completion?(aryCountries,nil)
                }catch(let error){
                    completion?([],error)
                }
                break
            case .failure(let error):
                completion?([],error)
                break
            }
        }
    }
}
