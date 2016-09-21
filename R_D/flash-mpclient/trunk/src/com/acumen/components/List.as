package com.acumen.components
{
	import flash.events.*;
	import flash.display.*;
	
	import com.bit101.components.*;

	public class List extends Panel
	{
		private var _array:Array;
		private var _list:Array;
		private var _selected:Array;
	
		public var maxHeight:Number=100;
		public var listItemHeight:Number=15;
		public var scroller:VSlider;
	
		public function List(parent:DisplayObjectContainer = null,x:Number=0,y:Number=0,a:Array=null):void
		{
			
			super(parent,x, y);
			scroller=new VSlider(this, 0, 0);
			scroller.addEventListener(Event.CHANGE,onScroll);
			addEventListener(MouseEvent.MOUSE_WHEEL,onMouseWheel)
			setScroller();
			array=a;
			
		}
				
		public override function setSize(w:Number,h:Number):void
		{
			super.setSize(w,h);
			setScroller();
		}
		
		public function setScroller(position:Number=0):void
		{
			if(scroller)
			{
				scroller.value=position;
				scroller.setSize(10,height);
				scroller.draw();
				scroller.x=width-scroller.width;
				scroller.y=0;
				scroller.maximum=content.height-height;
				scroller.value=scroller.maximum+content.y;
				scroller.visible=(scroller.maximum>0);
				onScroll();
			}
		}
		
		public function onMouseWheel(e:MouseEvent):void
		{
			scroller.value=Math.min(scroller.maximum, scroller.value+e.delta*15);
			onScroll(e);
		}
		
		public function onScroll(e:Event=null):void
		{
			content.y=int(scroller.value-scroller.maximum);
		}
		
		public function set array(a:Array):void
		{
			selected=[];
			if(!a)a=[];
			_array=a;
			clearListItems();
			for(var i:uint=0;i<_array.length;i++)
			{
				var item:ListItem=createItem(0,_list.length*listItemHeight,_array[i].toString(),_list.length);
				if(item)_list.push(content.addChild(item));
			}
			//throw new Error(_list.length);
			//setSize(300,Math.min(maxHeight, listItemHeight*i));
			//draw();
			
			setScroller(0);
			
		}
		
		public function createItem(x:Number,y:Number,label:String,i:uint):ListItem
		{
			return new ListItem(this,0,i*15,_array[i].toString(),i);
		}
		
		public function clearListItems():void
		{
			for each(var item:ListItem in _list)
			{
				content.removeChild(item);
			}
			_list=[];
		}
		
		public function getListItem(index:int):Object
		{
			return _list[index];
		}
		
		public function getArrayItem(index:int):Object
		{
			return _array[index];
		}
		
		protected function deselectListItem(item:ListItem):void
		{
			var selected:Array=selected;
			selected[item.index]=null;
			this.selected=selected;
		}

		protected function selectListItem(a:*):void
		{
			if(a is ListItem){
				a=[a];
			}
			else if(a is int)
			{
				if(_list[a])a=[_list[a]];
				else a=[];
			}
			
			var list:Array=a;
			for each(var item:ListItem in list)
			{
				var selected:Array=selected;
				selected[item.index]=item;
				this.selected=selected;
			}
		}

		
		public function set selected(a:Array):void
		{
			
			if(_selected)for each(var item:ListItem in _selected)
			{
				if(item)item.selected=false;
			}
			for each(item in a)
			{
				if(item)item.selected=true;				
			}
			_selected=a;
		}
		
		public function get list():Array
		{
			return _list.concat();
		}
		
		public function get selected():Array
		{
			return _selected.concat();
		}

	}
	

}