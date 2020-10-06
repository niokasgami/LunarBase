package scenes;

import rm.core.Rectangle;
import rm.scenes.Scene_Map as RmScene_Map;
import windows.Window_HelloWorld;

/**
 * This class is demonstrating how we can alias as well as add a new property
 * to the default RPG Maker classes.
 *
 * As a LunaTechs style convention we name our class Scene_Map and we alias
 * the default RPG Maker class upon importing and extend from that.
 *
 * The real magic happens because of LunaTea's macro jsPatch, which will provide
 * use with the neccesary variables to use. The jsPatch macro is used in the
 * Main.hx file.
 *
 * All methods created in this class will have its very own alias variable
 * available instantly. Our alias variable will always be in this naming scheme
 * _RMClass_methodName.
 */
class Scene_Map extends RmScene_Map {
  public var helloWorldWindow: Window_HelloWorld;

  public override function createAllWindows() {
    /**
     * We call our alias variable which is generated by the jsPatch macro,
     * and because of this generation we have to use `untyped`.
     */
    untyped _Scene_Map_createAllWindows.call(this);
    /**
     * Here is how we ensure this window will be compatible with both RPG Maker MV
     * and RPG Maker MZ when we compile our plugins. When compilation starts it
     * will first compile the MV version of the plugin and when it hits this
     * compilation flag it will only include the codein the first portion of
     * this conditonal.
     * 
     * Be sure to look at `windows/Window_HelloWorld.hx` for more conditonal
     * compilation examples.
     */
    var rect: Rectangle = Main.params.helloWorldRect;
    #if compileMV
    this.helloWorldWindow = new Window_HelloWorld(Math.round(rect.x), Math.round(rect.y), Math.round(rect.width), Math.round(rect.height));
    #else
    this.helloWorldWindow = new Window_HelloWorld(rect);
    #end
    this.addWindow(this.helloWorldWindow);
  }
}