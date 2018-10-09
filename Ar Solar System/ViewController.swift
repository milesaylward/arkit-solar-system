//
//  ViewController.swift
//  Ar Solar System
//
//  Created by Miles Aylward on 10/8/18.
//  Copyright © 2018 Miles Aylward. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {
    let config = ARWorldTrackingConfiguration()
    @IBOutlet weak var sceneView: ARSCNView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.session.run(config)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let mercury = planet(geometry: SCNSphere(radius: 0.07), diff: UIImage(named: "Mercury Diffuse")!, spec: nil, emission: nil, norm: nil, position: SCNVector3(0.5, 0, 0), rings: false)
        let mercuryParent = SCNNode();
        mercuryParent.position = SCNVector3(0,0, -3)
        
        let venus = planet(geometry: SCNSphere(radius: 0.08), diff: UIImage(named: "Venus Surface")!, spec: nil, emission: UIImage(named: "Venus Atmosphere"), norm: nil, position: SCNVector3(0.8, 0,0), rings: false)
        let venusParent = SCNNode();
        venusParent.position = SCNVector3(0,0, -3)
        
        let earth = planet(geometry: SCNSphere(radius: 0.08), diff: UIImage(named: "Earth Day")!, spec: UIImage(named: "Earth Specular")!, emission: UIImage(named: "Earth Emission")!, norm: UIImage(named: "Earth Normal")!, position: SCNVector3(1.1,0,0), rings: false)
        let earthMoon = planet(geometry: SCNSphere(radius: 0.025), diff: UIImage(named: "Moon Diffuse")!, spec: nil, emission: nil, norm: nil, position: SCNVector3(0.15, 0, 0), rings: false)
        let earthMoonParent = SCNNode()
        earthMoonParent.eulerAngles = SCNVector3(0,0, 45.degreeToRadians)
        earthMoonParent.addChildNode(earthMoon)
        let action = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreeToRadians), z: 0, duration: Double(4))
        let forever = SCNAction.repeatForever(action)
        earthMoonParent.runAction(forever)
        earth.addChildNode(earthMoonParent)
        let earthParent = SCNNode();
        earthParent.position = SCNVector3(0,0, -3)
        
        let mars = planet(geometry: SCNSphere(radius: 0.07), diff: UIImage(named: "Mars Diffuse")!, spec: nil, emission: nil, norm: nil, position: SCNVector3(1.4, 0, 0), rings: false)
        let marsParent = SCNNode();
        marsParent.position = SCNVector3(0,0, -3)
        
        let jupiter = planet(geometry: SCNSphere(radius: 0.17), diff: UIImage(named: "Jupiter Diffuse")!, spec: nil, emission: nil, norm: nil, position: SCNVector3(1.8, 0, 0), rings: false)
        let jupiterParent = SCNNode();
        jupiterParent.position = SCNVector3(0,0, -3)
        
        let saturn = planet(geometry: SCNSphere(radius: 0.15), diff: UIImage(named: "Saturn Surface")!, spec: nil, emission: nil, norm: nil, position: SCNVector3(2.3, 0,0), rings: true)
        let saturnParent = SCNNode();
        saturnParent.position = SCNVector3(0,0, -3)
        
        let uranus = planet(geometry: SCNSphere(radius: 0.12), diff: UIImage(named: "Uranus Diffuse")!, spec: nil, emission: nil, norm: nil, position: SCNVector3(2.8, 0, 0), rings: false)
        let uranusParent = SCNNode();
        uranusParent.position = SCNVector3(0,0, -3)
        
        let neptune = planet(geometry: SCNSphere(radius: 0.11), diff: UIImage(named: "Neptune Diffuse")!, spec: nil, emission: nil, norm: nil, position: SCNVector3(3.3, 0, 0), rings: false)
        let neptuneParent = SCNNode();
        neptuneParent.position = SCNVector3(0,0, -3)
        
        let sun = createSun()
        mercuryParent.addChildNode(mercury)
        venusParent.addChildNode(venus)
        earthParent.addChildNode(earth)
        marsParent.addChildNode(mars)
        jupiterParent.addChildNode(jupiter)
        saturnParent.addChildNode(saturn)
        uranusParent.addChildNode(uranus)
        neptuneParent.addChildNode(neptune)
        
        self.sceneView.autoenablesDefaultLighting = true
        self.sceneView.scene.rootNode.addChildNode(sun);
        self.sceneView.scene.rootNode.addChildNode(earthParent);
        self.sceneView.scene.rootNode.addChildNode(marsParent);
        self.sceneView.scene.rootNode.addChildNode(mercuryParent);
        self.sceneView.scene.rootNode.addChildNode(jupiterParent);
        self.sceneView.scene.rootNode.addChildNode(saturnParent);
        self.sceneView.scene.rootNode.addChildNode(venusParent);
        self.sceneView.scene.rootNode.addChildNode(uranusParent);
        self.sceneView.scene.rootNode.addChildNode(neptuneParent);
        
        createAnimatiom(scale: 1.0, el: sun)
        createAnimatiom(scale: 0.38, el: mercuryParent)
        createAnimatiom(scale: 0.72, el: venusParent)
        createAnimatiom(scale: 1.0, el: earthParent)
        createAnimatiom(scale: 1.52, el: marsParent)
        createAnimatiom(scale: 5.2, el: jupiterParent)
        createAnimatiom(scale: 9.58, el: saturnParent)
        createAnimatiom(scale: 19.14, el: uranusParent)
        createAnimatiom(scale: 30.20, el: neptuneParent)
    }
    func createAnimatiom (scale: Float, el: SCNNode!) {
        let action = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreeToRadians), z: 0, duration: Double(8 * scale))
        let forever = SCNAction.repeatForever(action)
        el.runAction(forever)
    }
    func planet(geometry: SCNGeometry, diff: UIImage, spec: UIImage?, emission: UIImage?, norm: UIImage?, position: SCNVector3, rings: Bool?) -> SCNNode {
        let node = SCNNode(geometry: geometry)
        node.geometry?.firstMaterial?.diffuse.contents = diff
        node.geometry?.firstMaterial?.specular.contents = spec
        node.geometry?.firstMaterial?.emission.contents = emission
        node.geometry?.firstMaterial?.normal.contents = norm
        if rings! {
            let saturnAndRings = SCNNode()
            let ring = SCNNode(geometry: SCNTube(innerRadius: 0.16, outerRadius: 0.19, height: 0.01))
            let outerRing = SCNNode(geometry: SCNTube(innerRadius: 0.21, outerRadius: 0.26, height: 0.01))
            ring.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "Saturn Ring")
            outerRing.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "Saturn Ring")
            saturnAndRings.position = position;
            saturnAndRings.addChildNode(node)
            saturnAndRings.addChildNode(ring)
            saturnAndRings.addChildNode(outerRing)
            saturnAndRings.eulerAngles = SCNVector3(0, 0, 30.degreeToRadians)
            return saturnAndRings
        }
        node.position = position
        return node;
    }
    
    func createSun () -> SCNNode {
        let sun = SCNNode(geometry: SCNSphere(radius: 0.3))
        sun.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "Sun Diffuse")
        sun.position = SCNVector3(0,0,-3)
        return sun;
    }


}

extension Int {
    var degreeToRadians : Double {return Double(self) * .pi/180}
}

