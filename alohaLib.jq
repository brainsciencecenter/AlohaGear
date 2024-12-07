def alohaFlagName2FlagArg(Name): (
{
	  "BaselineT1NiftiTrimmed": "-b"
	, "BaselineT2Nifti": "-c"
	, "BaselineT1LeftSegmentationFile": "-r" 
	, "BaselineT1RightSegmentationFile": "-s"
	, "BaselineT2LeftSegmentationFile": "-t"
	, "BaselineT2RightSegmentationFile": "-u"
	, "FollowupT1NiftiTrimmed": "-f"
	, "FollowupT2Nifti": "-g"
} as $FlagName2FlagArgJson
| ($FlagName2FlagArgJson[Name])
);

