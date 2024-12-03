//
//  ViewController.swift
//  SpheroStarte
//
//  Created by Al on 21/11/2024.
//

import UIKit

class ViewController: UIViewController {
    
    var impactCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("Searching")
        SharedToyBox.instance.searchForBoltsNamed(["SB-8C49"]) { err in
            if err == nil {
                print("Connected")
                
            } else {
                print("Connection failed: \(String(describing: err))")
            }
        }
    }
    
    
    // Fonction d'affichage de l'alerte
    func displayImpactAlert() {
        let alert = UIAlertController(title: "Impact détecté", message: "Un coup a été détecté sur le Sphero.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    // Configuration du SpheroSensorControlViewController avec la closure
    func setupSpheroController() {
        let spheroController = SpheroSensorControlViewController()
        spheroController.onImpactDetected = { [weak self] in
            self!.impactCount += 1
            print("Nombre d'impacts : \(self!.impactCount)")
            
            self?.displayImpactAlert()
        }
    }
    
    
}
