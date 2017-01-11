package com
{
	import com.unity.IUnityContentHost;
	import com.unity.UnityContentLoader;
	import com.unity.UnityLoaderParams;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	
	/**
	 * ...
	 * @author lenglang
	 */
	public class Main extends Sprite implements IUnityContentHost
	{	
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			this.LoadUnityContent();
			// entry point
		}
		private var _unityLoader:UnityContentLoader;
		private function LoadUnityContent():void
		{
			var params:UnityLoaderParams = new UnityLoaderParams(false, 800, 500, false);
			_unityLoader = new UnityContentLoader("cube.swf", this, params, false);
			_unityLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, OnUnityContentLoaderProgress);
			_unityLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, OnUnityContentLoaderComplete);
			_unityLoader.loadUnity();
		}
		private function OnUnityContentLoaderProgress(e:ProgressEvent):void 
		{
			trace(e.bytesLoaded/e.bytesTotal,e.bytesTotal);
		}
		private function OnUnityContentLoaderComplete(e:Event):void 
		{
			addChild(_unityLoader);
			//_unityLoader.unityContent.setContentHost(this);
		}
		public function unityInitStart():void
		{
			trace("start");
		}
		public function unityInitComplete():void
		{
			//_unityLoader.unityContent.sendMessage("Avatar", "ChangeSpeed", {responder:this});
			trace("complete");
		}
		private function OnContentLoaded(event:Event):void
		{}
		
	}
	
}