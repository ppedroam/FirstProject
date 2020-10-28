//
//  ApiManager.swift
//  ProjetoGuilda
//
//  Created by Pedro Menezes on 27/10/20.
//

import Foundation
import Alamofire

protocol HomeProviderDelegate {
    func getInfos(stateNumber: String, successCallBack: @escaping ([String]) -> Void, errorCallBack: @escaping (Error) -> Void)
}

class HomeProvider: HomeProviderDelegate {
    func getInfos(stateNumber: String, successCallBack: @escaping ([String]) -> Void, errorCallBack: @escaping (Error) -> Void) {
        
        let httpHeader = HTTPHeader(name: "Content-Type", value: "application/json")
        let httpHeaders = HTTPHeaders([httpHeader])
        
        var url = ""
        #if DEBUG
        url = "https://servicodados.ibge.gov.br/api/v1/localidades/estados/{id}/distritos".replace(occurences: ["{id}"], with: stateNumber)
        #elseif HOMOLOG
        url = "https://servicodados.ibge.gov.br/api/v1/localidades/estados/{id}/distritos".replace(occurences: ["{id}"], with: stateNumber)
        #elseif PROD
        url = "https://servicodados.ibge.gov.br/api/v1/localidades/estados/{id}/distritos".replace(occurences: ["{id}"], with: stateNumber)
        #endif
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: httpHeaders)
            .responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success(let data):
                    var citiesArray: [String] = []
                    if let array = data as? [[String: Any]] {
                        array.forEach { (dict) in
                            if let name = dict["nome"] as? String {
                                citiesArray.append(name)
                            }
                        }
                    } else {
                        errorCallBack(ServiceError.parsing)
                        return
                    }
                    successCallBack(citiesArray)

                case .failure(let error):
                    print(error)
                    errorCallBack(ServiceError.failure)
                }
        })
    }
}
