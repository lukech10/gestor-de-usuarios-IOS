import Foundation
import UIKit



class listViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var user:[User] = []
    

    @IBOutlet weak var tableview: UITableView!
    let alertService = AlertService()
    let request = ApiRequest(endpoint: "")
    var listas : [String] = []
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
        
      

                request.getusers(endpoint: "api/users") { [weak self] ( result ) in
            
                 switch result{

                 case.success(let lista):
                     print("imprimiendo desde getusers")
                  
                    self!.listas = lista
                    
                    print(self!.listas)
                    DispatchQueue.main.async {
                        self!.tableview.reloadData()
                    }
                   
                   /* for i in lista {
                        self!.listas.append(i)
                       
                    }*/
                    
                    //print(type(of: self!.listas))



                    //print(self!.listas)
                    
                  
                 case.failure(let error):

                     guard let alert = self?.alertService.alert(message: error.localizedDescription) else {
                             return
                             }
                     self?.present(alert,animated: true)

                     break



             }
           

    }
        
    }
    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        return listas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cellid") as! userRow
        print(listas[indexPath.row]+"hola")
        cell.name.text = listas[indexPath.row]
     
      return cell
    }
    
     
  
}

