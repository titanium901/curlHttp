//
//  ViewController.swift
//  testApi
//
//  Created by Yury Popov on 24/09/2019.
//  Copyright © 2019 Iurii Popov. All rights reserved.
//

import UIKit

class MainTableVC: UIViewController {

    var session: String?
    
    @IBOutlet weak var tableView: UITableView!
    
    var userEntrys: UserEntrys?
    var userDates = [Entry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        if session == RequestManager.session {
            RequestManager.shared.newSession()
            session = RequestManager.session
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print(#function)
        if RequestManager.session != nil {
          getData()
        }
        
    }
    
    
    func getData() {
        print(#function)
        var requestManager = RequestManager()
        requestManager.getRequest(newSession: RequestManager.session) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
                self?.connectionFailAlert()
            case .success(let usersEntrys):
                self?.userEntrys = usersEntrys
                self!.userDates = usersEntrys.data[0]
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    func connectionFailAlert() {
        let ac = UIAlertController(title: "Ошибка соединения", message: "Проверьте соединение с сетью", preferredStyle: .alert)
        let reloadButton = UIAlertAction(title: "Обновить", style: .default) { [weak self] (_) in
            self?.getData()
        }
        let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        ac.addAction(cancel)
        ac.addAction(reloadButton)
        present(ac, animated: true)
    }
    
    @IBAction func addButtonAction(_ sender: UIButton) {
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "detailVC") as? DetailVC else { return }
        present(detailVC, animated: true, completion: nil)
    }
}
