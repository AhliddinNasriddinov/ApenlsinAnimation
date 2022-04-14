//
//  MainVC.swift
//  ApelsinAnimation
//
//  Created by Ahliddin Nasriddinov on 13.04.2022.
//

import UIKit

class MainVC: UIViewController {

    
    @IBOutlet weak var sumLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    
    var sideViewKorinyaptimi = true
    override func viewDidLoad() {
        super.viewDidLoad()
        register()
    }
    // register tableview
    func register () {
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "DefaultTableViewCell", bundle: nil), forCellReuseIdentifier: "DefaultTableViewCell")
    }


}


// delegate tableview self
extension MainVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 18
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultTableViewCell", for: indexPath)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y > -45 && sideViewKorinyaptimi{
            
            UIView.animate(withDuration: 0.1) {
                
//                self.sideView.transform = .init(translationX: 60, y: -60)
                
            }
            sideViewKorinyaptimi = false
            
        }else if scrollView.contentOffset.y < -45  && !sideViewKorinyaptimi{
            
            UIView.animate(withDuration: 0.1) {
                
//                self.sideView.transform = .identity
            }
            sideViewKorinyaptimi = true
        }
        
        //--------------------------------------------------------
        //bu yer tezda pasga scroll qilganda avvalgi xolatga qaytaradi
        
        if scrollView.contentOffset.y < -45{
            UIView.animate(withDuration: 0.1) {
//                self.lbl.transform = .identity
            }
        }
        
        //bu tekshiradi, qachonki tableviewni top inseti tugab ya'ni 0 bo'lib 45 dan o'tganda qaytarib navbarni ichiga qo'yadi, xuddiki tepadan bounce bo'lgandek bolishini ta'minlaydi
        
        if scrollView.contentOffset.y > 45{
            UIView.animate(withDuration: 0.2) {
//                self.lbl.transform = .init(translationX: 80, y: -60)
            }
            
            //agar pasdagi if blokdagi -45 ni o'zgartirish kerak bo'lsa  barcha 45 larni shu songa o'zgartirish kerak. 45 va -45 lar bir xil bo'lishi kerak, Masalan: -45 edi if da, transformda esa 45, shuni -100 ga o'zgartirilsa 45 ham 100 bo'ladi
            
        }else if scrollView.contentOffset.y > -45 {
            if sumLabel.frame.minX <= 65 {
                sumLabel.transform = .init(translationX: (45 + scrollView.contentOffset.y) / 3, y: -1 * (45 + scrollView.contentOffset.y))
            }
            if scrollView.contentOffset.y > 0 {
                sumLabel.transform = .init(translationX: (45 / 3) + (scrollView.contentOffset.y / 3), y: -1 * (45 + scrollView.contentOffset.y))
                if tableViewTopConstraint.constant > 0 {
                    tableViewTopConstraint.constant = tableViewTopConstraint.constant - scrollView.contentOffset.y
                    
                }
                
            }
            
        }
        
        //--------------------------------------------------------
        
    }
    
    
    
    
    
    
    
}
