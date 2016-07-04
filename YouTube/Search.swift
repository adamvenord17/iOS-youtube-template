//
//  Search.swift
//  YouTube
//
//  Created by Adam Venord on 7/4/16.
//  Copyright © 2016 Adam Venord. All rights reserved.
//

protocol hideSearch {
    func hideSearchView(status : Bool)

}

import UIKit

class Search: UIView, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    //MARK: Properties
    
    lazy var searchView: UIView = {
       let sv = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.width, height: 68))
        sv.backgroundColor = UIColor.white()
        sv.alpha = 0
        return sv
    }()
    lazy var backgroundView: UIView = {
        let bv = UIView.init(frame: self.frame)
        bv.backgroundColor = UIColor.black()
        bv.alpha = 0
        return bv
    }()
    lazy var backButton: UIButton = {
       let bb = UIButton.init(frame: CGRect.init(x: 0, y: 20, width: 48, height: 48))
        bb.setBackgroundImage(UIImage.init(named: "cancel"), for: [])
        bb.addTarget(self, action: #selector(Search.dismiss), for: .touchUpInside)
        return bb
    }()
    lazy var searchField: UITextField = {
        let sf = UITextField.init(frame: CGRect.init(x: 48, y: 20, width: self.frame.width - 50, height: 48))
        sf.placeholder = "Seach on Youtube"
        sf.keyboardAppearance = .dark
        return sf
    }()
    lazy var tableView: UITableView = {
        let tv: UITableView = UITableView.init(frame: CGRect.init(x: 0, y: 68, width: self.frame.width, height: 288))
        tv.isHidden = true
        return tv
    }()
    var items = [String]()
    
    
    var delegate:hideSearch?
    
    //MARK: Methods
    
    func customization()  {
        self.addSubview(self.backgroundView)
        self.backgroundView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(Search.dismiss)))
        self.addSubview(self.searchView)
        self.searchView.addSubview(self.searchField)
        self.searchView.addSubview(self.backButton)
        self.tableView.register(searchCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.addSubview(self.tableView)
        self.tableView.tableFooterView = UIView()
        self.searchField.delegate = self
        

    }
    
    func animate()  {
        UIView.animate(withDuration: 0.3, animations: {
            self.backgroundView.alpha = 0.5
            self.searchView.alpha = 1
            self.searchField.becomeFirstResponder()
        })
    }
    
    
    func  dismiss()  {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.backgroundView.alpha = 0
            self.searchView.alpha = 0
            self.searchField.resignFirstResponder()
            }, completion: {(Bool) in
                self.delegate?.hideSearchView(status: true)
        })
    }
    
    //MARK: TextField Delegates
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (self.searchField.text == "" || self.searchField.text == nil) {
            self.items = []
            self.tableView.isHidden = true
        } else{
            
            let _  = URLSession.shared().dataTask(with: requestSuggestionsURL(text: self.searchField.text!), completionHandler: { (data, response, error) in
                do {
                    let json  = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSArray
                    self.items = json[1] as! [String]
                    DispatchQueue.main.async(execute: {
                        self.tableView.isHidden = false
                        self.tableView.reloadData()
                    })
                    
                    
                } catch _ {
                    print("Something wrong happened")
                }
                
            }).resume()
            
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    //MARK: TableView Delegates and Datasources
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! searchCell
        cell.itemLabel.text = items[indexPath.row]
        cell.backgroundColor = UIColor.rbg(r: 245, g: 245, b: 245)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.searchField.text = items[indexPath.row]
    }
    //MARK: Inits
    
    
   override init(frame: CGRect) {
        super.init(frame: frame)
        customization()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func layoutSubviews() {
        self.tableView.separatorStyle = .none

    }
}

class searchCell: UITableViewCell {
    
    lazy var itemLabel: UILabel = {
        let il: UILabel = UILabel.init(frame: CGRect.init(x: 48, y: 0, width: self.contentView.bounds.width - 48, height: self.contentView.bounds.height))
        il.textColor = UIColor.gray()
        return il
    }()
    
     override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "Cell")
        self.addSubview(itemLabel)
        
        
    }
    
    
   required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}






