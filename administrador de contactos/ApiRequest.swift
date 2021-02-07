//
//  ApiRequest.swift
//  rutas
//
//  Created by alumnos on 29/01/2021.
//  Copyright © 2021 alumnos. All rights reserved.
//

import Foundation

//enum APIError:Error {
//    case responseProblem
//    case decodingProblem
//    case encodingProblem
//}

enum MyResult<T,E:Error> {
    case succes(T)
    case failure(E)
}


class ApiRequest {
    let resourceURL: URL
    
    init(endpoint: String) {
        //let resourceString = "http://localhost:8888/rutasAPI/public/api/\(endpoint)"
        
        let resourceString = "https://superapi.netlify.app/\(endpoint)"
        
        guard let resourceURL = URL(string: resourceString)else {fatalError()}
        
        self.resourceURL = resourceURL
    }
    
    func save(_ userToSave: User, completion: @escaping(Result<User,Error>)->Void) {
        do{
            var urlRequest = URLRequest(url: resourceURL)
            
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(userToSave)
            
            
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest){ data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
                    let jsonData = data else {
                        //completion(.failure(.responseProblem))
                        completion(.failure(APIError.responseProblem))
                        return
                }
                do{
              switch httpResponse.statusCode{
                                       
                                   case 200 ..< 300:
                                       
                                       print("se ha registrado correctamente")
                                       
                                   default:
                                       print("No se ha podido registrar")
                                      
                                   }
                }
            }
            
            dataTask.resume()
            
            
        }catch{
            completion(.failure(APIError.encodingProblem))
        }
    }
    func login(endpoint: String, parameters: [String: Any],completion: @escaping (Result<Int, Error>) -> Void){
             
            let baseURl = "https://superapi.netlify.app/"
            guard let url = URL(string: baseURl + endpoint) else {
                completion(.failure(NetworkingError.badUrl))
                return
            }
            
            var request = URLRequest(url: url)
            
     
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else{
            return
                
            }
            
            request.httpBody = httpBody
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let session = URLSession.shared
            
            let task = session.dataTask(with: request){(data, response, error) in
                
                DispatchQueue.main.async {
                    guard let unWrappedResponse = response as? HTTPURLResponse else{
                        completion(.failure(NetworkingError.badResponse))
                        return
                    }
                    
                    print(unWrappedResponse.statusCode)
                    
                    switch unWrappedResponse.statusCode{
                    case 200 ..< 300:
                        print("success")
                    
                    default:
                        print("failure")
                    }
                    
                    if let unwrappedError = error{
                        completion(.failure(unwrappedError))
                    }
                    if let unwrappedData = data{
                        
                        print(unwrappedData)
                        do {
                        
                            completion(.success(unWrappedResponse.statusCode))
                                
                        }catch {
                            completion(.failure(error))
                        }

                    }
                }
            }
            task.resume()
            
            
            
        }
        
    

//Obtener lista de usuarios
func getusers(endpoint: String , completion: @escaping (Result<[String], Error>) -> Void){
   

    guard let url = URL(string: "https://superapi.netlify.app/" + endpoint) else {
        completion(.failure(NetworkingError.badUrl))
        return
    }
    
    let request = URLRequest(url: url)
    
    let session = URLSession.shared.dataTask(with: request) { (data, response, error) in
        
       DispatchQueue.main.async {
            guard let unWrappedResponse = response as? HTTPURLResponse else{
                completion(.failure(NetworkingError.badResponse))
                return
        }

            print(unWrappedResponse.statusCode)
            print("succes get Users")

        }
//            if let response = response{
//                print(response)
//            }
        
        if let unwrappedData = data{
            print(unwrappedData)
        
            do{
                let json = try JSONSerialization.jsonObject(with: unwrappedData, options: [])
                print(json)

                if let usuarios = try? JSONDecoder().decode([String].self, from: unwrappedData){

                    completion(.success(usuarios))

               

                }
                            
            }catch{
                completion(.failure(error))
                print("estoy aqui")
                print(error)
            }
        }
    }
    session.resume()
    
}
}
enum APIError:Error {
    case responseProblem
    case decodingProblem
    case encodingProblem
}
