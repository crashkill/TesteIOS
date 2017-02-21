//
//  PullRequestTableViewController.swift
//  FabricioCardoso
//
//  Created by Fabricio Cardoso on 20/02/17.
//  Copyright © 2017 Fabricio Cardoso. All rights reserved.
//

import UIKit

class PullRequestTableViewController: UITableViewController {

    var list: [PullRequest] = [PullRequest]()
    var repo: Repo?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Show Loading
        SVProgressHUD.show()
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            PullRequestSearch.search(repo: self.repo!, completionHandler: {tempPesquisa,fail in
                
                DispatchQueue.main.async {
                    
                    // Hide Loading
                    SVProgressHUD.dismiss()
                    
                    if(fail != nil){
                        
                        // TODO Verificar pq não esta retornando o objeto
                        self.list = tempPesquisa
                        self.tableView.reloadData()
                        
                    }else{
                        
                        // TODO Alert
                        
                    }
                }
            })
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (self.list.count)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // TODO Custom CELL
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let pull:PullRequest = self.list[indexPath.row]
        
        cell.textLabel?.text = pull.title
        cell.detailTextLabel?.text = pull.user?.login
        
        return cell
    }

}
