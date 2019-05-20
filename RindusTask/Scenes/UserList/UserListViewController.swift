//
//  UserListViewController.swift
//  RindusTask
//
//  Created by Francisco Navarro Aguilar on 19/5/19.
//  Copyright © 2019 Francisco Navarro Aguilar. All rights reserved.
//

import UIKit
import Core
import Models

protocol UserListViewControllerInterface {
  func displayUsers(viewModel: UserListModels.GetUsers.ViewModel)
  func displaySelectedUser(viewModel: UserListModels.SelectUser.ViewModel)
}

final class UserListViewController: UIViewController, UserListViewControllerInterface {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var errorView: UIView!
  
  var interactor: UserListInteractorInterface!
  var router: UserListRouterInterface!
  
  var users: [User] = [] {
    didSet {
      tableView.reloadData()
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    configure()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Contacts"
    let nib = UINib(nibName: UserListTableViewCell.identifier, bundle: nil)
    setupErrorView()
    tableView.register(nib, forCellReuseIdentifier: UserListTableViewCell.identifier)
    getUsers()
  }
  
  private func getUsers() {
    interactor.getUsers(request: UserListModels.GetUsers.Request())
  }
  
  private func setupErrorView() {
    let tap = UITapGestureRecognizer(target: self, action: #selector(didTapErrorView(_:)))
    errorView.addGestureRecognizer(tap)
  }
  
  @objc func didTapErrorView(_ sender: UITapGestureRecognizer) {
    getUsers()
  }
  
  func displayUsers(viewModel: UserListModels.GetUsers.ViewModel) {
    switch viewModel.content {
    case .success(let data):
      errorView.isHidden = true
      hideLoader()
      users = data
    case .loading:
      showLoader()
      errorView.isHidden = true
    case .error:
      hideLoader()
      showErrorAlert()
      errorView.isHidden = false
    default:
      break
    }
  }
  
  func displaySelectedUser(viewModel: UserListModels.SelectUser.ViewModel) {
    router.navigateToProfile()
  }
}

extension UserListViewController {
  fileprivate func configure() {
    let interactor = UserListInteractor()
    let presenter = UserListPresenter()
    let router = UserListRouter()
    
    interactor.presenter = presenter
    interactor.userWorker = UserRestWorker()
    presenter.viewController = self
    
    router.viewController = self
    self.router = router
    self.interactor = interactor
    
  }
}

extension UserListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return UIView()
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let user = users[indexPath.row]
    interactor.setSelectedUser(request: UserListModels.SelectUser.Request(user: user))
  }
}

extension UserListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return users.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: UserListTableViewCell.identifier) as! UserListTableViewCell
    let user = users[indexPath.row]
    cell.delegate = self
    cell.updateUI(text: user.name, description: user.company.name)
    return cell
    
  }
}

extension UserListViewController: UserListTableViewCellDelegate {
  
  func didTapEmailButton(in cell: UserListTableViewCell) {
    let indexPath = tableView.indexPath(for: cell)
    guard let row = indexPath?.row else { return }
    let email = users[row].email
    System.send(email)
  }
  
}
