//
//  ErrorProducts_ViewController.swift
//  Teko Hiring Test App
//
//  Created by Bui Van Vi on 8/7/21.
//  Copyright © 2021 Bui Van Vi. All rights reserved.
//

import UIKit

class ErrorProductsViewController: UIViewController {
    
    //IBOutlet
    @IBOutlet weak var ErrorProductsTableView: UITableView!
    @IBOutlet weak var FirstPageButton: UIButton!
    @IBOutlet weak var PrevPageButton: UIButton!
    @IBOutlet weak var CurrentPageLabel: UILabel!
    @IBOutlet weak var ChangeCurrentPageButton: UIButton!
    @IBOutlet weak var NextPageButton: UIButton!
    @IBOutlet weak var LastPageButton: UIButton!
    @IBOutlet weak var SubmitButton: UIButton!
    
    //Tong so trang va trang dang hien thi
    var CurrentPage = 1
    var TotalPage = 1
    
    override func viewWillAppear(_ animated: Bool) {
        /*ShadowViewLeftConstraint.constant += view.bounds.width
        ShadowViewRightConstraint.constant -= view.bounds.width*/
    }
    
    override func viewDidAppear(_ animated: Bool) {
        /*ShadowViewLeftConstraint.constant -= view.bounds.width
        ShadowViewRightConstraint.constant += view.bounds.width
        UIView.animate(withDuration: 0.7,
                       delay: 1,
                     animations: { [weak self] in
                      self?.view.layoutIfNeeded()
        }, completion: nil)*/
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Init()
    }

    func Init() {
        
        //Khoi tao giao dien
        UIInit()
        
        //Khoi tao du lieu
        DataInit()
        
    }
    
    func UIInit() {
        
        //Bo goc cho nut thay doi so trang hien tai
        ChangeCurrentPageButton.layer.borderWidth = 0.2
        ChangeCurrentPageButton.layer.cornerRadius = 10
        
        //Bo tron goc cho cac nut phan trang
        FirstPageButton.layer.cornerRadius = FirstPageButton.frame.height / 2
        PrevPageButton.layer.cornerRadius = PrevPageButton.frame.height / 2
        NextPageButton.layer.cornerRadius = NextPageButton.frame.height / 2
        LastPageButton.layer.cornerRadius = LastPageButton.frame.height / 2
        //Bo tron goc cho nut gui du lieu
        SubmitButton.layer.cornerRadius = SubmitButton.frame.height / 2
        
        //An dau ngan cach giua cac TableViewCell
        ErrorProductsTableView.separatorStyle = .none
        
    }
    
    func DataInit() {
        
        //Doc du lieu danh sach san pham loi tu API cho truoc
        ReadProductData()
        
        //Doc du lieu danh sach mau tu API cho truoc
        ReadColorData()
        
    }
    
    func ReadProductData() {
        
        ReadDataFromURL(URLString: ErrorProducts_URLString) { (dict) in
            
            //Doc cac san pham loi
            for product in dict! {
                
                var color = 0
                if let colorNumber = product["color"] as? Int {
                    color = colorNumber
                }
                var info = ProductInfomation()
                info.name = "\(product["name"]!)"
                info.id = product["id"] as! Int
                info.errorDescription = "\(product["errorDescription"]!)"
                info.name = "\(product["name"]!)"
                info.sku = "\(product["sku"]!)"
                info.image = "\(product["image"]!)"
                info.color = color
                ErrorProductList.append(info)
                
            }
            
            //Reload lai bang
            DispatchQueue.main.async {
                self.ErrorProductsTableView.reloadData()
            }
            
        }
        
    }
    
    func ReadColorData() {
        
        ReadDataFromURL(URLString: Color_URLString) { (dict) in
            
            //Doc cac mau
            for product in dict! {
                
                var info = ColorInfomation()
                info.id = product["id"] as! Int
                info.name = "\(product["name"]!)"
                ColorList.append(info)
                
            }
            
            //Reload lai bang
            DispatchQueue.main.async {
                self.ErrorProductsTableView.reloadData()
            }
            
        }
        
    }
    
    func ReadDataFromURL(URLString: String, completion: @escaping ([[String:Any]]?) -> ()) {
        
        guard let requestUrl = URL(string:URLString) else { return }
        var request = URLRequest(url:requestUrl)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if error == nil, let usableData = data {
                
                let data = try? JSONSerialization.jsonObject(with: usableData, options:[])
                //Dictionary cua danh sach doc duoc tu API
                let dict = data as? [[String:Any]]
                
                //Tra ve ket qua
                completion(dict)
                
            }
        }
        task.resume()
        
    }
    
}

//Xu ly bang cac san pham loi
extension ErrorProductsViewController:UITableViewDelegate,UITableViewDataSource{
    //Tra ve so hang cua bang trong 1 trang
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //Mac dinh moi trang 10 hang
        var productNumberPerPage = ErrorProductList.count
        
        //Xu ly truong hop so hang nho hon 10
        /*if (CurrentPage * 10 > ErrorProductList.count) {
            
            productNumberPerPage = CurrentPage * 10 - ErrorProductList.count
            
        }*/
        return productNumberPerPage
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.ErrorProduct_TableViewCell) as! ErrorProductsTableViewCell
        
        cell.NameLabel.text = ErrorProductList[indexPath.row].name
        cell.ErrorLabel.text = ErrorProductList[indexPath.row].errorDescription
        cell.SKULabel.text = ErrorProductList[indexPath.row].sku
        let colorID = ErrorProductList[indexPath.row].color
        if (colorID - 1 >= 0 && colorID - 1 < ColorList.count) {
            
            cell.ColorLabel.text = ColorList[colorID - 1].name
            
        }
        else {
            
            cell.ColorLabel.text = "No color data"
            
        }

        return cell
        
    }
    
    //Chi dinh do cao cho 1 o
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //return UITableView.automaticDimension
        return 170
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}