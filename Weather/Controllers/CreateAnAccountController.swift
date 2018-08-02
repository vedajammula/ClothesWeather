//
//  CreateAnAccountController.swift
//  Weather
//
//  Created by veda jammula on 8/1/18.
//  Copyright © 2018 Veda Jammula. All rights reserved.
//

import UIKit

class CreateAnAccountController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.performSegue(withIdentifier: "LoginView", sender: self)
    }
}
