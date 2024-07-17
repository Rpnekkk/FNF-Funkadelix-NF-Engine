package options;

import openfl.Lib;
import lime.app.Application;
import backend.MusicBeatState;

import flixel.addons.transition.FlxTransitionableState;

import shaders.ColorblindFilter;

import objects.screen.FPS;

class Option
{
	public function new()
	{
	    disable_O = OptionsName.funcDisable();
	    enable_O = OptionsName.funcEnable();
	    MS_O = OptionsName.funcMS();
	    grid_O = OptionsName.funcGrid();
		display = updateDisplay();
	}

	private var description:String = "";
	private var display:String;
	
	private var acceptValues = false;
	
	private var disable_O:String = '';
	private var enable_O:String = '';
	private var MS_O:String = '';
	private var grid_O:String = '';
    
    //public var onChange:Void->Void = null;
    
	public var acceptType = false;

	public var waitingType = false;
	
	public function change():Void
	{
	    //nothing
	}

	public final function getDisplay():String
	{
		return display;
	}

	public final function getAccept()
	{
		return acceptValues;
	}

	public final function getDescription():String
	{
		return description;
	}

	public function getValue():String
	{
		return updateDisplay();
	};

	public function onType(text:String)
	{
	
	}

	// Returns whether the label is to be updated.
	public function press()
	{
	
    }
	
	public function left()
	{
		return;
	}

	public function right()
	{
		return;
	}
	
	private function updateDisplay():String
	{
		return "";
	}
}

//----------------------------------------------------------------
//----------------------------------------------------------------
//----------------------------------------------------------------
//大类1
class Downscroll extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	override function press()
	{
		
		ClientPrefs.data.downScroll = !ClientPrefs.data.downScroll;
		display = updateDisplay();
    }

	private override function updateDisplay():String
	{
		return "DownScroll" + ": " + (ClientPrefs.data.downScroll ? enable_O : disable_O);
	}
}

class MiddleScroll extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	override function press()
	{
		
		ClientPrefs.data.middleScroll = !ClientPrefs.data.middleScroll;
		display = updateDisplay();
    }

	private override function updateDisplay():String
	{
		return "Middle Scroll: " + (ClientPrefs.data.middleScroll ? enable_O : disable_O);
	}
}

class FilpChart extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	override function press()
	{
		
		ClientPrefs.data.filpChart = !ClientPrefs.data.filpChart;
		display = updateDisplay();
    }

	private override function updateDisplay():String
	{
		return "Filp Chart: " + (ClientPrefs.data.filpChart ? enable_O : disable_O);
	}
}

class GuitarHeroSustains extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	override function left()
	{
		ClientPrefs.data.guitarHeroSustains = !ClientPrefs.data.guitarHeroSustains;
		display = updateDisplay();
    }
    
    override function right()
    {left();
    }
    
	private override function updateDisplay():String
	{
		return "Sustains Note Input: < " + (ClientPrefs.data.guitarHeroSustains ? 'New' : 'Classic') + ' >';
	}
}

class FixLNL extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
		acceptType = true;
	}

	override function left()
	{
		ClientPrefs.data.fixLNL--;
		if (ClientPrefs.data.fixLNL < 0)
			ClientPrefs.data.fixLNL = 0;
		display = updateDisplay();
    }

	override function right()
	{
		ClientPrefs.data.fixLNL++;
		if (ClientPrefs.data.fixLNL > 2)
			ClientPrefs.data.fixLNL = 2;
		display = updateDisplay();
    }

	private override function updateDisplay():String
	{
		return "Long Note Length Reduce: < " + ClientPrefs.data.fixLNL + " Grid >";
	}
}

class GhostTap extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	override function press()
	{
		ClientPrefs.data.ghostTapping = !ClientPrefs.data.ghostTapping;
		display = updateDisplay();
    }

	private override function updateDisplay():String
	{
		return "Ghost Tapping: " + (ClientPrefs.data.ghostTapping ? enable_O : disable_O);
	}
}

