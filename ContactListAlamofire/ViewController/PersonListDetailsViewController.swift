//
//  PersonListDetailsViewController.swift
//  ContactListAlamofire
//
//  Created by Aleksandr F. on 12.04.2022.
//

import UIKit

class PersonListDetailsViewController: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var website: UILabel!
    
    var personInfo:Contact!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    private func updateUI() {
        //        title = personInfo.title
        //        name.text = "  ➤  Name: \(personInfo.title ?? "")"
        //        username.text = "  ➤  User name: \(personInfo.username ?? "")"
        email.text = " ✉️ : \(personInfo.email ?? "")"
        phone.text = " 📞 : \(personInfo.phone ?? "")"
        //        website.text = " 🖥 : \(personInfo.website ?? "")"
    }
}
