//
//  ActionSheetLauncher.swift
//  Twitter Clone App
//
//  Created by as on 10/6/20.
//  Copyright © 2020 nawaf. All rights reserved.
//

import UIKit


protocol ActionSheetLauncherDelegate:class {
    func didselect(option:ActionSheetOptions)
}

private let reuseIdentifier = "ActionSheetCell"

class ActionSheetLauncher : NSObject {
    
    
    //MARK: - Properties
    private let user: User
    private var window : UIWindow?
    weak var delegate : ActionSheetLauncherDelegate?
    let tableView = UITableView()
    private lazy var viewModel = ActionSheetViewModel(user:user)
    private var tableViewHeight : CGFloat?

    
    private lazy var blackView : UIView = {
        let view = UIView()
        view.alpha  = 0
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
    
    
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleDismissal))
        view.addGestureRecognizer(tap)
        
        return view
    }()
    
    private lazy var cancelButton : UIButton = {
        
        let btn = UIButton(type: .system)
        btn.setTitle("Cancel", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = UIColor.systemGroupedBackground
        btn.addTarget(self, action: #selector(cancelBtnTapped), for: .touchUpInside)
        btn.layer.cornerRadius = 10
        return btn
        
    }()
    
    private lazy var footerView : UIView = {
       let view = UIView()
        view.addSubview(cancelButton)
        cancelButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        cancelButton.anchor(left:view.leftAnchor,right:view.rightAnchor,paddingLeft: 12,paddingRight: 12)
        cancelButton.centerY(inView: view)
        
        return view
        
        
    }()
    
    


    //MARK: - Lifecycle
    
    init(user:User){
        self.user = user
        super.init()
        self.configureTableView()
    }


    //MARK: - API


    //MARK: - Selectors
    
    @objc func handleDismissal() {
        UIView.animate(withDuration: 0.5) {
                self.blackView.alpha = 0
                self.tableView.frame.origin.y += 300
                
            }
    }
    
    @objc func cancelBtnTapped() {
        handleDismissal()
    }

    //MARK: - helpers
    
    func showTableView(_ shouldShow: Bool) {
        guard let window = window else {return}
        guard let height = tableViewHeight else {return}
        
        let y = shouldShow ? window.frame.height - height : window.frame.height
        tableView.frame.origin.y = y
    }
    
    func show() {
        
        guard let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow}) else {return}
        self.window = window
        
        window.addSubview(blackView)
        blackView.frame = window.frame
        
        window.addSubview(tableView)
        let height = CGFloat(viewModel.options.count*60) + 100
        self.tableViewHeight = height
        tableView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: tableViewHeight!)
        
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 1
            self.showTableView(true)
            
        }
        
        
    }
    
    func configureTableView() {
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        tableView.rowHeight = 60
        tableView.isScrollEnabled = false
        tableView.layer.cornerRadius = 10
        
        tableView.register(ActionSheetCell.self, forCellReuseIdentifier: reuseIdentifier)
    }

    

}

extension ActionSheetLauncher : UITableViewDelegate{
 
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let options = viewModel.options[indexPath.row]
        //delegate?.didselect(option: options)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.blackView.alpha = 0
            self.showTableView(false)
        }) { (_) in
            self.delegate?.didselect(option: options)
        }
    }
}

extension ActionSheetLauncher : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ActionSheetCell
        cell.option = viewModel.options[indexPath.row]
        return cell
    }
    
    
    
}
