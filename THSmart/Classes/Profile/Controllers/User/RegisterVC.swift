//
//  RegisterVC.swift
//  THSmart
//
//  Created by YueAndy on 2018/3/29.
//  Copyright © 2018年 pingan. All rights reserved.
//

import UIKit

class RegisterVC: BaseViewController {

    @IBOutlet weak var tf_phone: UITextField!
    @IBOutlet weak var btn_nextStep: UIButton!
    
    var viewModel: RegisterVM = RegisterVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.keyWindow?.backgroundColor = UIColor(red: 0, green: 0.48, blue: 1, alpha: 1)
    }
    
    override func viewDidLayoutSubviews() {
        btn_nextStep.setGradualBackground(cgColors: kBlueGradientColors)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        UIApplication.shared.keyWindow?.backgroundColor = UIColor.clear
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func nextStepAction(_ sender: UIButton) {
        
        if Validate.phoneNum(tf_phone.text ?? "").isRight {
            viewModel.requestData(phone: tf_phone.text!) {
                let nextVC = RegisterVC1()
                nextVC.phone = self.tf_phone.text!
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        }
    }
}

