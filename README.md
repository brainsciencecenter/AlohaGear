# AlohaGear

## Function
Gear calculates  annualized hippocampal atrophy rate for given subject or for all subjects in a project

## Citation
Neuroimage 2012 Apr 2;60(2):1266-79.  doi: 10.1016/j.neuroimage.2012.01.098. Epub 2012 Jan 28.

Measuring longitudinal change in the hippocampal formation from in vivo high-resolution T2-weighted MRI
Sandhitsu R Das, Brian B Avants, John Pluta, Hongzhi Wang, Jung W Suh, Michael W Weiner, Susanne G Mueller, Paul A Yushkevich

Affiliation: Penn Image Computing and Science Laboratory (PICSL), 
Department of Radiology, 
University of Pennsylvania, 
Philadelphia, PA, USA

sudas@seas.upenn.edu

PMID: 22306801 PMCID: PMC3667607 DOI: 10.1016/j.neuroimage.2012.01.098",

## Setup

Aloha uses T1 and T2 scans to calculate the hippocampus volumes.  The T1 and T2 scan acquisition files for each subject must be tagged with

```
AlohaInput
```

## Input
To run the gear, select any file in the subject hierarchy.  The Aloha gear will find all sessions within that subject which have been tagged, sort them by scan date to establish baseline and followup sessions, and then calculate the hippocampus volumes.  Finally, it will calculate the volumes and date differences to estimate an annualized atrophy rate.

## Configuration

### Scope
Aloha can run on a Subject or an entire project.  By default, Aloha is only run on a given subject.

### Stages
The Aloha gear works in two stages.  It first checks and prepares the T1 and T2 scans, runs Ashs with the PMC-T1 and PMC-T2 atlases.  Secondly, it runs the Alohabackend gear to actually calculate the hippocampus atrophy.  The backend calculations are substantial enough that it seems reasonable to make sure the input scans are all prepared and ready to to.  Aloha will not re-run Ashs if it can avoid it.

The choices here are
* AlohaT1T2TaggingReport
* VerifyAlohaInputs
* RunAloha
* CalculateAtrophyRates
* VerifyAlohaInputs,RunAloha

**AlohaT1T2TaggingReport** looks through the project and identifies the tagged T1 and T2 scans so the reviewer can verify which scans Aloha will use.

**VerifyAlohaInputs** will run through the specified subject or project, run Ashs on the tagged scans and verify there is a baseline and at least one followup session.  The Aloha gear will generate a AlohaInputs.json file for each subject it is run on.

**RunAloha** is used after VerifyAlohaInputs has been run successfully.  The Aloha gear reads the subject AlohaInputs.json file, and starts the AlohaBackend gear on those inputs.  Hippocampus measurements are stored in the subject volumes_left.txt and volume_right.txt files.  These are csv files with the scan dates for the baseline and followup sessions.

**CalculateAtrophyRates** uses the volume_left and volume_right files to calculate the atrophy rates.
This is normally done as part of the RunAloha stage.

**VerifyAlohaInputs,RunAloha** Verifies the T1/T2 scans, runs Ashs and then AlohaBackend, and finally calculates the atrophy rates.

### MachineSize
MachineSize sets the gear tag, and machine size, for subsidiary gears Aloha uses.
The currently supported sizes are default, extra-large and supersize.  These roughly correlate to 2 cores and 14G of RAM, 8 cores and 32G of RAM and 32 cores and 128G of RAM.
The Aloha gear itself, doesn't need much in the way of processing power, but it hands work off to the Ashs gear, whose running time is directly proportional to the number of cores available, and the Alohabackend geear to calculate the hippocampus volumes using the T1 and T2 scans.

### Output
The Aloha gear leaves a subject csv file.  The file is name

```
${SubjectLabel}AtrophyRates.csv
```

where ${SubjectLabe} is the label of the Subject.
