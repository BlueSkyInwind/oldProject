//
//  RenewalViewController.swift
//  fxdProduct
//
//  Created by admin on 2017/8/31.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

class RenewalViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{

    var leftTitleArr = ["逾期费用","使用溢缴金","应付金额","支付方式"]
    let cellId = "CellId"
    var headerView: CurrentInformationHeadView? = nil
    var contentArr : [String] = [String]()
    var supportBankListArr : [AnyObject] = [AnyObject]()
    let renewalTableView: UITableView = {
        
        let tableView = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.plain)
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        
        
//        tableView.backgroundColor = APPColor.shareInstance.homeTableViewColor
        return tableView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "续期费用"
        
        addBackItem()
        
        headerView = CurrentInformationHeadView()
        headerView?.moneyDescLabel?.text = "续期费用(元)"
        headerView?.backgroundColor = UI_MAIN_COLOR
        renewalTableView.tableHeaderView = headerView
        
        let footerView = FooterBtnView()
        footerView.frame = CGRect(x:0,y:0,width:_k_w,height:60)
        footerView.footerBtn?.setTitle("确认", for: .normal)
        footerView.footerBtnClosure = {
        
            print("确认按钮点击")
        }
        renewalTableView.tableFooterView = footerView
        
        
        renewalTableView.delegate = self
        renewalTableView.dataSource = self
        self.view.addSubview(renewalTableView)
        renewalTableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barTintColor = UI_MAIN_COLOR
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.backgroundImage(for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
       getData()

       getGatheringInformation_jhtml()
        
        
//        headerView.backClosure = {
//        
//            self.navigationController?.popViewController(animated: true)
//        }

    }
    
    
    func getData(){
    
        let repayMentViewModel = RepayMentViewModel()
        
        repayMentViewModel.setBlockWithReturn({ (returnValue) in
            
             let baseResult = try! BaseResultModel.init(dictionary: returnValue as! [AnyHashable : Any])
            
             let renewalModel = try! RenewalModel.init(dictionary: baseResult.data as! [AnyHashable : Any])
            
            self.headerView?.moneyLabel?.text = renewalModel.extensionFee!
            self.contentArr.append(renewalModel.overdueAmount!)
            self.contentArr.append(renewalModel.balanceFee!)
            self.contentArr.append(renewalModel.shallPayFee!)
            self.contentArr.append("")
            
            self.renewalTableView.reloadData()
            
        }) { 
            
        }
        repayMentViewModel.getCurrentRenewal(withStagingId: "34c563ab9f934a7396b4d8569622f56b")

    }
    func addBackItem(){
    
        let btn = UIButton.init(type: .system)
        let img = UIImage(named:"return_white")?.withRenderingMode(.alwaysOriginal)
        btn.setImage(img, for: .normal)
        btn.frame = CGRect(x:0,y:0,width:45,height:44)
        btn.addTarget(self, action: #selector(backToPrevious), for: .touchUpInside)
        let item = UIBarButtonItem.init(customView: btn)
        let spaceItem = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spaceItem.width = -15
        self.navigationItem.leftBarButtonItems = [spaceItem,item]
        
    }
    
    //返回按钮点击响应
    func backToPrevious(){
        self.navigationController!.popViewController(animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return leftTitleArr.count+1
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:CurrentInformationCell! = tableView.dequeueReusableCell(withIdentifier:cellId) as? CurrentInformationCell
        if cell == nil {
            cell = CurrentInformationCell.init(style: .default, reuseIdentifier: cellId)
        }
        cell.selectionStyle = .none
        if contentArr.count<2{
        
            return cell
        }
        if indexPath.row<leftTitleArr.count{
        
            cell.cellType = CurrentInfoCellType(cellType: .Default)
            cell.leftLabel?.text = leftTitleArr[indexPath.row]
            cell.rightLabel?.text = contentArr[indexPath.row]+"元"
            return cell
        }
        
        cell.cellType = CurrentInfoCellType(cellType: .Renewal)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    
    func getGatheringInformation_jhtml() -> Void {
        
        let checkBankViewModel = CheckBankViewModel()
        checkBankViewModel.setBlockWithReturn({ (returnValue) in
            
             let baseResult = try! BaseResultModel.init(dictionary: returnValue as! [AnyHashable : Any])
            if baseResult.flag == "0000"{
            
                let array = baseResult.result!
                
                for index in 0..<(array as! NSArray).count{
                
                    let bankList = try! SupportBankList.init(dictionary: (array as! NSArray)[index] as! [AnyHashable : Any])
                    self.supportBankListArr.append(bankList)
                }
                self.fatchCardInfo(supportBankListArr: self.supportBankListArr as NSArray)
            }else{
            
                MBPAlertView.sharedMBPText().showTextOnly(self.view, message: baseResult.msg)
            }
        }) { 
            
        }
        
        checkBankViewModel.getSupportBankListInfo("2")
    }
    
    
//    -(void)getGatheringInformation_jhtml:(void(^)(CardInfo *cardInfo))finish{
//    
//    CheckBankViewModel *checkBankViewModel = [[CheckBankViewModel alloc]init];
//    [checkBankViewModel setBlockWithReturnBlock:^(id returnValue) {
//    BaseResultModel * baseResult = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
//    if ([baseResult.flag isEqualToString:@"0000"]) {
//    NSArray * array  = (NSArray *)baseResult.result;
//    _supportBankListArr = [NSMutableArray array];
//    for (int i = 0; i < array.count; i++) {
//    SupportBankList * bankList = [[SupportBankList alloc]initWithDictionary:array[i] error:nil];
//    [_supportBankListArr addObject:bankList];
//    }
//    [self fatchCardInfo:_supportBankListArr success:^(CardInfo *cardInfo) {
//    finish(cardInfo);
//    }];
//    } else {
//    [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:baseResult.msg];
//    }
//    } WithFaileBlock:^{
//    
//    }];
//    [checkBankViewModel getSupportBankListInfo:@"2"];
//    }
    
    
    func fatchCardInfo(supportBankListArr : NSArray){
    
        let userDataVM = UserDataViewModel()
        userDataVM.setBlockWithReturn({ (returnValue) in
            
        }) { 
            
        }
        userDataVM.obtainGatheringInformation()
        
    }
//    - (void)fatchCardInfo:(NSMutableArray *)supportBankListArr success:(void(^)(CardInfo *cardInfo))finish
//    {
//    UserDataViewModel * userDataVM = [[UserDataViewModel alloc]init];
//    [userDataVM setBlockWithReturnBlock:^(id returnValue) {
//    UserCardResult *  userCardsModel = [UserCardResult yy_modelWithJSON:returnValue];
//    if([userCardsModel.flag isEqualToString:@"0000"]){
//    CardInfo *cardInfo = [[CardInfo alloc] init];
//    if (userCardsModel.result.count > 0) {
//    for(NSInteger j=0;j<userCardsModel.result.count;j++)
//    {
//    CardResult * cardResult = [userCardsModel.result objectAtIndex:0];
//    if([cardResult.card_type_ isEqualToString:@"2"]){
//    for (SupportBankList *banlist in _supportBankListArr) {
//    if ([cardResult.card_bank_ isEqualToString: banlist.bank_code_]) {
//    cardInfo.tailNumber = cardResult.card_no_;
//    cardInfo.bankName = banlist.bank_name_;
//    cardInfo.cardIdentifier = cardResult.id_;
//    cardInfo.phoneNum = cardResult.bank_reserve_phone_;
//    }
//    }
//    break;
//    }
//    }
//    }
//    finish(cardInfo);
//    }else{
//    [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:userCardsModel.msg];
//    }
//    } WithFaileBlock:^{
//    
//    }];
//    [userDataVM obtainGatheringInformation];
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