class NoReset extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	override function press()
	{
		ClientPrefs.data.noReset = !ClientPrefs.data.noReset;
		display = updateDisplay();
    }

	private override function updateDisplay():String
	{
		return "Reset Button: " + (!ClientPrefs.data.noReset ? enable_O : disable_O);
	}
}

class ResultsScreen extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	override function press()
	{
		
		ClientPrefs.data.resultsScreen = !ClientPrefs.data.resultsScreen;
		display = updateDisplay();
    }

	private override function updateDisplay():String
	{
		return "Results Screen: " + (ClientPrefs.data.resultsScreen ? enable_O : disable_O);
	}
}

class NoteOffset extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	override function press()
	{	
	    OptionsState.instance.openSub('NoteOffsetState');		    
	    			
    }
    
    private override function updateDisplay():String
	{
		return "Note Offset Option";
	}
}

class Judgement extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
		acceptValues = true;
	}

	override function press()
	{
		
							
		var num:Int = 8;	
		OptionsState.instance.selectedCatIndex = num;
		OptionsState.instance.switchCat(OptionsState.instance.options[num], false);
		
    }

	private override function updateDisplay():String
	{
		return "Edit Judgements";
	}
}

//----------------------------------------------------------------
//----------------------------------------------------------------
//----------------------------------------------------------------
//大类2
class NotesState extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	override function press()
	{	
	    OptionsState.instance.openSub('NotesSubState');		    	    			
    }
    
    private override function updateDisplay():String
	{
		return "Note RGB Option";
	}
}

class NoteSkin extends Option
{
    public static var chooseNum:Int;
    
	public function new(desc:String)
	{
		super();
		chooseNum = 0;
		OptionsHelpers.setNoteSkin();		
			description = desc;
	}

	override function left()
	{
		chooseNum--;
		
     	OptionsHelpers.changeNoteSkin();
		display = updateDisplay();
    }

	override function right()
	{
		chooseNum++;
		
        OptionsHelpers.changeNoteSkin();
		display = updateDisplay();
    }
    
    override function change()
	{OptionsState.instance.changeNoteSkin();        
    }
    
	override function getValue():String
	{
		return "Current Noteskin: < " + ClientPrefs.data.noteSkin + " >";
	}
}

class NoteRGB extends Option
{
	public function new(desc:String)
	{
		super();	
		description = desc;
	}

	override function press()
	{
		ClientPrefs.data.noteRGB = !ClientPrefs.data.noteRGB;
		display = updateDisplay();
    }

	private override function updateDisplay():String
	{
		return "Note RGB: " + (ClientPrefs.data.noteRGB ? enable_O : disable_O);
	}
}

class SplashSkin extends Option
{
    public static var chooseNum:Int;
    
	public function new(desc:String)
	{
		super();
		chooseNum = 0;
		OptionsHelpers.setSplashSkin();
		description = desc;
	}

	override function left()
	{		
		chooseNum--;
		
     	OptionsHelpers.changeSplashSkin();
		display = updateDisplay();
    }

	override function right()
	{		
		chooseNum++;
		
        OptionsHelpers.changeSplashSkin();
		display = updateDisplay();
    }

	override function getValue():String
	{
		return "Current SplashSkin: < " + ClientPrefs.data.splashSkin + " >";
	}
}

class SplashRGB extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	override function press()
	{	
		ClientPrefs.data.splashRGB = !ClientPrefs.data.splashRGB;
		display = updateDisplay();
    }

	private override function updateDisplay():String
	{
		return "Splash RGB: " + (ClientPrefs.data.splashRGB ? enable_O : disable_O);
	}
}

class HitSoundType extends Option
{
    public static var chooseNum:Int;
	public function new(desc:String)
	{
		super();
		description = desc;
		OptionsHelpers.setHitSoundType();
	}
	
	override function right()
	{		
		chooseNum++;        
		display = updateDisplay();		
	}

	override function left()
	{
		chooseNum--;        
		display = updateDisplay();	
    }
    
    override function change()
	{
        OptionsHelpers.changeHitSoundType();
    }
    
    private override function updateDisplay():String
	{	    
		return "HitSound Type: < " + ClientPrefs.data.hitsoundType + " >";
	}
}

