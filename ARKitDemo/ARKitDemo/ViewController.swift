//
//  ViewController.swift
//  ARKitDemo
//
//  Created by TWTD on 2017/10/9.
//  Copyright © 2017年 TWTD. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var IBOutlet: ARSCNView!
    override func viewDidLoad() {
        super.viewDidLoad()
       addBox()
        addTapGestureToIBoutlet()
    }
    
    func addBox() {
        let box = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        
        let boxNode = SCNNode()
        boxNode.geometry = box
        boxNode.position = SCNVector3(0,0,-0.2)
        
        
        IBOutlet.scene.rootNode.addChildNode(boxNode)
        
    }
    
    func addTapGestureToIBoutlet(){
        
        let tapOne = UITapGestureRecognizer(target: self, action:  #selector(ViewController.IBOutletDidtap(withGestureRecognizer:)) )
        //通过numberOfTouchesRequired属性设置触摸点数，比如设置2表示必须两个手指触摸时才会触发
        tapOne.numberOfTapsRequired = 1
        //通过numberOfTapsRequired属性设置点击次数，单击设置为1，双击设置为2
        tapOne.numberOfTouchesRequired = 1
        //双击
      
      
        
      
        
        IBOutlet.addGestureRecognizer(tapOne)
    }
    
    func addBox(x:Float = 0,y:Float = 0,z:Float = -0.2){
        let box = SCNBox.init(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        
        let boxNode  = SCNNode()
        boxNode.geometry = box
        boxNode.position = SCNVector3(x,y,z)
        IBOutlet.scene.rootNode.addChildNode(boxNode)
        
    }
    
    @objc func IBOutletDidtap(withGestureRecognizer  recognizer: UITapGestureRecognizer){
        print("点击了小方块")
        let taplocation = recognizer.location(in: IBOutlet)
        let hitTestResult = IBOutlet.hitTest(taplocation)
        guard let node = hitTestResult.first?.node else {
            let hitTestResultsWithfuturePoint = IBOutlet.hitTest(taplocation, types: .featurePoint)
            if let hitpoint = hitTestResultsWithfuturePoint.first {

                let translation = hitpoint.worldTransform.translation
                
                 addBox(x: translation.x, y: translation.y, z: translation.z)
            }
            return
        }
       node.removeFromParentNode()
        
    }
  
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        IBOutlet.session.run(configuration)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        IBOutlet.session.pause()
    }
    

}

