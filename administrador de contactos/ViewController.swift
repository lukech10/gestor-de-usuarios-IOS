//
//  loginController.swift
//  Gestión de Contactos
//
//  Created by user176683 on 2/4/21.
//

import Foundation
import UIKit
class loginViewController: UIViewController {

    
    
  
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
    let alertService = AlertService()
    let request = ApiRequest(endpoint: "")
   
    @IBOutlet weak var loginBoton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginBoton.layer.cornerRadius = 5
        
    }
    @IBAction func loginButton( sender: Any) {
        let name : String = emailTextField.text!
        let pass : String = passTextField.text!
        
        let parameters = ["user":name, "pass":pass]

        request.login(endpoint: "api/login", parameters: parameters) { [weak self] (result) in

            switch result{

            case.success(200):

                print("OK")
                self?.performSegue(withIdentifier: "userList", sender: nil)

            case.failure(let error):

                guard let alert = self?.alertService.alert(message: error.localizedDescription) else {
                        return
                        }
                self?.present(alert,animated: true)


            case.success(_):

                print("Usuario incorrecto")
            }

        }
    }

}
