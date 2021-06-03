//
//  ViewController.swift
//  BitGallery
//
//  Created by Khagesh Patel on 2/6/21.
//

import UIKit

class BGRepositoryListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    var repository: BGRepository?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Repositories"
        shouldHideNextButton(isHide: true)
        fetchData()
    }
    
    func fetchData(urlString: String = "\(kBaseUrl)\(kRepositoriesAPI)") {
        showLoader()
        BGNetworkController().getBitbucketRepositories(urlString: urlString) { response, error in
            self.hideLoader()
            if let response = response {
                if self.repository == nil {
                    self.repository = response
                } else if let values = response.values {
                    self.repository?.pagelen = response.pagelen
                    self.repository?.next = response.next
                    self.repository?.values?.append(contentsOf: values)
                }
                DispatchQueue.main.async {
                    self.shouldHideNextButton(isHide: self.repository?.next == nil)
                    self.tableView.reloadData()
                }
            } else {
                //Show Alert
                self.showAlert(message: error?.localizedDescription ?? kSorryMessage)
            }
        }
    }
    
    func showAlert(message: String) {
        DispatchQueue.main.async {
            let alertVC = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    func shouldHideNextButton(isHide: Bool) {
        if isHide {
            self.heightConstraint.constant = 0.0
        } else {
            self.heightConstraint.constant = 60.0
        }
    }
    
    @IBAction func nextAction(_ sender: Any) {
        if let nextUrlString = self.repository?.next {
            fetchData(urlString: nextUrlString)
        }
    }
    
    func showLoader() {
        nextButton.isEnabled = false
        DispatchQueue.main.async {
            self.activityIndicatorView.startAnimating()
        }
    }
    
    func hideLoader() {
        DispatchQueue.main.async {
            self.nextButton.isEnabled = true
            self.activityIndicatorView.stopAnimating()
        }
    }
}

extension BGRepositoryListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "BGRepositoryDetailTableViewController") as? BGRepositoryDetailTableViewController
        vc?.value = repository?.values?[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}

extension BGRepositoryListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repository?.values?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? BGRepositoryTableViewCell
        cell?.loadData(data: self.repository?.values?[indexPath.row])
        return cell!
    }
}
