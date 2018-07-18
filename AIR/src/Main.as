package
{
import com.myflashlab.air.extensions.dependency.OverrideAir;
import com.myflashlab.air.extensions.zip.*;

import flash.desktop.NativeApplication;
import flash.desktop.SystemIdleMode;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.AntiAliasType;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import flash.ui.Multitouch;
import flash.ui.MultitouchInputMode;
import flash.ui.Keyboard;
import flash.events.KeyboardEvent;
import flash.events.InvokeEvent;
import flash.filesystem.File;

import com.doitflash.text.modules.MySprite;
import com.doitflash.starling.utils.list.List;
import com.doitflash.consts.Direction;
import com.doitflash.consts.Orientation;
import com.doitflash.consts.Easing;

import com.luaye.console.C;

import com.doitflash.mobileProject.commonCpuSrc.DeviceInfo;

/**
 * ...
 * @author Hadi Tavakoli - 7/17/2018 11:10 AM
 */

public class Main extends Sprite
{
	// ----------------------------------------------------------------------------------------------------------------------- vars

	private var _ex:ZipManager;

	private const BTN_WIDTH:Number = 150;
	private const BTN_HEIGHT:Number = 100;
	private const BTN_SPACE:Number = 2;
	private var _txt:TextField;
	private var _body:Sprite;
	private var _list:List;
	private var _numRows:int = 1;

	// ----------------------------------------------------------------------------------------------------------------------- constructor

	public function Main():void
	{


		Multitouch.inputMode = MultitouchInputMode.GESTURE;
		NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE, handleActivate, false, 0, true);
		NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE, onInvoke, false, 0, true);
		NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN, handleKeys, false, 0, true);

		stage.addEventListener(Event.RESIZE, onResize);
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;

		C.startOnStage(this, "`");
		C.commandLine = false;
		C.commandLineAllowed = false;
		C.x = 100;
		C.width = 500;
		C.height = 250;
		C.strongRef = true;
		C.visible = true;
		C.scaleX = C.scaleY = DeviceInfo.dpiScaleMultiplier;

		_txt = new TextField();
		_txt.autoSize = TextFieldAutoSize.LEFT;
		_txt.antiAliasType = AntiAliasType.ADVANCED;
		_txt.multiline = true;
		_txt.wordWrap = true;
		_txt.embedFonts = false;
		_txt.htmlText = "<font face='Arimo' color='#333333' size='20'><b>Zip Manager ANE V"+ZipManager.VERSION+" (Android+iOS)</b></font>";
		_txt.scaleX = _txt.scaleY = DeviceInfo.dpiScaleMultiplier;
		this.addChild(_txt);

		_body = new Sprite();
		this.addChild(_body);

		_list = new List();
		_list.holder = _body;
		_list.itemsHolder = new Sprite();
		_list.orientation = Orientation.VERTICAL;
		_list.hDirection = Direction.LEFT_TO_RIGHT;
		_list.vDirection = Direction.TOP_TO_BOTTOM;
		_list.space = BTN_SPACE;

		init();
	}

	// ----------------------------------------------------------------------------------------------------------------------- private

	private function onInvoke(e:InvokeEvent):void
	{
		NativeApplication.nativeApplication.removeEventListener(InvokeEvent.INVOKE, onInvoke);
	}

	private function handleActivate(e:Event):void
	{
		NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
	}

	private function handleKeys(e:KeyboardEvent):void
	{
		if(e.keyCode == Keyboard.BACK)
		{
			e.preventDefault();
			NativeApplication.nativeApplication.exit();
		}
	}

	private function onResize(e:*=null):void
	{
		if (_txt)
		{
			_txt.width = stage.stageWidth * (1 / DeviceInfo.dpiScaleMultiplier);

			C.x = 0;
			C.y = _txt.y + _txt.height + 0;
			C.width = stage.stageWidth * (1 / DeviceInfo.dpiScaleMultiplier);
			C.height = 300 * (1 / DeviceInfo.dpiScaleMultiplier);
		}

		if (_list)
		{
			_numRows = Math.floor(stage.stageWidth / (BTN_WIDTH * DeviceInfo.dpiScaleMultiplier + BTN_SPACE));
			_list.row = _numRows;
			_list.itemArrange();
		}

		if (_body)
		{
			_body.y = stage.stageHeight - _body.height;
		}
	}

	//====================================================================================== init Extension
	
	private function myDebuggerDelegate($ane:String, $class:String, $msg:String):void
	{
		trace($ane+"("+$class+") "+$msg);
	}
	
	private function init():void
	{
		// remove this line in production build or pass null as the delegate
		OverrideAir.enableDebugger(myDebuggerDelegate);
		
		// initialize the extension
		_ex = new ZipManager();
		_ex.addEventListener(ZipManagerEvent.START, onStart);
		_ex.addEventListener(ZipManagerEvent.ERROR, onError);
		_ex.addEventListener(ZipManagerEvent.PROGRESS, onProgress);
		_ex.addEventListener(ZipManagerEvent.COMPLETED, onComplete);

		// copy the zip to File.applicationStorageDirectory first
		var src:File = File.applicationDirectory.resolvePath("zipTest.zip");
		var dis:File = File.applicationStorageDirectory.resolvePath("zipManager_ANE/zipTest.zip");
		if(dis.exists) dis.deleteFile();
		src.copyTo(dis);
		
		// ----------------------

		var btn1:MySprite = createBtn("1) to unzip");
		btn1.addEventListener(MouseEvent.CLICK, unzip);
		_list.add(btn1);

		function unzip(e:MouseEvent):void
		{
			var zipFile:File = File.applicationStorageDirectory.resolvePath("zipManager_ANE/zipTest.zip");
			var unzipLocation:File = File.applicationStorageDirectory.resolvePath("zipManager_ANE/unzipLocation");
			if(unzipLocation.exists) unzipLocation.deleteDirectory(true);

			C.log("a bunch of demo images will be extracted just as a demo for you to see how fast this works!");

			_ex.unzip(zipFile, unzipLocation);
		}

		// ----------------------

		var btn2:MySprite = createBtn("cancel unzip");
		btn2.addEventListener(MouseEvent.CLICK, cancelUnzip);
		_list.add(btn2);

		function cancelUnzip(e:MouseEvent):void
		{
			C.log(_ex.cancelUnzipping(true));
		}

		// ----------------------

		var btn3:MySprite = createBtn("2) to zip");
		btn3.addEventListener(MouseEvent.CLICK, zip);
		_list.add(btn3);

		function zip(e:MouseEvent):void
		{
			var zipFile:File = File.applicationStorageDirectory.resolvePath("zipManager_ANE/zipTest.zip");
			if(zipFile.exists) zipFile.deleteFile();
			var zipDir:File = File.applicationStorageDirectory.resolvePath("zipManager_ANE/unzipLocation");

			_ex.zip(zipFile, zipDir);
		}

		// ----------------------

		var btn4:MySprite = createBtn("cancel zip");
		btn4.addEventListener(MouseEvent.CLICK, cancelzip);
		_list.add(btn4);

		function cancelzip(e:MouseEvent):void
		{
			C.log(_ex.cancelZipping(true));
		}

		onResize();
	}

	private function onStart(e:ZipManagerEvent):void
	{
		C.log("zip process started...");
	}

	private function onError(e:ZipManagerEvent):void
	{
		C.log("zip process ERROR: " + e.param.msg);
	}

	private function onProgress(e:ZipManagerEvent):void
	{
		C.log("zip Progress = " + e.param.perc + "%");
	}

	private function onComplete(e:ZipManagerEvent):void
	{
		C.log("[zip process finished]");
	}










































	private function createBtn($str:String):MySprite
	{
		var sp:MySprite = new MySprite();
		sp.addEventListener(MouseEvent.MOUSE_OVER,  onOver);
		sp.addEventListener(MouseEvent.MOUSE_OUT,  onOut);
		sp.addEventListener(MouseEvent.CLICK,  onOut);
		sp.bgAlpha = 1;
		sp.bgColor = 0xDFE4FF;
		sp.drawBg();
		sp.width = BTN_WIDTH * DeviceInfo.dpiScaleMultiplier;
		sp.height = BTN_HEIGHT * DeviceInfo.dpiScaleMultiplier;

		function onOver(e:MouseEvent):void
		{
			sp.bgAlpha = 1;
			sp.bgColor = 0xFFDB48;
			sp.drawBg();
		}

		function onOut(e:MouseEvent):void
		{
			sp.bgAlpha = 1;
			sp.bgColor = 0xDFE4FF;
			sp.drawBg();
		}

		var format:TextFormat = new TextFormat("Arimo", 16, 0x666666, null, null, null, null, null, TextFormatAlign.CENTER);

		var txt:TextField = new TextField();
		txt.autoSize = TextFieldAutoSize.LEFT;
		txt.antiAliasType = AntiAliasType.ADVANCED;
		txt.mouseEnabled = false;
		txt.multiline = true;
		txt.wordWrap = true;
		txt.scaleX = txt.scaleY = DeviceInfo.dpiScaleMultiplier;
		txt.width = sp.width * (1 / DeviceInfo.dpiScaleMultiplier);
		txt.defaultTextFormat = format;
		txt.text = $str;

		txt.y = sp.height - txt.height >> 1;
		sp.addChild(txt);

		return sp;
	}

	// -----------------------------------------------------------------------------------------------------------------------
}

}