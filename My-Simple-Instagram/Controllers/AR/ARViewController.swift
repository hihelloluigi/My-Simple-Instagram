//
//  ARViewController.swift
//  My-Simple-Instagram
//
//  Created by Luigi Aiello on 04/11/17.
//  Copyright © 2017 Luigi Aiello. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

/*
    Una volta identificato un piano sarà possibile posizionare toccando lo schermo un cubo che avrà come facce l'immagine scelta.
 */
@available(iOS 11.0, *)
class ARViewController: UIViewController {

    //MARK:- Properties
    var sceneView: ARSCNView!
    var image: UIImage!
    
    //MARK:- Override
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configurationUI()
        registerTapGestureRecognizers()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal

        sceneView.session.run(configuration)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.session.pause()
    }

    //MARK:- Setup
    private func setup() {
        
        self.sceneView = ARSCNView(frame: self.view.frame)
        self.view.addSubview(self.sceneView)
        
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        sceneView.delegate = self
        sceneView.showsStatistics = true
        
        let scene = SCNScene()
        sceneView.scene = scene
    }
    private func configurationUI() {
        let button = UIButton(frame: CGRect(x: 10, y: 40, width: 60, height: 60))
        button.setBackgroundImage(#imageLiteral(resourceName: "ic_x_rounded"), for: .normal)
        button.addTarget(self, action: #selector(closeDidTap), for: .touchUpInside)
        
        self.view.addSubview(button)
    }
    //MARK:- Helpers
    @objc func closeDidTap(sender: UIButton!) {
        self.dismiss(animated: true, completion: nil)
    }
    private func registerTapGestureRecognizers() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    @objc private func tapped(recognizer: UIGestureRecognizer) {
        guard let sceneView = recognizer.view as? ARSCNView else {
            print("Scene is not a SCNView")
            return
        }
        let touchLocation = recognizer.location(in: sceneView)
        let hitTestResult = sceneView.hitTest(touchLocation, types: .existingPlaneUsingExtent)
        
        if !hitTestResult.isEmpty {
            guard let hitResult = hitTestResult.first else {
                return
            }
            addBox(hitResult: hitResult)
        }
    }
    private func addBox(hitResult: ARHitTestResult) {
        
        let boxGeometry = SCNBox(width: 0.2, height: 0.2, length: 0.2, chamferRadius: 0)
        let imageMaterial = SCNMaterial()
        imageMaterial.diffuse.contents = image
        boxGeometry.materials = [imageMaterial, imageMaterial, imageMaterial, imageMaterial, imageMaterial, imageMaterial]
        let cube = SCNNode(geometry: boxGeometry)

        cube.position = SCNVector3(hitResult.worldTransform.columns.3.x, hitResult.worldTransform.columns.3.y + Float(boxGeometry.height/2), hitResult.worldTransform.columns.3.z)
        
        self.sceneView.scene.rootNode.addChildNode(cube)
    }
}

//MARK:- ARKit delegate
@available(iOS 11.0, *)
extension ARViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        print("DidAdd")
    }
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        print("DidUpdate")
    }
}
