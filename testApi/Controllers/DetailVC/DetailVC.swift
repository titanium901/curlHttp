//
//  DetailVC.swift
//  testApi
//
//  Created by Yury Popov on 24/09/2019.
//  Copyright © 2019 Iurii Popov. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    var userEntry: Entry?
    var newSession: String!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let userEntry = userEntry {
            textView.text = userEntry.body
            saveButton.isHidden = true
        }
    }
    
    func showAllerCount() {
        let ac = UIAlertController(title: "Ошибка", message: "Сообщение содержит больше чем 200 символов", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
        present(ac, animated: true)
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
           self.view.endEditing(true)
           dismiss(animated: true, completion: nil)
       }
    
    @IBAction func saveAction(_ sender: UIButton) {
        guard textView.text.count <= 200 else { showAllerCount(); return }
        
        RequestManager.shared.addEntry(body: textView.text, newSession: RequestManager.session)
        guard let mainVC = storyboard?.instantiateViewController(withIdentifier: "MainVC") as? MainTableVC else { return }
        present(mainVC, animated: true, completion: nil)
        
    }
}
