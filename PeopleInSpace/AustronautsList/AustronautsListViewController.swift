//
//  AustronautsListViewController.swift
//  PeopleInSpace
//
//  Created by Serhii on 24.04.2024.
//

import UIKit
import Kingfisher
import Foundation

class AustronautsListViewController: UITableViewController {
    
    @IBOutlet weak var screenTitle: UINavigationItem!
    
    let austronautCellIdentifier = "austronautCellIdentifier"
    let apiService = ApiService.shared
    let dbService = DatabaseService.shared
    
    var austronauts: [Austronaut] = []
    var spinner = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = L10n.AustronautList.title
        self.initSpinner()
        self.loadAustronauts()
    }
    
    private func showOfflineModeNotification() {
        let alert = UIAlertController(title: L10n.OfflineMode.title, message: L10n.OfflineMode.message, preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
    }
    
    private func initSpinner() {
        view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func showSpinner() {
        spinner.startAnimating()
    }
    
    private func hideSpinner() {
        self.spinner.stopAnimating()
    }
    
    private func loadAustronauts() {
        self.showSpinner()
        Task {
            do {
                self.austronauts = try await apiService.loadAustronauts().people
                dbService.saveAustronauts(austronauts: self.austronauts)
            } catch {
                self.showOfflineModeNotification()
                self.austronauts = dbService.readAustronauts()
            }
            DispatchQueue.main.async {
                self.hideSpinner()
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return austronauts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: austronautCellIdentifier, for: indexPath) as! AustronautCell
        let austronaut = austronauts[indexPath.row]
        cell.labelName.text = austronaut.name
        cell.labelMission.text = austronaut.craft
        cell.avatarImageView.kf.setImage(with: URL(string: austronaut.personImageUrl))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedPath = tableView.indexPathForSelectedRow else { return }
        self.navigateToAustronautScreen(austronaut: austronauts[selectedPath.row])
    }
    
    private func navigateToAustronautScreen(austronaut: Austronaut) {
        let austronautInfoViewController = AustronautInfoViewController(austronaut: austronaut)
        
        navigationController?.pushViewController(austronautInfoViewController, animated: true)
        
    }

}
