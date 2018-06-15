//
//  CommonProtocol .swift
//  fxdProduct
//
//  Created by admin on 2017/12/28.
//  Copyright © 2017年 dd. All rights reserved.
//

import Foundation

protocol NibLoadProtocol {
    
}

extension NibLoadProtocol where Self : UIView{
    static func loadNib(_ nibNmae :String? = nil) -> Self{
        return Bundle.main.loadNibNamed(nibNmae ?? "\(self)", owner: nil, options: nil)?.first as! Self
    }
}






protocol Particleable {
    
}

extension Particleable where Self : UIViewController {
    /// 增加粒子效果 position 粒子发射器位置
    func addParticle(_ position : CGPoint = CGPoint(x: UIScreen.main.bounds.width * 0.85, y: UIScreen.main.bounds.height - 30)) {
        let emitter = CAEmitterLayer()
        emitter.position = position
        emitter.preservesDepth = true
        var cells = [CAEmitterCell]()
        for i in 0..<10 {
            let cell = CAEmitterCell()
            cell.birthRate = Float(arc4random_uniform(4)) + 3
            cell.lifetime = 5
            cell.lifetimeRange = 3
            cell.scale = 0.7
            cell.scaleRange = 0.3
            cell.emissionLongitude = CGFloat(-(Double.pi/2))
            cell.emissionRange = CGFloat(M_PI_4 * 0.6)
            cell.velocity = 90
            cell.velocityRange = 50
            cell.spin = CGFloat(M_PI_2)
            cell.contents = UIImage(named: "good\(i)_30x30")?.cgImage
            cells.append(cell)
        }
        emitter.emitterCells = cells
        view.layer.addSublayer(emitter)
    }
//
    /// 删除粒子效果
    func removeParticle() {
        view.layer.sublayers?.filter({ $0.isKind(of: CAEmitterLayer.self) }).last?.removeFromSuperlayer()
    }
}