class HitSound extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
		acceptValues = true;
	}
	
	override function right()
	{
		ClientPrefs.data.hitsoundVolume += 0.1;
		if (ClientPrefs.data.hitsoundVolume > 1)
			ClientPrefs.data.hitsoundVolume = 1;
		ClientPrefs.data.hitsoundVolume = FlxMath.roundDecimal(ClientPrefs.data.hitsoundVolume, 1);
        if (ClientPrefs.data.hitsoundType == ClientPrefs.defaultData.hitsoundType) FlxG.sound.play(Paths.sound('hitsound'), ClientPrefs.data.hitsoundVolume);
		else FlxG.sound.play(Paths.sound('hitsounds/' + ClientPrefs.data.hitsoundType), ClientPrefs.data.hitsoundVolume);
		

	}

	override function left()
	{
		ClientPrefs.data.hitsoundVolume -= 0.1;
		if (ClientPrefs.data.hitsoundVolume < 0)
			ClientPrefs.data.hitsoundVolume = 0;
		ClientPrefs.data.hitsoundVolume = FlxMath.roundDecimal(ClientPrefs.data.hitsoundVolume, 1);
        FlxG.sound.play(Paths.sound('hitsound'), ClientPrefs.data.hitsoundVolume);
    }
    
    private override function updateDisplay():String
	{
	    var data:Float = ClientPrefs.data.hitsoundVolume * 100;
		return "HitSound volume: < " + data + "% >";
	}
}

class CamZoom extends Option
{
	public function new(desc:String)
	{
		super();
        description = desc;
	}

	override function press()
	{
		ClientPrefs.data.camZooms = !ClientPrefs.data.camZooms;
		display = updateDisplay();
    }

	private override function updateDisplay():String
	{
		return "Camera Zooming: " + (ClientPrefs.data.camZooms ? enable_O : disable_O);
	}
}

class ScoreZoom extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	override function press()
	{
		ClientPrefs.data.scoreZoom = !ClientPrefs.data.scoreZoom;
		display = updateDisplay();
    }

	private override function updateDisplay():String
	{
		return "Score Beat: " + (ClientPrefs.data.scoreZoom ? enable_O : disable_O);
	}
}

class JudgementCounter extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	override function press()
	{
		ClientPrefs.data.judgementCounter = !ClientPrefs.data.judgementCounter;
		display = updateDisplay();
    }

	private override function updateDisplay():String
	{
		return "Judgement Counter: " + (ClientPrefs.data.judgementCounter ? 'Show' : 'Hide');
	}
}

class HideHud extends Option
{
	public function new(desc:String)
	{
		super();        
		description = desc;

	}

	override function press()
	{//if (OptionsState.onPlayState)
		//	return;
		ClientPrefs.data.hideHud = !ClientPrefs.data.hideHud;

		if (Type.getClass(FlxG.state) == PlayState){

		/*PlayState.instance.healthBarBG.visible = !ClientPrefs.data.hideHud;
		PlayState.instance.healthBar.visible = !ClientPrefs.data.hideHud;
		PlayState.instance.healthBarWN.visible = !ClientPrefs.data.hideHud;
		PlayState.instance.healthStrips.visible  = !ClientPrefs.data.hideHud;
		PlayState.instance.iconP1.visible = !ClientPrefs.data.hideHud;
		PlayState.instance.iconP2.visible = !ClientPrefs.data.hideHud;
		PlayState.instance.songTxt.visible = !(ClientPrefs.data.hideHud || !ClientPrefs.data.songNameDisplay);
		PlayState.instance.scoreTxt.visible = (!ClientPrefs.data.hideHud && !PlayState.instance.cpuControlled);

		PlayState.instance.judgementCounter.visible = (ClientPrefs.data.showJudgement && !ClientPrefs.data.hideHud && !PlayState.instance.cpuControlled);

		if(!ClientPrefs.data.hideHud)
			for (helem in [PlayState.instance.healthBar, PlayState.instance.iconP1, PlayState.instance.iconP2, PlayState.instance.healthBarWN, PlayState.instance.healthBarBG, PlayState.instance.healthStrips]) {
				if (helem != null) {
					helem.visible = ClientPrefs.data.visibleHealthbar;
			}  
		}*/

	    }
		display = updateDisplay();
    }

