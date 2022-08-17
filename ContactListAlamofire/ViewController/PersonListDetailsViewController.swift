//
//  PersonListDetailsViewController.swift
//  ContactListAlamofire
//
//  Created by Aleksandr F. on 12.04.2022.
//

import UIKit
import AlamofireImage

class PersonListDetailsViewController: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var website: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    var result: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setValues(with: result)
    }
    
    override func viewWillLayoutSubviews() {
        userImageView.layer.cornerRadius = userImageView.bounds.height / 2
    }
    
    private func setValues(with user: User) {
        name.text = "Name: \(result.name.first) \(result.name.last)"
        location.text = "City: \(result.location.city)"
        email.text = "Email: \(result.email)"
        phone.text = "Phone: \(result.phone)"
        website.text = "Login: \(result.login.username)"
        
        guard let imageURL = URL(string: user.picture.large) else { return }
        userImageView.af.setImage(withURL: imageURL)
    }
}

