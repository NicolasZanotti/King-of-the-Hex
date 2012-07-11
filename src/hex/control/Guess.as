package hex.control
{
	import hex.model.ApplicationState;
	import hex.model.Player;
	import hex.model.RandomColor;
	import hex.ui.Drag;
	import hex.ui.Patch;
	import hex.ui.Target;

	import stoletheshow.control.Controllable;
	import stoletheshow.control.Controller;
	import stoletheshow.display.helpers.DisplayListHelper;
	import stoletheshow.model.Color;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.utils.setTimeout;

	/**
	 * @author Nicolas Zanotti
	 */
	public class Guess extends MovieClip implements Controllable
	{
		public var ct:LinkedController;
		public var colorPatch:Patch;
		public var b1:Drag, b2:Drag, b3:Drag, b4:Drag, b5:Drag;
		public var t1:Target, t2:Target, t3:Target
		public var tfPlayer:TextField;
		protected var _drags:Array, _targets:Array, _bounds:Rectangle
		protected var drag:Drag;

		public function Guess()
		{
			ct = new LinkedController(this);
		}

		/* ------------------------------------------------------------------------------- */
		/*  Controller methods */
		/* ------------------------------------------------------------------------------- */
		public function init():void
		{
			// Configure components
			var helper:DisplayListHelper = new DisplayListHelper(this)

			_drags = helper.getChildrenOfType(Drag)
			_targets = helper.getChildrenOfType(Target)
			_bounds = createDragBounds()
	
			ct.locator.players.currentPlayer.given = colorPatch.color = ct.locator.players.currentPlayer.nextColor;
			trace('ct.locator.playerState.given.hexadecimal: ' + (ct.locator.players.currentPlayer.given.hexadecimal));
			
			var values:Array = createArrayOfValues(colorPatch.color)
			var valuesWithRandom:Array = fillWithRandomValues(values, _drags.length)

			applyColorValuesToButtonTexts(valuesWithRandom);

			tfPlayer.text = ct.locator.players.currentPlayer.name != null ? ct.locator.players.currentPlayer.name + ", guess the color" : "";

			// Configure listeners
			for each (var drag:Drag in _drags)
			{
				ct.events.add(drag, MouseEvent.MOUSE_DOWN, onDragMouseDown);
				ct.events.add(drag, MouseEvent.MOUSE_UP, onDragMouseUp);
			}
		}

		public function dispose():void
		{
			_drags = null
			_targets = null
		}

		/* ------------------------------------------------------------------------------- */
		/*  Event handlers */
		/* ------------------------------------------------------------------------------- */
		protected function onDragMouseDown(event:MouseEvent):void
		{
			event.stopPropagation()

			drag = event.target.parent as Drag;

			ct.events.add(drag, Event.ENTER_FRAME, onEnterFrame)

			if (drag.isPlacedOn != null)
			{
				toggleBinding(false, drag, drag.isPlacedOn)
			}

			setChildIndex(drag, numChildren - 1);
			drag.startDrag(true, _bounds);
		}

		protected function onDragMouseUp(event:MouseEvent):void
		{
			event.stopPropagation()
			
			drag.stopDrag()

			var target:Target, hasHit:Boolean;

			for each (target in _targets)
			{
				hasHit = drag.hitTestObject(target)

				if (hasHit)
				{
					onDragLand(drag, target)
					break;
				}
			}

			if (!hasHit)
			{
				drag.animateToOriginalPosition();
			}

			// Reset hover states
			for each (target in _targets)
			{
				target.hovering = false
			}

			// Clean up
			ct.events.remove(drag, Event.ENTER_FRAME, onEnterFrame)
			drag = null;

			if (placedItems >= 3)
			{
				stage.dispatchEvent(new Event(Controller.INTERFACE_LOCK));
				setTimeout(onChoiceMade, 1000)
			}
		}

		protected function onEnterFrame(event:Event):void
		{
			for each (var target:Target in _targets)
			{
				target.hovering = drag.hitTestObject(target)
			}
		}

		protected function onDragLand(drag:Drag, target:Target):void
		{
			if (target.isOccupiedBy != null)
			{
				drag.animateToOriginalPosition()
				return;
			}

			drag.x = target.x;
			drag.y = target.y;

			toggleBinding(true, drag, target);

			setChildIndex(drag, 0)
			setChildIndex(target, 0)
		}

		protected function onChoiceMade():void
		{
			stage.dispatchEvent(new Event(Controller.INTERFACE_UNLOCK));

			var player:Player = ct.locator.players.currentPlayer;

			player.chosen = new Color("0x" + t1.isOccupiedBy.text + t2.isOccupiedBy.text + t3.isOccupiedBy.text);

			var isCorrectChoice:Boolean = player.chosen.value == player.given.value

			if (isCorrectChoice)
			{
				player.incrementCorrectAnswers();
				ct.locator.appState.state = ApplicationState.CHOICE_RIGHT;
			}
			else
			{
				player.incrementWrongAnswers();
				ct.locator.appState.state = ApplicationState.CHOICE_WRONG;
			}
		}

		/* ------------------------------------------------------------------------------- */
		/*  Helper methods */
		/* ------------------------------------------------------------------------------- */
		protected function toggleBinding(bind:Boolean, drag:Drag, target:Target):void
		{
			drag.isPlacedOn = bind ? target : null;
			target.isOccupiedBy = bind ? drag : null;
		}

		protected function createDragBounds():Rectangle
		{
			return new Rectangle(b1.width / 2, b1.height / 2, stage.stageWidth - b1.width, stage.stageHeight - b1.height);
		}

		protected function createArrayOfValues(color:Color):Array
		{
			var s:String = color.hexadecimal
			var values:Array = [];

			values[0] = s.substr(0, 2)
			values[1] = s.substr(2, 2)
			values[2] = s.substr(4, 2)

			return values;
		}

		protected function fillWithRandomValues(values:Array, amountNeeded:int):Array
		{
			while (values.length < amountNeeded)
			{
				values = values.concat(createArrayOfValues(new RandomColor()))
			}

			values.length = amountNeeded;

			return randomize(values);
		}

		protected function randomize(arr:Array):Array
		{
			var rand:Array = [];
			while (arr.length > 0)
			{
				rand.push(arr.splice(Math.round(Math.random() * (arr.length - 1)), 1)[0]);
			}
			return rand;
		}

		protected function applyColorValuesToButtonTexts(values:Array):void
		{
			if (values.length != _drags.length) throw new Error("Buttons and values length don't match");

			for (var i:int = 0, n:int = _drags.length, b:Drag; i < n; i++)
			{
				b = _drags[i];
				b.text = values[i];
			}
		}

		/* ------------------------------------------------------------------------------- */
		/*  Getters and setters */
		/* ------------------------------------------------------------------------------- */
		protected function get placedItems():uint
		{
			var n:uint = 0;

			for each (var drag:Drag in _drags)
			{
				if (drag.isPlacedOn != null) n++;
			}

			return n;
		}
	}
}