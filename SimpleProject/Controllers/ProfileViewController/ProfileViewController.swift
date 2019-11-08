//
//  ProfileViewController.swift
//  SimpleProject
//
//  Created by Harut Mikichyan on 11/8/19.
//  Copyright © 2019 Harut Mikichyan. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    static let user = UserData(name: "h", password: "h", score: 0)
    
    //MARK: - Outlets
    @IBOutlet weak var userImageOutlet: UIImageView!
    @IBOutlet weak var userNameOutlet: UILabel!
    @IBOutlet weak var scoreOutlet: UILabel!
    
    var observation: NSKeyValueObservation!
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameOutlet.text = ProfileViewController.user.name
        
        logOutButtonAddObserver()
        observingUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    //MARK: - Actions
    @IBAction func startMemoryGame(_ sender: UIButton) {
        let vc = MemoryGameViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func moreButtonTapped(_ sender: UIButton) {
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (alertAction) in
            NotificationCenter.default.post(name: Notification.Name.popViewControllerNotification, object: nil)
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    //MARK: - Observer Methods
    private func logOutButtonAddObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(popViewControllerNotification), name: Notification.Name.popViewControllerNotification, object: nil)
    }
    
    @objc private func popViewControllerNotification() {
        navigationController?.popViewController(animated: true)
    }
    
    private func observingUser() {
        observation = ProfileViewController.user.observe(\.score, options: [.new, .old]) { [weak self] (object, change) in
            guard let self = self else { return }//[weak self]
            if change.oldValue != change.newValue {
                self.scoreOutlet.text = "Score: \(ProfileViewController.user.score)"
            }
        }
    }
}

extension Notification.Name {
    static let popViewControllerNotification = Notification.Name(rawValue: "popNotification")
}
