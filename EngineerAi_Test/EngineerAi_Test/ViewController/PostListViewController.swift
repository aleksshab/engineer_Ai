//
//  PostListViewController.swift
//  EngineerAi_Test
//
//  Created by Александр  on 9/30/19.
//  Copyright © 2019 GoToInc. All rights reserved.
//

import UIKit


class PostListViewController: UIViewController {
    
    lazy var viewModel: PostListViewModel = {
        let vm = PostListViewModel.init(postListModel: PostListModel.init(page: 1))
        return vm
    }()
    
    lazy var tableView: UITableView = {
          let tv = UITableView(frame: .zero, style: .plain)
          tv.translatesAutoresizingMaskIntoConstraints = false
          tv.delegate = self
          tv.dataSource = self
          tv.register(PostTableViewCell.self)
          tv.tableFooterView = UIView()
          return tv
      }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      
        addConstraints()
        
        configVM()
        
    }
    
    private func configVM() {
        viewModel.didUpdate = { [weak self] in
            self?.tableView.reloadData()
        }
        
        viewModel.showMessage = {  [weak self] (message) in
        
            
        }
    }
    
    
    private func addConstraints() {
          view.addSubview(tableView)
        let horizontalConstraint = NSLayoutConstraint(item: tableView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
           let verticalConstraint = NSLayoutConstraint(item: tableView, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: tableView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: view.frame.size.width)
        let heightConstraint = NSLayoutConstraint(item: tableView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: view.frame.size.height)
    
           NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    
    


}


extension PostListViewController: UITableViewDelegate, UITableViewDataSource {
    
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemsCount
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: PostTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        if  let model = viewModel.item(at: indexPath.row) {
            cell.setupUIWith(model: model)
        }
        
         return cell
    }
}

