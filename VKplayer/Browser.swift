//
//  Browser.swift
//  VKplayer
//
//  Created by Артём Горюнов on 19.10.2017.
//  Copyright © 2017 Артём Горюнов. All rights reserved.
//

import UIKit

class browser: UIViewController {

    @IBAction func backVC() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var webView: UIWebView!
    
    @IBOutlet weak var searchBar: UITextField!
    
    @IBAction func search(_ sender: UIButton) {
        if let text = searchBar.text {
            let url = URL(string: text)!
            let request = URLRequest(url: url)
            self.webView.loadRequest(request)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Назад", style: .done, target: self, action: #selector (backVC))
            navigationItem.title = "Browser"
        }
    
}
