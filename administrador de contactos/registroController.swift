//
//  registroController.swift
//  administrador de contactos
//
//  Created by alumnos on 03/02/2021.
//  Copyright © 2021 epikito studios. All rights reserved.
//
import Foundation
import UIKit



class registroController: UIViewController {
        
    //    let URL_SAVE_TEAM = "http://localhost:8888/rutasAPI/public/api/users/register"
    //
       
        
      
    //        // Do any additional setup after loading the view.
  
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passFild: UITextField!
    @IBOutlet weak var confirmPassField: UITextField!
    
    @IBOutlet weak var BotonRegistro: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BotonRegistro.layer.cornerRadius = 5
        
    }
   
   
    @IBAction func registrarUsuario(_ sender: Any) {
    
        if passFild.text! != confirmPassField.text! {
              print("contraseñas incorrectas")
              return
          }else{
              
            let userText = emailField.text!
            let passText = passFild.text!
              
              let user = User(user: userText, pass: passText)
              
              let postRequest = ApiRequest(endpoint: "api/register")
              
              postRequest.save(user, completion: {result in
                  switch result{
                  case .success(let user):
                      print("El siguiente usuario ha sido enviado:\(user.user) ")
                  case .failure(let error):
                      print("Ha ocurrido un error \(error)")
                  }
              })
              
          }

    

}
}
