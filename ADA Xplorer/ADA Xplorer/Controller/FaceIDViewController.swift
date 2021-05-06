//
//  FaceIDViewController.swift
//  ADA Xplorer
//
//  Created by Ricky Gideon Iskandar Daun on 05/05/21.
//

import UIKit
import LocalAuthentication

class FaceIDViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        checkFaceID()

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func tryAgain(_ sender: Any) {
        checkFaceID()
    }
    
    
    func checkFaceID(){
        let context = LAContext();
        var error: NSError? = nil
        let reason = "Please authorize with touch id!"
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason){ [weak self] success, error in
                DispatchQueue.main.async {
                    guard success , error == nil else{
                        return
                    }
                    
                    let homeViewController = self?.storyboard?.instantiateViewController(withIdentifier: "explorerPage") as? UITabBarController
                                self?.view.window?.rootViewController = homeViewController
                                self?.view.window?.makeKeyAndVisible()
                
            }
            
        }
    }else{
        print("cannot use")
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
}
