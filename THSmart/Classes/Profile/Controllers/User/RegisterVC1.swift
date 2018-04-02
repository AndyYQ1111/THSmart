//
//  RegisterVC1.swift
//  THSmart
//
//  Created by YueAndy on 2018/3/29.
//  Copyright © 2018年 pingan. All rights reserved.
//

import UIKit

class RegisterVC1: BaseViewController {

    @IBOutlet weak var tf_code: UITextField!
    @IBOutlet weak var btn_nextStep: UIButton!
    
    var phone:String = ""
    
    let viewModel:RegisterVM = RegisterVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        btn_nextStep.setGradualBackground(cgColors: kBlueGradientColors)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func nextStepAction(_ sender: UIButton) {
        if tf_code.text?.count ?? 0 > 0 {
            
            let paraDic = ["smsIdCode":tf_code.text!,"userPhoneNum":phone,"timeStamp":Date.timeIntervalBetween1970AndReferenceDate] as [String : Any]
            
            viewModel.checkCode(paraDic: paraDic, finishCallback: {
                
                let nextVC = RegisterVC2()
                nextVC.phone = self.phone
                self.navigationController?.pushViewController(nextVC, animated: true)
            })
        }else {
            view.makeToast("验证码不能为空")
        }
    }
}