	private override function updateDisplay():String
	{
		return "HUD: " + (ClientPrefs.data.hideHud ? 'Hide' : 'Show');
	}
}

class HideOppStrums extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	override function press()
	{
		ClientPrefs.data.opponentStrums = !ClientPrefs.data.opponentStrums;
		display = updateDisplay();
    }

	private override function updateDisplay():String
	{
		return "Opponent Strums: " + (!ClientPrefs.data.opponentStrums ? 'Hide' : 'Show');
	}
}

class ShowComboNum extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	override function press()
	{
		ClientPrefs.data.showComboNum = !ClientPrefs.data.showComboNum;
		display = updateDisplay();
    }

	private override function updateDisplay():String
	{
		return "Combo Sprite: " + (ClientPrefs.data.showComboNum ? 'Show' : 'Hide');
	}
}

class ComboColor extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
		acceptValues = true;
	}

	override function press()
	{
		ClientPrefs.data.comboColor = !ClientPrefs.data.comboColor;
		display = updateDisplay();
	}
	
	private override function updateDisplay():String
	{
		return "Combe Color: " + (ClientPrefs.data.comboColor ? enable_O : disable_O);
	}
}

class ComboOffset extends Option
{
	public function new(desc:String)
	{
		super();
        description = desc;
	}

	override function press()
	{
		
		ClientPrefs.data.comboOffsetFix = !ClientPrefs.data.comboOffsetFix;
		display = updateDisplay();
    }

	private override function updateDisplay():String
	{
		return "Combo Offset Fix: " + (ClientPrefs.data.comboOffsetFix ? enable_O : disable_O);
	}
}

class ShowRating extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	override function press()
	{
		ClientPrefs.data.showRating = !ClientPrefs.data.showRating;
		display = updateDisplay();
    }

	private override function updateDisplay():String
	{
		return "Rating Sprite: " + (ClientPrefs.data.showRating ? 'Show' : 'Hide');
	}
}

class ShowSplashes extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	override function press()
	{ClientPrefs.data.showSplash = !ClientPrefs.data.showSplash;
		display = updateDisplay();
    }

	private override function updateDisplay():String
	{
		return "Splash: " + (ClientPrefs.data.showSplash ? 'Show' : 'Hide');
	} 
}

class SplashAlpha extends Option
{
	public function new(desc:String)
	{
		super();

		description = desc;
		acceptValues = true;
	}

	override function right()
	{
		ClientPrefs.data.splashAlpha += 0.1;
		if (ClientPrefs.data.splashAlpha > 1)
			ClientPrefs.data.splashAlpha = 1;
		
		ClientPrefs.data.splashAlpha = FlxMath.roundDecimal(ClientPrefs.data.splashAlpha, 1);	
    }

	override function left()
	{
		ClientPrefs.data.splashAlpha -= 0.1;

		if (ClientPrefs.data.splashAlpha < 0)
			ClientPrefs.data.splashAlpha = 0;
		
		ClientPrefs.data.splashAlpha = FlxMath.roundDecimal(ClientPrefs.data.splashAlpha, 1);
    }

	private override function updateDisplay():String
	{
	    var data:Float = ClientPrefs.data.splashAlpha * 100;
		return "Splash Alpha: < " + data + "% >";
	}
}

class HealthBarAlpha extends Option
{
	public function new(desc:String)
	{
		super();

		description = desc;
		acceptValues = true;
	}

