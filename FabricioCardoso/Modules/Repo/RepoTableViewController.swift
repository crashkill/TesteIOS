//
//  RepoTableViewController.swift
//  FabricioCardoso
//
//  Created by Fabricio Cardoso on 20/02/17.
//  Copyright © 2017 Fabricio Cardoso. All rights reserved.
//

import UIKit
import SDWebImage

class RepoTableViewController: UITableViewController {

    var list: Itens = Itens()
    var repo: Repo?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Show Loading
        SVProgressHUD.show()
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            RepoSearch.search(page: "1", completionHandler: {tempPesquisa,fail in
                
                DispatchQueue.main.async {
                    
                    // Hide Loading
                    SVProgressHUD.dismiss()
                    
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
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (self.list.repo?.count != nil ? (self.list.repo?.count)! : 0)
    
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // TODO Custom CELL
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let iten:Repo = self.list.repo![indexPath.row]
        
        cell.textLabel?.text = iten.name
        cell.detailTextLabel?.text = iten.full_name
        
        // TODO acertar imagem
        // cell.imageView.sd_setImage(with: URL(string: iten.avatar_url!), placeholderImage: UIImage(named: "placeholder.png"))

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.repo = self.list.repo![indexPath.row]
        
        self.performSegue(withIdentifier: "segueDetail", sender: self)
        
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc:PullRequestTableViewController = segue.destination as! PullRequestTableViewController
        
        vc.repo = self.repo
        
        
    }
    
}
