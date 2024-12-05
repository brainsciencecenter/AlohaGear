def alohaFlagName2FlagArg(Name): (
{
	  "BaselineT1NiftiTrimmed": "-b"
	, "BaselineT2Nifti": "-c"
	, "BaselineT1LeftSegmentationFile": "-r" 
	, "BaselineT1RightSegmentationFile": "-s"
	, "BaselineT2LeftSegmentationFile": "-t"
	, "BaselineT2RightSegmentationFile": "-u"
} as $FlagName2FlagArgJson
| ($FlagName2FlagArgJson[Name])
);

