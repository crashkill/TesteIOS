//
//  RepoTableViewController.swift
//  FabricioCardoso
//
//  Created by Fabricio Cardoso on 20/02/17.
//  Copyright © 2017 Fabricio Cardoso. All rights reserved.
//

import UIKit

class RepoTableViewController: UITableViewController {

    var list: Itens = Itens()
    var repo: Repo?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        DispatchQueue.global(qos: .userInitiated).async {
            
            RepoSearch.search(page: "1", completionHandler: {tempPesquisa,fail in
                
                DispatchQueue.main.async {
                    
                    if(fail != nil){
                        
                        self.list = tempPesquisa
                        self.tableView.reloadData()
                        
                    }else{
                        
                        // TODO Alert
                        
                    }
                }
            })
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (self.list.repo?.count != nil ? (self.list.repo?.count)! : 0)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let iten:Repo = self.list.repo![indexPath.row]
        
        cell.textLabel?.text = iten.name
        cell.detailTextLabel?.text = iten.full_name
        cell.imageView?.image = iten.avatar_url

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.repo = self.list.repo![indexPath.row]
        
        self.performSegue(withIdentifier: "segueDetail", sender: self)
        
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc:PullRequestTableViewController = segue.destination as! PullRequestTableViewController
        
        vc.repo = self.repo
        
        
    }
    
}
