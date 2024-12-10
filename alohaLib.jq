def alohaFlagName2FlagArg(Name): (
{
	  "BaselineT1NiftiTrimmed": "-b"
	, "BaselineT2Nifti": "-c"
	, "BaselineT1LeftSegmentation": "-r" 
	, "BaselineT1RightSegmentation": "-s"
	, "BaselineT2LeftSegmentation": "-t"
	, "BaselineT2RightSegmentation": "-u"
	, "FollowupT1NiftiTrimmed": "-f"
	, "FollowupT2Nifti": "-g"
} as $FlagName2FlagArgJson
| ($FlagName2FlagArgJson[Name])
);

