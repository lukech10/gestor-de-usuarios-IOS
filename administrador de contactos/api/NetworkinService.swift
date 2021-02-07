//
//  networkinServices.swift
//  rutas
//
//  Created by alumnos on 26/01/2021.
//  Copyright © 2021 alumnos. All rights reserved.
//

import Foundation

//enum MyResult<T,E:Error> {
//    case succes(T)
//    case failure(E)
//}


class NetworkinService{
    
    let baseUrl = "http://localhost:8888/rutasAPI/public/api"
    
    func request(endpoint: String,
                 parameters: [String: Any],
                 completion: @escaping(Result<User,Error>)->Void) {
        guard let url = URL(string: baseUrl + endpoint) else{
            completion(.failure(NetworkingError.badUrl))
            return
        }
        
        var request = URLRequest(url: url)
        
        var components = URLComponents()
        
        var queryItems = [URLQueryItem]()
        
        for(key, value) in parameters{
            let queryItem = URLQueryItem(name: key, value: String(describing: value))
            queryItems.append(queryItem)
        }
        
        components.queryItems = queryItems
        
        //email=ejemplo@gmail.com&contraseña=hola123
        let queryItemData = components.query?.data(using: .utf8)
        
        request.httpBody = queryItemData
        
        request.httpMethod = "POST"
        
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            DispatchQueue.main.async {
                
                guard let unwrappedResponse = response as? HTTPURLResponse else{
                    
                    completion(.failure(NetworkingError.badResponse))
                    return
                }
                
                print(unwrappedResponse.statusCode)
                
                switch unwrappedResponse.statusCode{
                    
                case 200 ..< 300:
                    
                    print("succes")
                    
                default:
                    print("failure")
                }
                
                /*if let unwrappedError = error{
                    completion(.failure(unwrappedError))
                    return
                }
                
                if let unwrappedData = data{
                    do{
                        let json = try JSONSerialization.jsonObject(with: unwrappedData, options: [])
                        print(json)
                    } catch {
                        completion(.failure(error))
                    }
                }*/
                
            }
            
            
        }
        
        task.resume()
        
    }
}

enum NetworkingError: Error{
    case badUrl
    case badResponse
}
