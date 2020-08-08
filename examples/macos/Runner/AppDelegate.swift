import Cocoa
import FlutterMacOS

public extension NSView {
  @objc func originalIsOpaque() -> Bool {
    return true;
  }
  
  @objc func isOpaqueMethodToCall() -> Bool {
    if self.className != "FlutterView" {
      return originalIsOpaque();
    }
    
    let openglView: NSOpenGLView = self as! NSOpenGLView
    var opacity: GLint = 0
    let opacityPointer: UnsafePointer<GLint> = UnsafePointer(&opacity)
    openglView.openGLContext?.setValues(opacityPointer, for: .surfaceOpacity)
    
    return false;
  }
}

@NSApplicationMain
class AppDelegate: FlutterAppDelegate {
  override init() {
    super.init()
    swizzleNSViewOpaqueImplementation();
  }
  
  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return true
  }
  
  override func applicationWillFinishLaunching(_ notification: Notification) {
    super.applicationWillFinishLaunching(notification)
  }
  
  override func applicationDidFinishLaunching(_ notification: Notification) {
    self.mainFlutterWindow.isOpaque = false
    self.mainFlutterWindow.backgroundColor = NSColor.clear
    self.mainFlutterWindow.alphaValue = 1
  }
  
  // transparency not supported https://github.com/flutter/flutter/issues/59969
  @objc func swizzleNSViewOpaqueImplementation() {
    let aClass: AnyClass? = NSClassFromString("FlutterView")
    let originalMethod = class_getInstanceMethod(aClass, Selector("isOpaque"))
    let placeholderMethod = class_getInstanceMethod(aClass, #selector(NSView.originalIsOpaque))
    if let originalMethod = originalMethod, let placeholderMethod = placeholderMethod {
      // switch implementation..
      method_exchangeImplementations(originalMethod, placeholderMethod)
    }
    
    let isOpaqueMethod = class_getInstanceMethod(aClass, Selector("isOpaque"))
    let isOpaqueMethodToCall = class_getInstanceMethod(aClass, #selector(NSView.isOpaqueMethodToCall))
    if let isOpaqueMethod = isOpaqueMethod, let isOpaqueMethodToCall = isOpaqueMethodToCall {
      // switch implementation..
      method_exchangeImplementations(isOpaqueMethod, isOpaqueMethodToCall)
    }
  }
}