	override function right()
	{
		ClientPrefs.data.healthBarAlpha += 0.1;
		if (ClientPrefs.data.healthBarAlpha > 1)
			ClientPrefs.data.healthBarAlpha = 1;
		ClientPrefs.data.healthBarAlpha = FlxMath.roundDecimal(ClientPrefs.data.healthBarAlpha, 1);
		
		if (Type.getClass(FlxG.state) == PlayState){
		/*PlayState.instance.healthBarBG.alpha = ClientPrefs.data.healthBarAlpha;
		PlayState.instance.healthBar.alpha = ClientPrefs.data.healthBarAlpha;
		PlayState.instance.healthBarWN.alpha = ClientPrefs.data.healthBarAlpha;
		PlayState.instance.healthStrips.alpha = ClientPrefs.data.healthBarAlpha;
		PlayState.instance.iconP1.alpha = ClientPrefs.data.healthBarAlpha;
		PlayState.instance.iconP2.alpha = ClientPrefs.data.healthBarAlpha;*/
		}
    }

	override function left()
	{
		ClientPrefs.data.healthBarAlpha -= 0.1;
		if (ClientPrefs.data.healthBarAlpha < 0)
			ClientPrefs.data.healthBarAlpha = 0;
		ClientPrefs.data.healthBarAlpha = FlxMath.roundDecimal(ClientPrefs.data.healthBarAlpha, 1);
		
		if (Type.getClass(FlxG.state) == PlayState){
		/*PlayState.instance.healthBarBG.alpha = ClientPrefs.data.healthBarAlpha;
		PlayState.instance.healthBar.alpha = ClientPrefs.data.healthBarAlpha;
		PlayState.instance.healthBarWN.alpha = ClientPrefs.data.healthBarAlpha;
		PlayState.instance.healthStrips.alpha = ClientPrefs.data.healthBarAlpha;
		PlayState.instance.iconP1.alpha = ClientPrefs.data.healthBarAlpha;
		PlayState.instance.iconP2.alpha = ClientPrefs.data.healthBarAlpha;*/
		}
    }

	private override function updateDisplay():String
	{
	    var data:Float = ClientPrefs.data.healthBarAlpha * 100;
		return "Healthbar Alpha: < " + data + "% >";
	}
}

class HealthBarVersion extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	override function left()
	{ClientPrefs.data.oldHealthBarVersion = !ClientPrefs.data.oldHealthBarVersion;
		display = updateDisplay();
    }
    
    override function right()
	{left();
    }

	private override function updateDisplay():String
	{
		return "HealthBar Version: < " + (ClientPrefs.data.oldHealthBarVersion ? '0.6.X' : '0.7.X') +' >';
	} 
}

class TimeBarType extends Option
{
    public static var chooseNum:Int;
	public function new(desc:String)
	{
		super();
        description = desc;
        OptionsHelpers.setTimeBarType();
	}

	override function left()
	{
		chooseNum--;
		display = updateDisplay();				
    }

	override function right()
	{   
	    chooseNum++;        
		display = updateDisplay();				
    }
    
    override function change()
	{
        OptionsHelpers.changeTimeBarType();
    }
	override function getValue():String
	{
		return "Time bar type: < " + ClientPrefs.data.timeBarType + " >";
	}
}

//----------------------------------------------------------------
//----------------------------------------------------------------
//----------------------------------------------------------------
//大类3
class HscriptVersion extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	override function left()
	{ClientPrefs.data.oldHscriptVersion = !ClientPrefs.data.oldHscriptVersion;
		display = updateDisplay();
    }
    
    override function right()
	{left();
    }

	private override function updateDisplay():String
	{
		return "Runhaxecode Version: < " + (ClientPrefs.data.oldHscriptVersion ? 'HScript' : 'Sscript') + ' >';
	} 
}

class PauseMusic extends Option
{
    public static var chooseNum:Int;
	public function new(desc:String)
	{
		super();
		description = desc;
		OptionsHelpers.setPauseMusicType();
	}

	override function left()
	{
	    chooseNum--;
	    OptionsHelpers.changePauseMusicType();
    }

	override function right()
	{
	    chooseNum++;
	    OptionsHelpers.changePauseMusicType();
    }

	private override function updateDisplay():String
	{
		return "Pause Music: < " + ClientPrefs.data.pauseMusic + " >";
	}
}

class PauseButton extends Option
{
    public static var chooseNum:Int;
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	override function press()
	{
		ClientPrefs.data.pauseButton = !ClientPrefs.d
