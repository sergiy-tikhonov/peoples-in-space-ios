//
//  AustronautInfoViewController.swift
//  PeopleInSpace
//
//  Created by Serhii on 05.05.2024.
//

import UIKit

class AustronautInfoViewController: UIViewController {

    
    private var austronaut: Austronaut? = nil
    
    @IBOutlet weak var labelTitle: UILabel!
    
    @IBOutlet weak var imageAvatar: UIImageView!
    
    @IBOutlet var textInfo: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setConstraints()

        if let austronaut = austronaut {
            labelTitle.text = austronaut.name
            textInfo.text = austronaut.personBio
            imageAvatar.kf.setImage(with: URL(string: austronaut.personImageUrl))
        }
        
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            labelTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            labelTitle.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            imageAvatar.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 20),
            imageAvatar.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            imageAvatar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            imageAvatar.widthAnchor.constraint(equalTo: imageAvatar.heightAnchor)
        ])
        NSLayoutConstraint.activate([
            textInfo.topAnchor.constraint(equalTo: imageAvatar.bottomAnchor, constant: 10),
            textInfo.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            textInfo.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            textInfo.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
    }
  
    init(austronaut: Austronaut) {
        self.austronaut = austronaut
        super.init(nibName: "AustronautInfo", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
          super.init(coder: coder)
      }

}
